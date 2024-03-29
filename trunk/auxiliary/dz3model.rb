# -*- encoding : utf-8 -*-
require 'active_support/all'
%w{
pre_common_admincp_cmenu
pre_common_admincp_group
pre_common_admincp_member
pre_common_admincp_perm
pre_common_admincp_session
pre_common_admingroup
pre_common_adminnote
pre_common_advertisement
pre_common_advertisement_custom
pre_common_banned
pre_common_block
pre_common_block_favorite
pre_common_block_item
pre_common_block_item_data
pre_common_block_permission
pre_common_block_pic
pre_common_block_style
pre_common_block_xml
pre_common_cache
pre_common_card
pre_common_card_log
pre_common_card_type
pre_common_connect_guest
pre_common_credit_log
pre_common_credit_rule
pre_common_credit_rule_log
pre_common_credit_rule_log_field
pre_common_cron
pre_common_district
pre_common_diy_data
pre_common_domain
pre_common_failedlogin
pre_common_friendlink
pre_common_grouppm
pre_common_invite
pre_common_magic
pre_common_magiclog
pre_common_mailcron
pre_common_mailqueue
pre_common_member
pre_common_member_action_log
pre_common_member_connect
pre_common_member_count
pre_common_member_crime
pre_common_member_field_forum
pre_common_member_field_home
pre_common_member_grouppm
pre_common_member_log
pre_common_member_magic
pre_common_member_medal
pre_common_member_profile
pre_common_member_profile_setting
pre_common_member_security
pre_common_member_status
pre_common_member_stat_field
pre_common_member_validate
pre_common_member_verify
pre_common_member_verify_info
pre_common_myapp
pre_common_myinvite
pre_common_mytask
pre_common_nav
pre_common_onlinetime
pre_common_patch
pre_common_plugin
pre_common_pluginvar
pre_common_process
pre_common_regip
pre_common_relatedlink
pre_common_report
pre_common_searchindex
pre_common_secquestion
pre_common_session
pre_common_setting
pre_common_smiley
pre_common_sphinxcounter
pre_common_stat
pre_common_statuser
pre_common_style
pre_common_stylevar
pre_common_syscache
pre_common_tag
pre_common_tagitem
pre_common_task
pre_common_taskvar
pre_common_template
pre_common_template_block
pre_common_template_permission
pre_common_uin_black
pre_common_usergroup
pre_common_usergroup_field
pre_common_word
pre_common_word_type
pre_connect_disktask
pre_connect_feedlog
pre_connect_memberbindlog
pre_connect_tthreadlog
pre_forum_access
pre_forum_activity
pre_forum_activityapply
pre_forum_announcement
pre_forum_attachment
pre_forum_attachment_0
pre_forum_attachment_1
pre_forum_attachment_2
pre_forum_attachment_3
pre_forum_attachment_4
pre_forum_attachment_5
pre_forum_attachment_6
pre_forum_attachment_7
pre_forum_attachment_8
pre_forum_attachment_9
pre_forum_attachment_exif
pre_forum_attachment_unused
pre_forum_attachtype
pre_forum_bbcode
pre_forum_collection
pre_forum_collectioncomment
pre_forum_collectionfollow
pre_forum_collectioninvite
pre_forum_collectionrelated
pre_forum_collectionteamworker
pre_forum_collectionthread
pre_forum_creditslog
pre_forum_debate
pre_forum_debatepost
pre_forum_faq
pre_forum_forum
pre_forum_forumfield
pre_forum_forumrecommend
pre_forum_forum_threadtable
pre_forum_groupcreditslog
pre_forum_groupfield
pre_forum_groupinvite
pre_forum_grouplevel
pre_forum_groupuser
pre_forum_imagetype
pre_forum_medal
pre_forum_medallog
pre_forum_memberrecommend
pre_forum_moderator
pre_forum_modwork
pre_forum_onlinelist
pre_forum_order
pre_forum_poll
pre_forum_polloption
pre_forum_pollvoter
pre_forum_post
pre_forum_postcache
pre_forum_postcomment
pre_forum_postlog
pre_forum_poststick
pre_forum_post_location
pre_forum_post_moderate
pre_forum_post_tableid
pre_forum_promotion
pre_forum_ratelog
pre_forum_relatedthread
pre_forum_replycredit
pre_forum_rsscache
pre_forum_spacecache
pre_forum_statlog
pre_forum_thread
pre_forum_threadaddviews
pre_forum_threadclass
pre_forum_threadclosed
pre_forum_threaddisablepos
pre_forum_threadimage
pre_forum_threadlog
pre_forum_threadmod
pre_forum_threadpartake
pre_forum_threadpreview
pre_forum_threadrush
pre_forum_threadtype
pre_forum_thread_moderate
pre_forum_trade
pre_forum_tradecomment
pre_forum_tradelog
pre_forum_typeoption
pre_forum_typeoptionvar
pre_forum_typevar
pre_forum_warning
pre_home_album
pre_home_album_category
pre_home_appcreditlog
pre_home_blacklist
pre_home_blog
pre_home_blogfield
pre_home_blog_category
pre_home_blog_moderate
pre_home_class
pre_home_click
pre_home_clickuser
pre_home_comment
pre_home_comment_moderate
pre_home_docomment
pre_home_doing
pre_home_doing_moderate
pre_home_favorite
pre_home_feed
pre_home_feed_app
pre_home_follow
pre_home_follow_feed
pre_home_follow_feed_archiver
pre_home_friend
pre_home_friendlog
pre_home_friend_request
pre_home_notification
pre_home_pic
pre_home_picfield
pre_home_pic_moderate
pre_home_poke
pre_home_pokearchive
pre_home_share
pre_home_share_moderate
pre_home_show
pre_home_specialuser
pre_home_userapp
pre_home_userappfield
pre_home_visitor
pre_portal_article_content
pre_portal_article_count
pre_portal_article_moderate
pre_portal_article_related
pre_portal_article_title
pre_portal_article_trash
pre_portal_attachment
pre_portal_category
pre_portal_category_permission
pre_portal_comment
pre_portal_comment_moderate
pre_portal_rsscache
pre_portal_topic
pre_portal_topic_pic
pre_security_evilpost
pre_security_eviluser
pre_security_failedlog
pre_ucenter_admins
pre_ucenter_applications
pre_ucenter_badwords
pre_ucenter_domains
pre_ucenter_failedlogins
pre_ucenter_feeds
pre_ucenter_friends
pre_ucenter_mailqueue
pre_ucenter_memberfields
pre_ucenter_members
pre_ucenter_mergemembers
pre_ucenter_newpm
pre_ucenter_notelist
}.each do |filename0|
  filename = "./#{filename0}.rb"
  if File.exists?(filename)
    puts "#{filename} exists" 
    next
  end
  filename = filename[2..-1]
  claname = filename.split('_').collect{|x| x[0]=x[0].upcase;x}.join('')
  File.open(filename,"w") do |f|
    f.puts("class #{claname[0..-4]} < ActiveRecord::Base")
    f.puts("  set_table_name '#{filename[0..-4]}'")
    f.puts("end")
  end
  puts "{filename} created!!!"
end
