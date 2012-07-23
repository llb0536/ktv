var asks=[];
var points={};
function sortgg(a,b){return points[b]-points[a]}
function samelist(a,b){
    var c=0;
    for(var i=0;i<a.length;i++){
        if(b.indexOf(a[i])!=-1){
            c++;
        }
    }
    return c;
}
function get_asa(ask){
   var now=new Date();
   var stime=(now.getFullYear()-1)+","+(now.getMonth()-1)+","+now.getDate();
   var time=new Date(stime);
   db.asks.find({topics:{$in:ask.topics},_id:{$ne:ask._id}}).forEach( function(a){
       asks.push(a._id);
       points[a._id]=samelist(a.topics,ask.topics)
       if(a.answers_count>3){
           points[a._id]=points[a._id]*3;
       }else if(a.answers_count>0){
           points[a._id]=points[a._id]*a.answers_count;
       }
       var ans=db.answers.find({ask_id:a._id}).sort({vote_up_count:-1})[0];
       if(ans){
           if(ans.vote_up_count){
               if(ans.vote_up_count>8){
                   points[a._id]=points[a._id]*8;
               }else{
                   points[a._id]=points[a._id]*ans.vote_up_count;
               }
           }
       }
       if(a.created_at<time){
           points[a._id]=points[a._id]*0.5;
       }
   });
   var asa=db.ask_suggest_asks.findOne({ask_id:ask._id})
   if(asa){
       asa.ask_ids=asks.sort(sortgg).slice(0,10);
       db.ask_suggest_asks.save(asa);
   }else{
       asa={
           "ask_ids":asks.sort(sortgg).slice(0,10),
           "ask_id":ask._id
       }
       db.ask_suggest_asks.save(asa);
   }
   return asks.sort(sortgg).slice(0,10);
}

db.asks.find({deleted:{$ne:1}}).forEach( function(a) {
   get_asa(a);
   asks=[];
   points={};
});







