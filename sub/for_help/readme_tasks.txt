发送邮件-----------------------------------
rake mail:sendpack
rake mail:sendpack_expert


# this task will update 3 caches
# TopicCache
# ExpertCache
# AskCache

僵尸粉-----------------------------------
（先保证列表在auxiliary/zombies.txt）
rake experts:zombify

Statistics----------------------------
stat:weekly
stat:monthly
stat:csv

rake db:mongoid:create_indexes



recreate avatars and covers---------------------

integrity---------------------------------------
integrity:op

=== execute all duplication jobs on all related instances===
update:cache
update:duplication
update:pic
rake update:cache;rake update:duplication;rake update:pic

=== naughty naughty naughty words! ====
rake naughty:words
rake integrity:op
rake suggest:topic_topics
rake suggest:topic_experts
rake suggest:ask_asks
rake suggest:user