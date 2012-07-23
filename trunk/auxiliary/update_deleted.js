function update_ask_deleted() {
    var u=db.users.findOne({
        slug:"angelacai"
    })
    db.asks.find({
        deleted:1
    }).forEach( function(a) {
        a.deletor_id=u._id;
        a.deleted_at=a.updated_at;
        db.asks.save(a);
    });
}
function update_answer_deleted() {
    var u=db.users.findOne({
        slug:"angelacai"
    })
    db.answers.find({
        deleted:1
    }).forEach( function(a) {
        a.deletor_id=u._id;
        a.deleted_at=a.updated_at;
        db.asks.save(a);
    });
}
function update_comment_deleted() {
    var u=db.users.findOne({
        slug:"angelacai"
    })
    db.comments.find({
        deleted:1
    }).forEach( function(a) {
        a.deletor_id=u._id;
        a.deleted_at=a.updated_at;
        db.asks.save(a);
    });
}
function update_notification_deleted(){
    db.notifications.find().forEach(function(n){
        var c=db.logs.findOne({
            _id:n.log_id
            });
        if(c==null){
            n.deleted=NumberInt(1);
            db.notifications.save(n);
        }
    });
}
update_ask_deleted();
update_answer_deleted();
update_comment_deleted();
update_notification_deleted();
