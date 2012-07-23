function update_user_count() {
    arr=["xin.yu@kejian.tv.cn","sally.jiang@kejian.tv.cn","zhangxi8288@163.com","pmq2001@gmail.com","yunlong.lee@msn.com","11123275@qq.com","angela.cai@kejian.tv.cn","lizi7@vip.qq.com","hkongm@163.com","jamie.liu@kejian.tv.cn","zl_terry@126.com"]
db.users.find({deleted:{$ne:1}}).forEach( function(u) {
        try{
    u.asks_count=NumberInt(db.asks.find({user_id:u._id,deleted:{$ne:1}}).count());
            u.answers_count = NumberInt(u.answered_ask_ids.length);
    u.comments_count=NumberInt(db.comments.find({user_id:u._id,deleted:{$ne:1}}).count());
            u.followers_count=NumberInt(u.follower_ids.length);
            u.login_times=NumberInt(1);
            u.last_login_at=u.created_at;
            if(u.is_expert){
                u.user_type=NumberInt(2);
            }else{
                u.user_type=NumberInt(1);
            }
            if(arr.indexOf(u.email)>0){
                u.admin_type=NumberInt(2);
            }else{
                u.admin_type=NumberInt(1);
            }
            db.users.save(u);
        }catch(e){

        }
    });
}
function update_mobile() {
    db.logs.find().forEach( function(l) {
        try{
            l.from_mobile=NumberInt(0);
            db.logs.save(l);
        }catch(e){

        }
    });
    
    db.users.find({deleted:{$ne:1}}).forEach(function(u){
        try{
            u.created_from_mobile=NumberInt(0);
            db.users.save(u);
        }catch(e){

        }
    });
}

function update_ask_count() {
    db.asks.find({deleted:{$ne:1}}).forEach( function(a) {
    a.answers_count=NumberInt(db.answers.find({ask_id:a._id,deleted:{$ne:1}}).count());
    a.comments_count=NumberInt(db.comments.find({commentable_id:a._id,commentable_type:"Ask",deleted:{$ne:1}}).count());
        a.followed_count=NumberInt(a.follower_ids.length);
        db.asks.save(a);
    });
}

function update_answer_count() {
    db.answers.find({deleted:{$ne:1}}).forEach( function(a) {
        if(a.votes){
            if(a.votes.up_count){
                a.vote_up_count=NumberInt(a.votes.up_count);
            }else{
                a.vote_up_count=NumberInt(0);
            }
            if(a.votes.down_count){
                a.vote_down_count=NumberInt(a.votes.down_count)
            }else{
                a.vote_down_count=NumberInt(0);
            }
        }else{
            a.vote_up_count=NumberInt(0);
            a.vote_down_count=NumberInt(0);
        }
    a.comments_count=NumberInt(db.comments.find({commentable_id:a._id,commentable_type:"Answer",deleted:{$ne:1}}).count());
        a.spams_count=NumberInt(a.spam_voter_ids.length);
        a.thanked_count=NumberInt(0);
        db.answers.save(a);
    });
}

function update_topic_count() {
    db.topics.find({deleted:{$ne:1}}).forEach( function(t) {
        t.followed_count=NumberInt(t.follower_ids.length);
    t.asks_count=NumberInt(db.asks.find({topics:t.name,deleted:{$ne:1}}).count());
        db.topics.save(t);
    });
}

function update_word_count() {
    var t=db.topics.find()[0].created_at;
    db.naughty_words.find().forEach( function(w) {
        w.deleted=NumberInt(0);
        w.level=NumberInt(1);
        w.created_at=t;
        db.naughty_words.save(w);
    });
}

function update_notice_time() {
    db.notices.find().forEach( function(n) {
        n.start_at=n.created_at;
        db.notices.save(n);
    });
}
function update_answered_ask(){
db.users.find({is_expert:true,deleted:{$ne:1}}).forEach( function(u) {
        try{
         var arr=[];
         db.answers.find({user_id:u._id,deleted:{$ne:1}}).forEach(function(a){
             arr.push(a.ask_id);
         });
            u.answered_ask_ids=arr;
            db.users.save(u);
        }catch(e){
        }
    });

}

update_user_count();
update_ask_count();
update_answer_count();
update_topic_count();
update_word_count();
update_notice_time();
update_mobile();
update_answered_ask();

