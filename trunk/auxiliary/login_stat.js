//   /usr/local/mongodb/bin/mongo 192.168.2.229/quora_development --shell auxiliary/login_stat.js
function get_login_stat(start_time,end_time){    //"2011,6,8","2012,6,8"
    var start=new Date(start_time);
    var end=new Date(end_time);
    var date=new Date("2012,6,18");
    var user_arr=[];
    db.users.find({created_at:{$gt:date}}).forEach( function(u){
        user_arr.push(u._id.toString());
    });
    var user_count=0;
    var login_count_0=0;
    var login_count_30=0;
    var login_count_60=0;
    var login_count_90=0;
    var login_count_120=0;
    var login_count_150=0;
    var login_count_180=0;
    var login_count_210=0;
    var login_count_240=0;
    var login_count_270=0;
    var login_count_300=0;
    var login_count_330=0;
    var login_count_360=0;
    
    var arr=[];
    var str=[];
    
    db.login_logs.find({login_at:{$gt:start,$lt:end},range:0}).forEach( function(l){
        if(user_arr.indexOf(l.user_id.toString())!=-1){
        login_count_0+=1;
        if(arr.indexOf(l.user_id.toString())==-1){
            user_count=arr.push(l.user_id.toString());
        }   
        }
    });
    if(user_count==0){
        var mean_count_0=0;
    }else{
        var mean_count_0=Math.round(login_count_0/user_count);
    }
    arr=[];
    str.push(user_count+":"+mean_count_0);
    user_count=0;
    
    db.login_logs.find({login_at:{$gt:start,$lt:end},range:{$gt:0,$lte:30}}).forEach( function(l){
        if(user_arr.indexOf(l.user_id.toString())!=-1){
        login_count_30+=1;
        if(arr.indexOf(l.user_id.toString())==-1){
            user_count=arr.push(l.user_id.toString());
        }
        }
    });
    if(user_count==0){
        var mean_count_30=0;
    }else{
        var mean_count_30=Math.round(login_count_30/user_count);
    }
    arr=[];
    str.push(user_count+":"+mean_count_30);
    user_count=0;
    
    db.login_logs.find({login_at:{$gt:start,$lt:end},range:{$gt:30,$lte:60}}).forEach( function(l){
        if(user_arr.indexOf(l.user_id.toString())!=-1){
        login_count_60+=1;
        if(arr.indexOf(l.user_id.toString())==-1){
            user_count=arr.push(l.user_id.toString());
        }
        }
    });
    if(user_count==0){
        var mean_count_60=0;
    }else{
        var mean_count_60=Math.round(login_count_60/user_count);
    }
    arr=[];
    str.push(user_count+":"+mean_count_60);
    user_count=0;
    
    db.login_logs.find({login_at:{$gt:start,$lt:end},range:{$gt:60,$lte:90}}).forEach( function(l){
        if(user_arr.indexOf(l.user_id.toString())!=-1){
        login_count_90+=1;
        if(arr.indexOf(l.user_id.toString())==-1){
            user_count=arr.push(l.user_id.toString());
        }
        }
    });
    if(user_count==0){
        var mean_count_90=0;
    }else{
        var mean_count_90=Math.round(login_count_90/user_count);
    }
    arr=[];
    str.push(user_count+":"+mean_count_90);
    user_count=0;
    
    db.login_logs.find({login_at:{$gt:start,$lt:end},range:{$gt:90,$lte:120}}).forEach( function(l){
        if(user_arr.indexOf(l.user_id.toString())!=-1){
        login_count_120+=1;
        if(arr.indexOf(l.user_id.toString())==-1){
            user_count=arr.push(l.user_id.toString());
        }
        }
    });
    if(user_count==0){
        var mean_count_120=0;
    }else{
        var mean_count_120=Math.round(login_count_120/user_count);
    }
    arr=[];
    str.push(user_count+":"+mean_count_120);
    user_count=0;
    
    db.login_logs.find({login_at:{$gt:start,$lt:end},range:{$gt:120,$lte:150}}).forEach( function(l){
        if(user_arr.indexOf(l.user_id.toString())!=-1){
        login_count_150+=1;
        if(arr.indexOf(l.user_id.toString())==-1){
            user_count=arr.push(l.user_id.toString());
        }
        }
    });
    if(user_count==0){
        var mean_count_150=0;
    }else{
        var mean_count_150=Math.round(login_count_150/user_count);
    }
    arr=[];
    str.push(user_count+":"+mean_count_150);
    user_count=0;
    
    db.login_logs.find({login_at:{$gt:start,$lt:end},range:{$gt:150,$lte:180}}).forEach( function(l){
        if(user_arr.indexOf(l.user_id.toString())!=-1){
        login_count_180+=1;
        if(arr.indexOf(l.user_id.toString())==-1){
            user_count=arr.push(l.user_id.toString());
        }
        }
    });
    if(user_count==0){
        var mean_count_180=0;
    }else{
        var mean_count_180=Math.round(login_count_180/user_count);
    }
    arr=[];
    str.push(user_count+":"+mean_count_180);
    user_count=0;
    
    db.login_logs.find({login_at:{$gt:start,$lt:end},range:{$gt:180,$lte:210}}).forEach( function(l){
        if(user_arr.indexOf(l.user_id.toString())!=-1){
        login_count_210+=1;
        if(arr.indexOf(l.user_id.toString())==-1){
            user_count=arr.push(l.user_id.toString());
        }
        }
    });
    if(user_count==0){
        var mean_count_210=0;
    }else{
        var mean_count_210=Math.round(login_count_210/user_count);
    }
    arr=[];
    str.push(user_count+":"+mean_count_210);
    user_count=0;
    
    db.login_logs.find({login_at:{$gt:start,$lt:end},range:{$gt:210,$lte:240}}).forEach( function(l){
        if(user_arr.indexOf(l.user_id.toString())!=-1){
        login_count_240+=1;
        if(arr.indexOf(l.user_id.toString())==-1){
            user_count=arr.push(l.user_id.toString());
        }
        }
    });
    if(user_count==0){
        var mean_count_240=0;
    }else{
        var mean_count_240=Math.round(login_count_240/user_count);
    }
    arr=[];
    str.push(user_count+":"+mean_count_240);
    user_count=0;
    
    db.login_logs.find({login_at:{$gt:start,$lt:end},range:{$gt:240,$lte:270}}).forEach( function(l){
        if(user_arr.indexOf(l.user_id.toString())!=-1){
        login_count_270+=1;
        if(arr.indexOf(l.user_id.toString())==-1){
            user_count=arr.push(l.user_id.toString());
        }
        }
    });
    if(user_count==0){
        var mean_count_270=0;
    }else{
        var mean_count_270=Math.round(login_count_270/user_count);
    }
    arr=[];
    str.push(user_count+":"+mean_count_270);
    user_count=0;
    
    db.login_logs.find({login_at:{$gt:start,$lt:end},range:{$gt:270,$lte:300}}).forEach( function(l){
        if(user_arr.indexOf(l.user_id.toString())!=-1){
        login_count_300+=1;
        if(arr.indexOf(l.user_id.toString())==-1){
            user_count=arr.push(l.user_id.toString());
        }
        }
    });
    if(user_count==0){
        var mean_count_300=0;
    }else{
        var mean_count_300=Math.round(login_count_300/user_count);
    }
    arr=[];
    str.push(user_count+":"+mean_count_300);
    user_count=0;
    
    db.login_logs.find({login_at:{$gt:start,$lt:end},range:{$gt:300,$lte:330}}).forEach( function(l){
        if(user_arr.indexOf(l.user_id.toString())!=-1){
        login_count_330+=1;
        if(arr.indexOf(l.user_id.toString())==-1){
            user_count=arr.push(l.user_id.toString());
        }
        }
    });
    if(user_count==0){
        var mean_count_330=0;
    }else{
        var mean_count_330=Math.round(login_count_330/user_count);
    }
    user_count=0;
    arr=[];
    str.push(user_count+":"+mean_count_330);
    
    db.login_logs.find({login_at:{$gt:start,$lt:end},range:{$gt:330,$lte:360}}).forEach( function(l){
        if(user_arr.indexOf(l.user_id.toString())!=-1){
        login_count_360+=1;
        if(arr.indexOf(l.user_id.toString())==-1){
            user_count=arr.push(l.user_id.toString());
        }
        }
    });
    if(user_count==0){
        var mean_count_360=0;
    }else{
        var mean_count_360=Math.round(login_count_360/user_count);
    }
        
    str.push(user_count+":"+mean_count_360);
    
    var val=db.setting_items.findOne({key:"kpi_value"});
    val.value=str;
    db.setting_items.save(val);
}

var d = new Date();
var stime=(d.getFullYear()-1)+","+(d.getMonth()+1)+","+d.getDate();
var etime=d.getFullYear()+","+(d.getMonth()+1)+","+d.getDate();
get_login_stat(stime,etime);









