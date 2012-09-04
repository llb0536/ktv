# -*- encoding : utf-8 -*-
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 0) do

  create_table "pre_common_admincp_cmenu", :force => true do |t|
    t.string  "title",                                        :null => false
    t.string  "url",                                          :null => false
    t.boolean "sort",                      :default => false, :null => false
    t.integer "displayorder", :limit => 1,                    :null => false
    t.integer "clicks",       :limit => 2, :default => 1,     :null => false
    t.integer "uid",          :limit => 3,                    :null => false
    t.integer "dateline",                                     :null => false
  end

  add_index "pre_common_admincp_cmenu", ["displayorder"], :name => "displayorder"
  add_index "pre_common_admincp_cmenu", ["uid"], :name => "uid"

  create_table "pre_common_admincp_group", :primary_key => "cpgroupid", :force => true do |t|
    t.string "cpgroupname", :null => false
  end

  create_table "pre_common_admincp_member", :primary_key => "uid", :force => true do |t|
    t.integer "cpgroupid",  :null => false
    t.text    "customperm", :null => false
  end

  create_table "pre_common_admincp_perm", :id => false, :force => true do |t|
    t.integer "cpgroupid", :limit => 2, :null => false
    t.string  "perm",                   :null => false
  end

  add_index "pre_common_admincp_perm", ["cpgroupid", "perm"], :name => "cpgroupperm", :unique => true

  create_table "pre_common_admincp_session", :id => false, :force => true do |t|
    t.integer "uid",        :limit => 3,        :default => 0,     :null => false
    t.integer "adminid",    :limit => 2,        :default => 0,     :null => false
    t.boolean "panel",                          :default => false, :null => false
    t.string  "ip",         :limit => 15,       :default => "",    :null => false
    t.integer "dateline",                       :default => 0,     :null => false
    t.boolean "errorcount",                     :default => false, :null => false
    t.text    "storage",    :limit => 16777215,                    :null => false
  end

  create_table "pre_common_admingroup", :primary_key => "admingid", :force => true do |t|
    t.boolean "alloweditpost",         :default => false, :null => false
    t.boolean "alloweditpoll",         :default => false, :null => false
    t.boolean "allowstickthread",      :default => false, :null => false
    t.boolean "allowmodpost",          :default => false, :null => false
    t.boolean "allowdelpost",          :default => false, :null => false
    t.boolean "allowmassprune",        :default => false, :null => false
    t.boolean "allowrefund",           :default => false, :null => false
    t.boolean "allowcensorword",       :default => false, :null => false
    t.boolean "allowviewip",           :default => false, :null => false
    t.boolean "allowbanip",            :default => false, :null => false
    t.boolean "allowedituser",         :default => false, :null => false
    t.boolean "allowmoduser",          :default => false, :null => false
    t.boolean "allowbanuser",          :default => false, :null => false
    t.boolean "allowbanvisituser",     :default => false, :null => false
    t.boolean "allowpostannounce",     :default => false, :null => false
    t.boolean "allowviewlog",          :default => false, :null => false
    t.boolean "allowbanpost",          :default => false, :null => false
    t.boolean "supe_allowpushthread",  :default => false, :null => false
    t.boolean "allowhighlightthread",  :default => false, :null => false
    t.boolean "allowdigestthread",     :default => false, :null => false
    t.boolean "allowrecommendthread",  :default => false, :null => false
    t.boolean "allowbumpthread",       :default => false, :null => false
    t.boolean "allowclosethread",      :default => false, :null => false
    t.boolean "allowmovethread",       :default => false, :null => false
    t.boolean "allowedittypethread",   :default => false, :null => false
    t.boolean "allowstampthread",      :default => false, :null => false
    t.boolean "allowstamplist",        :default => false, :null => false
    t.boolean "allowcopythread",       :default => false, :null => false
    t.boolean "allowmergethread",      :default => false, :null => false
    t.boolean "allowsplitthread",      :default => false, :null => false
    t.boolean "allowrepairthread",     :default => false, :null => false
    t.boolean "allowwarnpost",         :default => false, :null => false
    t.boolean "allowviewreport",       :default => false, :null => false
    t.boolean "alloweditforum",        :default => false, :null => false
    t.boolean "allowremovereward",     :default => false, :null => false
    t.boolean "allowedittrade",        :default => false, :null => false
    t.boolean "alloweditactivity",     :default => false, :null => false
    t.boolean "allowstickreply",       :default => false, :null => false
    t.boolean "allowmanagearticle",    :default => false, :null => false
    t.boolean "allowaddtopic",         :default => false, :null => false
    t.boolean "allowmanagetopic",      :default => false, :null => false
    t.boolean "allowdiy",              :default => false, :null => false
    t.boolean "allowclearrecycle",     :default => false, :null => false
    t.boolean "allowmanagetag",        :default => false, :null => false
    t.boolean "alloweditusertag",      :default => false, :null => false
    t.boolean "managefeed",            :default => false, :null => false
    t.boolean "managedoing",           :default => false, :null => false
    t.boolean "manageshare",           :default => false, :null => false
    t.boolean "manageblog",            :default => false, :null => false
    t.boolean "managealbum",           :default => false, :null => false
    t.boolean "managecomment",         :default => false, :null => false
    t.boolean "managemagiclog",        :default => false, :null => false
    t.boolean "managereport",          :default => false, :null => false
    t.boolean "managehotuser",         :default => false, :null => false
    t.boolean "managedefaultuser",     :default => false, :null => false
    t.boolean "managevideophoto",      :default => false, :null => false
    t.boolean "managemagic",           :default => false, :null => false
    t.boolean "manageclick",           :default => false, :null => false
    t.boolean "allowmanagecollection", :default => false, :null => false
  end

  create_table "pre_common_adminnote", :force => true do |t|
    t.string  "admin",      :limit => 15, :default => "", :null => false
    t.integer "access",     :limit => 1,  :default => 0,  :null => false
    t.integer "adminid",    :limit => 1,  :default => 0,  :null => false
    t.integer "dateline",                 :default => 0,  :null => false
    t.integer "expiration",               :default => 0,  :null => false
    t.text    "message",                                  :null => false
  end

  create_table "pre_common_advertisement", :primary_key => "advid", :force => true do |t|
    t.boolean "available",                  :default => false, :null => false
    t.string  "type",         :limit => 50, :default => "0",   :null => false
    t.integer "displayorder", :limit => 1,  :default => 0,     :null => false
    t.string  "title",                      :default => "",    :null => false
    t.text    "targets",                                       :null => false
    t.text    "parameters",                                    :null => false
    t.text    "code",                                          :null => false
    t.integer "starttime",                  :default => 0,     :null => false
    t.integer "endtime",                    :default => 0,     :null => false
  end

  create_table "pre_common_advertisement_custom", :force => true do |t|
    t.string "name", :null => false
  end

  add_index "pre_common_advertisement_custom", ["name"], :name => "name"

  create_table "pre_common_banned", :force => true do |t|
    t.integer "ip1",        :limit => 2,  :default => 0,  :null => false
    t.integer "ip2",        :limit => 2,  :default => 0,  :null => false
    t.integer "ip3",        :limit => 2,  :default => 0,  :null => false
    t.integer "ip4",        :limit => 2,  :default => 0,  :null => false
    t.string  "admin",      :limit => 15, :default => "", :null => false
    t.integer "dateline",                 :default => 0,  :null => false
    t.integer "expiration",               :default => 0,  :null => false
  end

  create_table "pre_common_block", :primary_key => "bid", :force => true do |t|
    t.string  "blockclass",                  :default => "0",   :null => false
    t.boolean "blocktype",                   :default => false, :null => false
    t.string  "name",                        :default => "",    :null => false
    t.text    "title",                                          :null => false
    t.string  "classname",                   :default => "",    :null => false
    t.text    "summary",                                        :null => false
    t.integer "uid",            :limit => 3, :default => 0,     :null => false
    t.string  "username",                    :default => "",    :null => false
    t.integer "styleid",        :limit => 2, :default => 0,     :null => false
    t.text    "blockstyle",                                     :null => false
    t.integer "picwidth",       :limit => 2, :default => 0,     :null => false
    t.integer "picheight",      :limit => 2, :default => 0,     :null => false
    t.string  "target",                      :default => "",    :null => false
    t.string  "dateformat",                  :default => "",    :null => false
    t.boolean "dateuformat",                 :default => false, :null => false
    t.string  "script",                      :default => "",    :null => false
    t.text    "param",                                          :null => false
    t.integer "shownum",        :limit => 2, :default => 0,     :null => false
    t.integer "cachetime",                   :default => 0,     :null => false
    t.string  "cachetimerange", :limit => 5, :default => "",    :null => false
    t.boolean "punctualupdate",              :default => false, :null => false
    t.boolean "hidedisplay",                 :default => false, :null => false
    t.integer "dateline",                    :default => 0,     :null => false
    t.boolean "notinherited",                :default => false, :null => false
    t.boolean "isblank",                     :default => false, :null => false
  end

  create_table "pre_common_block_favorite", :primary_key => "favid", :force => true do |t|
    t.integer "uid",      :limit => 3, :default => 0, :null => false
    t.integer "bid",      :limit => 3, :default => 0, :null => false
    t.integer "dateline",              :default => 0, :null => false
  end

  add_index "pre_common_block_favorite", ["uid", "dateline"], :name => "uid"

  create_table "pre_common_block_item", :primary_key => "itemid", :force => true do |t|
    t.integer "bid",          :limit => 3, :default => 0,     :null => false
    t.integer "id",                        :default => 0,     :null => false
    t.string  "idtype",                    :default => "",    :null => false
    t.boolean "itemtype",                  :default => false, :null => false
    t.string  "title",                     :default => "",    :null => false
    t.string  "url",                       :default => "",    :null => false
    t.string  "pic",                       :default => "",    :null => false
    t.boolean "picflag",                   :default => false, :null => false
    t.boolean "makethumb",                 :default => false, :null => false
    t.string  "thumbpath",                 :default => "",    :null => false
    t.text    "summary",                                      :null => false
    t.text    "showstyle",                                    :null => false
    t.text    "related",                                      :null => false
    t.text    "fields",                                       :null => false
    t.integer "displayorder", :limit => 2, :default => 0,     :null => false
    t.integer "startdate",                 :default => 0,     :null => false
    t.integer "enddate",                   :default => 0,     :null => false
  end

  add_index "pre_common_block_item", ["bid"], :name => "bid"

  create_table "pre_common_block_item_data", :primary_key => "dataid", :force => true do |t|
    t.integer "bid",          :limit => 3, :default => 0,     :null => false
    t.integer "id",                        :default => 0,     :null => false
    t.string  "idtype",                    :default => "",    :null => false
    t.boolean "itemtype",                  :default => false, :null => false
    t.string  "title",                     :default => "",    :null => false
    t.string  "url",                       :default => "",    :null => false
    t.string  "pic",                       :default => "",    :null => false
    t.boolean "picflag",                   :default => false, :null => false
    t.boolean "makethumb",                 :default => false, :null => false
    t.text    "summary",                                      :null => false
    t.text    "showstyle",                                    :null => false
    t.text    "related",                                      :null => false
    t.text    "fields",                                       :null => false
    t.integer "displayorder", :limit => 2, :default => 0,     :null => false
    t.integer "startdate",                 :default => 0,     :null => false
    t.integer "enddate",                   :default => 0,     :null => false
    t.integer "uid",          :limit => 3, :default => 0,     :null => false
    t.string  "username",                  :default => "",    :null => false
    t.integer "dateline",                  :default => 0,     :null => false
    t.boolean "isverified",                :default => false, :null => false
    t.integer "verifiedtime",              :default => 0,     :null => false
    t.integer "stickgrade",   :limit => 1, :default => 0,     :null => false
  end

  add_index "pre_common_block_item_data", ["bid", "stickgrade", "verifiedtime"], :name => "bid"

  create_table "pre_common_block_permission", :id => false, :force => true do |t|
    t.integer "bid",              :limit => 3, :default => 0,     :null => false
    t.integer "uid",              :limit => 3, :default => 0,     :null => false
    t.boolean "allowmanage",                   :default => false, :null => false
    t.boolean "allowrecommend",                :default => false, :null => false
    t.boolean "needverify",                    :default => false, :null => false
    t.string  "inheritedtplname",              :default => "",    :null => false
  end

  add_index "pre_common_block_permission", ["uid"], :name => "uid"

  create_table "pre_common_block_pic", :primary_key => "picid", :force => true do |t|
    t.integer "bid",     :limit => 3, :default => 0,     :null => false
    t.integer "itemid",               :default => 0,     :null => false
    t.string  "pic",                  :default => "",    :null => false
    t.boolean "picflag",              :default => false, :null => false
    t.boolean "type",                 :default => false, :null => false
  end

  add_index "pre_common_block_pic", ["bid", "itemid"], :name => "bid"

  create_table "pre_common_block_style", :primary_key => "styleid", :force => true do |t|
    t.string  "blockclass", :default => "",    :null => false
    t.string  "name",       :default => "",    :null => false
    t.text    "template",                      :null => false
    t.string  "hash",       :default => "",    :null => false
    t.boolean "getpic",     :default => false, :null => false
    t.boolean "getsummary", :default => false, :null => false
    t.boolean "makethumb",  :default => false, :null => false
    t.boolean "settarget",  :default => false, :null => false
    t.text    "fields",                        :null => false
    t.boolean "moreurl",    :default => false, :null => false
  end

  add_index "pre_common_block_style", ["blockclass"], :name => "blockclass"
  add_index "pre_common_block_style", ["hash"], :name => "hash"

  create_table "pre_common_block_xml", :force => true do |t|
    t.string "name",     :null => false
    t.string "version",  :null => false
    t.string "url",      :null => false
    t.string "clientid", :null => false
    t.string "key",      :null => false
    t.string "signtype", :null => false
    t.text   "data",     :null => false
  end

  create_table "pre_common_cache", :primary_key => "cachekey", :force => true do |t|
    t.binary  "cachevalue", :limit => 16777215,                :null => false
    t.integer "dateline",                       :default => 0, :null => false
  end

  create_table "pre_common_card", :force => true do |t|
    t.integer "typeid",        :limit => 2, :default => 1,     :null => false
    t.boolean "maketype",                   :default => false, :null => false
    t.integer "makeruid",      :limit => 3, :default => 0,     :null => false
    t.integer "price",         :limit => 3, :default => 0,     :null => false
    t.boolean "extcreditskey",              :default => false, :null => false
    t.integer "extcreditsval",              :default => 0,     :null => false
    t.boolean "status",                     :default => true,  :null => false
    t.integer "dateline",                   :default => 0,     :null => false
    t.integer "cleardateline",              :default => 0,     :null => false
    t.integer "useddateline",               :default => 0,     :null => false
    t.integer "uid",           :limit => 3, :default => 0,     :null => false
  end

  add_index "pre_common_card", ["dateline"], :name => "dateline"

  create_table "pre_common_card_log", :force => true do |t|
    t.integer "uid",         :limit => 3,        :default => 0,     :null => false
    t.string  "username",    :limit => 20,       :default => "",    :null => false
    t.string  "cardrule",                        :default => "",    :null => false
    t.text    "info",                                               :null => false
    t.integer "dateline",                        :default => 0,     :null => false
    t.text    "description", :limit => 16777215,                    :null => false
    t.boolean "operation",                       :default => false, :null => false
  end

  add_index "pre_common_card_log", ["dateline"], :name => "dateline"
  add_index "pre_common_card_log", ["operation", "dateline"], :name => "operation_dateline"

  create_table "pre_common_card_type", :force => true do |t|
    t.string "typename", :limit => 20, :default => "", :null => false
  end

  create_table "pre_common_connect_guest", :primary_key => "conopenid", :force => true do |t|
    t.string "conuin",       :limit => 40,  :default => "", :null => false
    t.string "conuinsecret", :limit => 16,  :default => "", :null => false
    t.string "conqqnick",    :limit => 100, :default => "", :null => false
  end

  create_table "pre_common_credit_log", :id => false, :force => true do |t|
    t.integer "uid",         :limit => 3, :default => 0,  :null => false
    t.string  "operation",   :limit => 3, :default => "", :null => false
    t.integer "relatedid",                                :null => false
    t.integer "dateline",                                 :null => false
    t.integer "extcredits1",                              :null => false
    t.integer "extcredits2",                              :null => false
    t.integer "extcredits3",                              :null => false
    t.integer "extcredits4",                              :null => false
    t.integer "extcredits5",                              :null => false
    t.integer "extcredits6",                              :null => false
    t.integer "extcredits7",                              :null => false
    t.integer "extcredits8",                              :null => false
  end

  add_index "pre_common_credit_log", ["dateline"], :name => "dateline"
  add_index "pre_common_credit_log", ["operation"], :name => "operation"
  add_index "pre_common_credit_log", ["relatedid"], :name => "relatedid"
  add_index "pre_common_credit_log", ["uid"], :name => "uid"

  create_table "pre_common_credit_rule", :primary_key => "rid", :force => true do |t|
    t.string  "rulename",    :limit => 20, :default => "",    :null => false
    t.string  "action",      :limit => 20, :default => "",    :null => false
    t.boolean "cycletype",                 :default => false, :null => false
    t.integer "cycletime",                 :default => 0,     :null => false
    t.integer "rewardnum",   :limit => 1,  :default => 1,     :null => false
    t.boolean "norepeat",                  :default => false, :null => false
    t.integer "extcredits1",               :default => 0,     :null => false
    t.integer "extcredits2",               :default => 0,     :null => false
    t.integer "extcredits3",               :default => 0,     :null => false
    t.integer "extcredits4",               :default => 0,     :null => false
    t.integer "extcredits5",               :default => 0,     :null => false
    t.integer "extcredits6",               :default => 0,     :null => false
    t.integer "extcredits7",               :default => 0,     :null => false
    t.integer "extcredits8",               :default => 0,     :null => false
    t.text    "fids",                                         :null => false
  end

  add_index "pre_common_credit_rule", ["action"], :name => "action", :unique => true

  create_table "pre_common_credit_rule_log", :primary_key => "clid", :force => true do |t|
    t.integer "uid",         :limit => 3, :default => 0, :null => false
    t.integer "rid",         :limit => 3, :default => 0, :null => false
    t.integer "fid",         :limit => 3, :default => 0, :null => false
    t.integer "total",       :limit => 3, :default => 0, :null => false
    t.integer "cyclenum",    :limit => 3, :default => 0, :null => false
    t.integer "extcredits1",              :default => 0, :null => false
    t.integer "extcredits2",              :default => 0, :null => false
    t.integer "extcredits3",              :default => 0, :null => false
    t.integer "extcredits4",              :default => 0, :null => false
    t.integer "extcredits5",              :default => 0, :null => false
    t.integer "extcredits6",              :default => 0, :null => false
    t.integer "extcredits7",              :default => 0, :null => false
    t.integer "extcredits8",              :default => 0, :null => false
    t.integer "starttime",                :default => 0, :null => false
    t.integer "dateline",                 :default => 0, :null => false
  end

  add_index "pre_common_credit_rule_log", ["dateline"], :name => "dateline"
  add_index "pre_common_credit_rule_log", ["uid", "rid", "fid"], :name => "uid"

  create_table "pre_common_credit_rule_log_field", :id => false, :force => true do |t|
    t.integer "clid", :limit => 3, :default => 0, :null => false
    t.integer "uid",  :limit => 3, :default => 0, :null => false
    t.text    "info",                             :null => false
    t.text    "user",                             :null => false
    t.text    "app",                              :null => false
  end

  create_table "pre_common_cron", :primary_key => "cronid", :force => true do |t|
    t.boolean "available",               :default => false,  :null => false
    t.string  "type",      :limit => 6,  :default => "user", :null => false
    t.string  "name",      :limit => 50, :default => "",     :null => false
    t.string  "filename",  :limit => 50, :default => "",     :null => false
    t.integer "lastrun",                 :default => 0,      :null => false
    t.integer "nextrun",                 :default => 0,      :null => false
    t.boolean "weekday",                 :default => false,  :null => false
    t.integer "day",       :limit => 1,  :default => 0,      :null => false
    t.integer "hour",      :limit => 1,  :default => 0,      :null => false
    t.string  "minute",    :limit => 36, :default => "",     :null => false
  end

  add_index "pre_common_cron", ["available", "nextrun"], :name => "nextrun"

  create_table "pre_common_district", :force => true do |t|
    t.string  "name",                      :default => "",    :null => false
    t.integer "level",        :limit => 1, :default => 0,     :null => false
    t.boolean "usetype",                   :default => false, :null => false
    t.integer "upid",         :limit => 3, :default => 0,     :null => false
    t.integer "displayorder", :limit => 2, :default => 0,     :null => false
  end

  add_index "pre_common_district", ["upid", "displayorder"], :name => "upid"

  create_table "pre_common_diy_data", :id => false, :force => true do |t|
    t.string  "targettplname", :limit => 100,      :default => "", :null => false
    t.string  "tpldirectory",  :limit => 80,       :default => "", :null => false
    t.string  "primaltplname",                     :default => "", :null => false
    t.text    "diycontent",    :limit => 16777215,                 :null => false
    t.string  "name",                              :default => "", :null => false
    t.integer "uid",           :limit => 3,        :default => 0,  :null => false
    t.string  "username",      :limit => 15,       :default => "", :null => false
    t.integer "dateline",                          :default => 0,  :null => false
  end

  create_table "pre_common_domain", :id => false, :force => true do |t|
    t.string  "domain",     :limit => 30, :default => "", :null => false
    t.string  "domainroot", :limit => 60, :default => "", :null => false
    t.integer "id",         :limit => 3,  :default => 0,  :null => false
    t.string  "idtype",     :limit => 15, :default => "", :null => false
  end

  add_index "pre_common_domain", ["domain", "domainroot"], :name => "domain"
  add_index "pre_common_domain", ["idtype"], :name => "idtype"

  create_table "pre_common_failedlogin", :id => false, :force => true do |t|
    t.string  "ip",         :limit => 15, :default => "",    :null => false
    t.string  "username",   :limit => 32, :default => "",    :null => false
    t.boolean "count",                    :default => false, :null => false
    t.integer "lastupdate",               :default => 0,     :null => false
  end

  create_table "pre_common_friendlink", :force => true do |t|
    t.integer "displayorder", :limit => 1,        :default => 0,  :null => false
    t.string  "name",         :limit => 100,      :default => "", :null => false
    t.string  "url",                              :default => "", :null => false
    t.text    "description",  :limit => 16777215,                 :null => false
    t.string  "logo",                             :default => "", :null => false
    t.integer "type",         :limit => 1,        :default => 0,  :null => false
  end

  create_table "pre_common_grouppm", :force => true do |t|
    t.integer "authorid", :limit => 3,  :default => 0,  :null => false
    t.string  "author",   :limit => 15, :default => "", :null => false
    t.integer "dateline",               :default => 0,  :null => false
    t.text    "message",                                :null => false
    t.integer "numbers",  :limit => 3,  :default => 0,  :null => false
  end

  create_table "pre_common_invite", :force => true do |t|
    t.integer "uid",         :limit => 3,  :default => 0,     :null => false
    t.string  "code",        :limit => 20, :default => "",    :null => false
    t.integer "fuid",        :limit => 3,  :default => 0,     :null => false
    t.string  "fusername",   :limit => 20, :default => "",    :null => false
    t.boolean "type",                      :default => false, :null => false
    t.string  "email",       :limit => 40, :default => "",    :null => false
    t.string  "inviteip",    :limit => 15, :default => "",    :null => false
    t.integer "appid",       :limit => 3,  :default => 0,     :null => false
    t.integer "dateline",                  :default => 0,     :null => false
    t.integer "endtime",                   :default => 0,     :null => false
    t.integer "regdateline",               :default => 0,     :null => false
    t.boolean "status",                    :default => true,  :null => false
    t.string  "orderid",     :limit => 32, :default => "",    :null => false
  end

  add_index "pre_common_invite", ["uid", "dateline"], :name => "uid"

  create_table "pre_common_magic", :primary_key => "magicid", :force => true do |t|
    t.boolean "available",                  :default => false, :null => false
    t.string  "name",         :limit => 50,                    :null => false
    t.string  "identifier",   :limit => 40,                    :null => false
    t.string  "description",                                   :null => false
    t.integer "displayorder", :limit => 1,  :default => 0,     :null => false
    t.boolean "credit",                     :default => false, :null => false
    t.integer "price",        :limit => 3,  :default => 0,     :null => false
    t.integer "num",          :limit => 2,  :default => 0,     :null => false
    t.integer "salevolume",   :limit => 2,  :default => 0,     :null => false
    t.boolean "supplytype",                 :default => false, :null => false
    t.integer "supplynum",    :limit => 2,  :default => 0,     :null => false
    t.boolean "useperoid",                  :default => false, :null => false
    t.integer "usenum",       :limit => 2,  :default => 0,     :null => false
    t.integer "weight",       :limit => 1,  :default => 1,     :null => false
    t.text    "magicperm",                                     :null => false
    t.boolean "useevent",                   :default => false, :null => false
  end

  add_index "pre_common_magic", ["available", "displayorder"], :name => "displayorder"
  add_index "pre_common_magic", ["identifier"], :name => "identifier", :unique => true

  create_table "pre_common_magiclog", :id => false, :force => true do |t|
    t.integer "uid",       :limit => 3, :default => 0,     :null => false
    t.integer "magicid",   :limit => 2, :default => 0,     :null => false
    t.boolean "action",                 :default => false, :null => false
    t.integer "dateline",               :default => 0,     :null => false
    t.integer "amount",    :limit => 2, :default => 0,     :null => false
    t.boolean "credit",                 :default => false, :null => false
    t.integer "price",     :limit => 3, :default => 0,     :null => false
    t.integer "targetid",               :default => 0,     :null => false
    t.string  "idtype",    :limit => 6
    t.integer "targetuid", :limit => 3, :default => 0,     :null => false
  end

  add_index "pre_common_magiclog", ["action"], :name => "action"
  add_index "pre_common_magiclog", ["magicid", "dateline"], :name => "magicid"
  add_index "pre_common_magiclog", ["targetuid", "dateline"], :name => "targetuid"
  add_index "pre_common_magiclog", ["uid", "dateline"], :name => "uid"

  create_table "pre_common_mailcron", :primary_key => "cid", :force => true do |t|
    t.integer "touid",    :limit => 3,   :default => 0,  :null => false
    t.string  "email",    :limit => 100, :default => "", :null => false
    t.integer "sendtime",                :default => 0,  :null => false
  end

  add_index "pre_common_mailcron", ["sendtime"], :name => "sendtime"

  create_table "pre_common_mailqueue", :primary_key => "qid", :force => true do |t|
    t.integer "cid",      :limit => 3, :default => 0, :null => false
    t.text    "subject",                              :null => false
    t.text    "message",                              :null => false
    t.integer "dateline",              :default => 0, :null => false
  end

  add_index "pre_common_mailqueue", ["cid", "dateline"], :name => "mcid"

  create_table "pre_common_member", :primary_key => "uid", :force => true do |t|
    t.string  "email",              :limit => 40, :default => "",    :null => false
    t.string  "username",           :limit => 15, :default => "",    :null => false
    t.string  "password",           :limit => 32, :default => "",    :null => false
    t.boolean "status",                           :default => false, :null => false
    t.boolean "emailstatus",                      :default => false, :null => false
    t.boolean "avatarstatus",                     :default => false, :null => false
    t.boolean "videophotostatus",                 :default => false, :null => false
    t.boolean "adminid",                          :default => false, :null => false
    t.integer "groupid",            :limit => 2,  :default => 0,     :null => false
    t.integer "groupexpiry",                      :default => 0,     :null => false
    t.string  "extgroupids",        :limit => 20, :default => "",    :null => false
    t.integer "regdate",                          :default => 0,     :null => false
    t.integer "credits",                          :default => 0,     :null => false
    t.boolean "notifysound",                      :default => false, :null => false
    t.string  "timeoffset",         :limit => 4,  :default => "",    :null => false
    t.integer "newpm",              :limit => 2,  :default => 0,     :null => false
    t.integer "newprompt",          :limit => 2,  :default => 0,     :null => false
    t.boolean "accessmasks",                      :default => false, :null => false
    t.boolean "allowadmincp",                     :default => false, :null => false
    t.boolean "onlyacceptfriendpm",               :default => false, :null => false
    t.boolean "conisbind",                        :default => false, :null => false
  end

  add_index "pre_common_member", ["conisbind"], :name => "conisbind"
  add_index "pre_common_member", ["email"], :name => "email"
  add_index "pre_common_member", ["groupid"], :name => "groupid"
  add_index "pre_common_member", ["username"], :name => "username", :unique => true

  create_table "pre_common_member_action_log", :force => true do |t|
    t.integer "uid",      :limit => 3, :default => 0, :null => false
    t.integer "action",   :limit => 1, :default => 0, :null => false
    t.integer "dateline",              :default => 0, :null => false
  end

  add_index "pre_common_member_action_log", ["dateline", "action", "uid"], :name => "dateline"

  create_table "pre_common_member_connect", :primary_key => "uid", :force => true do |t|
    t.string  "conuin",           :limit => 40, :default => "",    :null => false
    t.string  "conuinsecret",     :limit => 16, :default => "",    :null => false
    t.string  "conopenid",        :limit => 32, :default => "",    :null => false
    t.boolean "conisfeed",                      :default => false, :null => false
    t.boolean "conispublishfeed",               :default => false, :null => false
    t.boolean "conispublisht",                  :default => false, :null => false
    t.boolean "conisregister",                  :default => false, :null => false
    t.boolean "conisqzoneavatar",               :default => false, :null => false
    t.boolean "conisqqshow",                    :default => false, :null => false
  end

  add_index "pre_common_member_connect", ["conopenid"], :name => "conopenid"
  add_index "pre_common_member_connect", ["conuin"], :name => "conuin"

  create_table "pre_common_member_count", :primary_key => "uid", :force => true do |t|
    t.integer "extcredits1",                  :default => 0, :null => false
    t.integer "extcredits2",                  :default => 0, :null => false
    t.integer "extcredits3",                  :default => 0, :null => false
    t.integer "extcredits4",                  :default => 0, :null => false
    t.integer "extcredits5",                  :default => 0, :null => false
    t.integer "extcredits6",                  :default => 0, :null => false
    t.integer "extcredits7",                  :default => 0, :null => false
    t.integer "extcredits8",                  :default => 0, :null => false
    t.integer "friends",         :limit => 2, :default => 0, :null => false
    t.integer "posts",           :limit => 3, :default => 0, :null => false
    t.integer "threads",         :limit => 3, :default => 0, :null => false
    t.integer "digestposts",     :limit => 2, :default => 0, :null => false
    t.integer "doings",          :limit => 2, :default => 0, :null => false
    t.integer "blogs",           :limit => 2, :default => 0, :null => false
    t.integer "albums",          :limit => 2, :default => 0, :null => false
    t.integer "sharings",        :limit => 2, :default => 0, :null => false
    t.integer "attachsize",                   :default => 0, :null => false
    t.integer "views",           :limit => 3, :default => 0, :null => false
    t.integer "oltime",          :limit => 2, :default => 0, :null => false
    t.integer "todayattachs",    :limit => 2, :default => 0, :null => false
    t.integer "todayattachsize",              :default => 0, :null => false
    t.integer "feeds",           :limit => 3, :default => 0, :null => false
    t.integer "follower",        :limit => 3, :default => 0, :null => false
    t.integer "following",       :limit => 3, :default => 0, :null => false
    t.integer "newfollower",     :limit => 3, :default => 0, :null => false
  end

  add_index "pre_common_member_count", ["posts"], :name => "posts"

  create_table "pre_common_member_crime", :primary_key => "cid", :force => true do |t|
    t.integer "uid",        :limit => 3,  :default => 0, :null => false
    t.integer "operatorid", :limit => 3,  :default => 0, :null => false
    t.string  "operator",   :limit => 15,                :null => false
    t.integer "action",     :limit => 1,                 :null => false
    t.text    "reason",                                  :null => false
    t.integer "dateline",                 :default => 0, :null => false
  end

  add_index "pre_common_member_crime", ["uid", "action", "dateline"], :name => "uid"

  create_table "pre_common_member_field_forum", :primary_key => "uid", :force => true do |t|
    t.integer "publishfeed",    :limit => 1,        :default => 0,     :null => false
    t.boolean "customshow",                         :default => false, :null => false
    t.string  "customstatus",   :limit => 30,       :default => "",    :null => false
    t.text    "medals",                                                :null => false
    t.text    "sightml",                                               :null => false
    t.text    "groupterms",                                            :null => false
    t.string  "authstr",        :limit => 20,       :default => "",    :null => false
    t.text    "groups",         :limit => 16777215,                    :null => false
    t.string  "attentiongroup",                     :default => "",    :null => false
  end

  create_table "pre_common_member_field_home", :primary_key => "uid", :force => true do |t|
    t.string  "videophoto",                           :default => "", :null => false
    t.string  "spacename",                            :default => "", :null => false
    t.string  "spacedescription",                     :default => "", :null => false
    t.string  "domain",           :limit => 15,       :default => "", :null => false
    t.integer "addsize",                              :default => 0,  :null => false
    t.integer "addfriend",        :limit => 2,        :default => 0,  :null => false
    t.integer "menunum",          :limit => 2,        :default => 0,  :null => false
    t.string  "theme",            :limit => 20,       :default => "", :null => false
    t.text    "spacecss",                                             :null => false
    t.text    "blockposition",                                        :null => false
    t.text    "recentnote",                                           :null => false
    t.text    "spacenote",                                            :null => false
    t.text    "privacy",                                              :null => false
    t.text    "feedfriend",       :limit => 16777215,                 :null => false
    t.text    "acceptemail",                                          :null => false
    t.text    "magicgift",                                            :null => false
    t.text    "stickblogs",                                           :null => false
  end

  add_index "pre_common_member_field_home", ["domain"], :name => "domain"

  create_table "pre_common_member_grouppm", :id => false, :force => true do |t|
    t.integer "uid",      :limit => 3, :default => 0,     :null => false
    t.integer "gpmid",    :limit => 2,                    :null => false
    t.boolean "status",                :default => false, :null => false
    t.integer "dateline",              :default => 0,     :null => false
  end

  create_table "pre_common_member_log", :primary_key => "uid", :force => true do |t|
    t.string  "action",   :limit => 10, :default => "", :null => false
    t.integer "dateline",               :default => 0,  :null => false
  end

  create_table "pre_common_member_magic", :id => false, :force => true do |t|
    t.integer "uid",     :limit => 3, :default => 0, :null => false
    t.integer "magicid", :limit => 2, :default => 0, :null => false
    t.integer "num",     :limit => 2, :default => 0, :null => false
  end

  create_table "pre_common_member_medal", :id => false, :force => true do |t|
    t.integer "uid",     :limit => 3, :null => false
    t.integer "medalid", :limit => 2, :null => false
  end

  create_table "pre_common_member_profile", :primary_key => "uid", :force => true do |t|
    t.string  "realname",                      :default => "",    :null => false
    t.boolean "gender",                        :default => false, :null => false
    t.integer "birthyear",       :limit => 2,  :default => 0,     :null => false
    t.integer "birthmonth",      :limit => 1,  :default => 0,     :null => false
    t.integer "birthday",        :limit => 1,  :default => 0,     :null => false
    t.string  "constellation",                 :default => "",    :null => false
    t.string  "zodiac",                        :default => "",    :null => false
    t.string  "telephone",                     :default => "",    :null => false
    t.string  "mobile",                        :default => "",    :null => false
    t.string  "idcardtype",                    :default => "",    :null => false
    t.string  "idcard",                        :default => "",    :null => false
    t.string  "address",                       :default => "",    :null => false
    t.string  "zipcode",                       :default => "",    :null => false
    t.string  "nationality",                   :default => "",    :null => false
    t.string  "birthprovince",                 :default => "",    :null => false
    t.string  "birthcity",                     :default => "",    :null => false
    t.string  "birthdist",       :limit => 20, :default => "",    :null => false
    t.string  "birthcommunity",                :default => "",    :null => false
    t.string  "resideprovince",                :default => "",    :null => false
    t.string  "residecity",                    :default => "",    :null => false
    t.string  "residedist",      :limit => 20, :default => "",    :null => false
    t.string  "residecommunity",               :default => "",    :null => false
    t.string  "residesuite",                   :default => "",    :null => false
    t.string  "graduateschool",                :default => "",    :null => false
    t.string  "company",                       :default => "",    :null => false
    t.string  "education",                     :default => "",    :null => false
    t.string  "occupation",                    :default => "",    :null => false
    t.string  "position",                      :default => "",    :null => false
    t.string  "revenue",                       :default => "",    :null => false
    t.string  "affectivestatus",               :default => "",    :null => false
    t.string  "lookingfor",                    :default => "",    :null => false
    t.string  "bloodtype",                     :default => "",    :null => false
    t.string  "height",                        :default => "",    :null => false
    t.string  "weight",                        :default => "",    :null => false
    t.string  "alipay",                        :default => "",    :null => false
    t.string  "icq",                           :default => "",    :null => false
    t.string  "qq",                            :default => "",    :null => false
    t.string  "yahoo",                         :default => "",    :null => false
    t.string  "msn",                           :default => "",    :null => false
    t.string  "taobao",                        :default => "",    :null => false
    t.string  "site",                          :default => "",    :null => false
    t.text    "bio",                                              :null => false
    t.text    "interest",                                         :null => false
    t.text    "field1",                                           :null => false
    t.text    "field2",                                           :null => false
    t.text    "field3",                                           :null => false
    t.text    "field4",                                           :null => false
    t.text    "field5",                                           :null => false
    t.text    "field6",                                           :null => false
    t.text    "field7",                                           :null => false
    t.text    "field8",                                           :null => false
  end

  create_table "pre_common_member_profile_setting", :primary_key => "fieldid", :force => true do |t|
    t.boolean "available",                   :default => false, :null => false
    t.boolean "invisible",                   :default => false, :null => false
    t.boolean "needverify",                  :default => false, :null => false
    t.string  "title",                       :default => "",    :null => false
    t.string  "description",                 :default => "",    :null => false
    t.integer "displayorder",   :limit => 2, :default => 0,     :null => false
    t.boolean "required",                    :default => false, :null => false
    t.boolean "unchangeable",                :default => false, :null => false
    t.boolean "showincard",                  :default => false, :null => false
    t.boolean "showinthread",                :default => false, :null => false
    t.boolean "showinregister",              :default => false, :null => false
    t.boolean "allowsearch",                 :default => false, :null => false
    t.string  "formtype",                                       :null => false
    t.integer "size",           :limit => 2, :default => 0,     :null => false
    t.text    "choices",                                        :null => false
    t.text    "validate",                                       :null => false
  end

  create_table "pre_common_member_security", :primary_key => "securityid", :force => true do |t|
    t.integer "uid",      :limit => 3, :default => 0,  :null => false
    t.string  "username",              :default => "", :null => false
    t.string  "fieldid",               :default => "", :null => false
    t.text    "oldvalue",                              :null => false
    t.text    "newvalue",                              :null => false
    t.integer "dateline",              :default => 0,  :null => false
  end

  add_index "pre_common_member_security", ["dateline"], :name => "dateline"
  add_index "pre_common_member_security", ["uid", "fieldid"], :name => "uid"

  create_table "pre_common_member_stat_field", :primary_key => "optionid", :force => true do |t|
    t.string  "fieldid",                 :default => "", :null => false
    t.string  "fieldvalue",              :default => "", :null => false
    t.string  "hash",                    :default => "", :null => false
    t.integer "users",      :limit => 3, :default => 0,  :null => false
    t.integer "updatetime",              :default => 0,  :null => false
  end

  add_index "pre_common_member_stat_field", ["fieldid"], :name => "fieldid"

  create_table "pre_common_member_status", :primary_key => "uid", :force => true do |t|
    t.string  "regip",           :limit => 15, :default => "",    :null => false
    t.string  "lastip",          :limit => 15, :default => "",    :null => false
    t.integer "lastvisit",                     :default => 0,     :null => false
    t.integer "lastactivity",                  :default => 0,     :null => false
    t.integer "lastpost",                      :default => 0,     :null => false
    t.integer "lastsendmail",                  :default => 0,     :null => false
    t.boolean "invisible",                     :default => false, :null => false
    t.integer "buyercredit",     :limit => 2,  :default => 0,     :null => false
    t.integer "sellercredit",    :limit => 2,  :default => 0,     :null => false
    t.integer "favtimes",        :limit => 3,  :default => 0,     :null => false
    t.integer "sharetimes",      :limit => 3,  :default => 0,     :null => false
    t.integer "profileprogress", :limit => 1,  :default => 0,     :null => false
  end

  add_index "pre_common_member_status", ["lastactivity", "invisible"], :name => "lastactivity"

  create_table "pre_common_member_validate", :primary_key => "uid", :force => true do |t|
    t.integer "submitdate",                :default => 0,     :null => false
    t.integer "moddate",                   :default => 0,     :null => false
    t.string  "admin",       :limit => 15, :default => "",    :null => false
    t.integer "submittimes", :limit => 1,  :default => 0,     :null => false
    t.boolean "status",                    :default => false, :null => false
    t.text    "message",                                      :null => false
    t.text    "remark",                                       :null => false
  end

  add_index "pre_common_member_validate", ["status"], :name => "status"

  create_table "pre_common_member_verify", :primary_key => "uid", :force => true do |t|
    t.boolean "verify1", :default => false, :null => false
    t.boolean "verify2", :default => false, :null => false
    t.boolean "verify3", :default => false, :null => false
    t.boolean "verify4", :default => false, :null => false
    t.boolean "verify5", :default => false, :null => false
    t.boolean "verify6", :default => false, :null => false
    t.boolean "verify7", :default => false, :null => false
  end

  add_index "pre_common_member_verify", ["verify1"], :name => "verify1"
  add_index "pre_common_member_verify", ["verify2"], :name => "verify2"
  add_index "pre_common_member_verify", ["verify3"], :name => "verify3"
  add_index "pre_common_member_verify", ["verify4"], :name => "verify4"
  add_index "pre_common_member_verify", ["verify5"], :name => "verify5"
  add_index "pre_common_member_verify", ["verify6"], :name => "verify6"
  add_index "pre_common_member_verify", ["verify7"], :name => "verify7"

  create_table "pre_common_member_verify_info", :primary_key => "vid", :force => true do |t|
    t.integer "uid",        :limit => 3,  :default => 0,     :null => false
    t.string  "username",   :limit => 30, :default => "",    :null => false
    t.boolean "verifytype",               :default => false, :null => false
    t.boolean "flag",                     :default => false, :null => false
    t.text    "field",                                       :null => false
    t.integer "dateline",                 :default => 0,     :null => false
  end

  add_index "pre_common_member_verify_info", ["uid", "verifytype", "dateline"], :name => "uid"
  add_index "pre_common_member_verify_info", ["verifytype", "flag"], :name => "verifytype"

  create_table "pre_common_myapp", :primary_key => "appid", :force => true do |t|
    t.string  "appname",          :limit => 60, :default => "",    :null => false
    t.boolean "narrow",                         :default => false, :null => false
    t.boolean "flag",                           :default => false, :null => false
    t.integer "version",          :limit => 3,  :default => 0,     :null => false
    t.boolean "userpanelarea",                  :default => false, :null => false
    t.string  "canvastitle",      :limit => 60, :default => "",    :null => false
    t.boolean "fullscreen",                     :default => false, :null => false
    t.boolean "displayuserpanel",               :default => false, :null => false
    t.boolean "displaymethod",                  :default => false, :null => false
    t.integer "displayorder",     :limit => 2,  :default => 0,     :null => false
    t.integer "appstatus",        :limit => 1,  :default => 0,     :null => false
    t.integer "iconstatus",       :limit => 1,  :default => 0,     :null => false
    t.integer "icondowntime",                   :default => 0,     :null => false
  end

  add_index "pre_common_myapp", ["flag", "displayorder"], :name => "flag"

  create_table "pre_common_myinvite", :force => true do |t|
    t.string  "typename", :limit => 100, :default => "",    :null => false
    t.integer "appid",    :limit => 3,   :default => 0,     :null => false
    t.boolean "type",                    :default => false, :null => false
    t.integer "fromuid",  :limit => 3,   :default => 0,     :null => false
    t.integer "touid",    :limit => 3,   :default => 0,     :null => false
    t.text    "myml",                                       :null => false
    t.integer "dateline",                :default => 0,     :null => false
    t.integer "hash",                    :default => 0,     :null => false
  end

  add_index "pre_common_myinvite", ["hash"], :name => "hash"
  add_index "pre_common_myinvite", ["touid", "dateline"], :name => "uid"

  create_table "pre_common_mytask", :id => false, :force => true do |t|
    t.integer "uid",      :limit => 3,                     :null => false
    t.string  "username", :limit => 15, :default => "",    :null => false
    t.integer "taskid",   :limit => 2,                     :null => false
    t.boolean "status",                 :default => false, :null => false
    t.string  "csc",                    :default => "",    :null => false
    t.integer "dateline",               :default => 0,     :null => false
  end

  add_index "pre_common_mytask", ["taskid", "dateline"], :name => "parter"

  create_table "pre_common_nav", :force => true do |t|
    t.integer "parentid",     :limit => 2, :default => 0,     :null => false
    t.string  "name",                                         :null => false
    t.string  "title",                                        :null => false
    t.string  "url",                                          :null => false
    t.string  "identifier",                                   :null => false
    t.boolean "target",                    :default => false, :null => false
    t.boolean "type",                      :default => false, :null => false
    t.boolean "available",                 :default => false, :null => false
    t.integer "displayorder", :limit => 1,                    :null => false
    t.boolean "highlight",                 :default => false, :null => false
    t.boolean "level",                     :default => false, :null => false
    t.boolean "subtype",                   :default => false, :null => false
    t.boolean "subcols",                   :default => false, :null => false
    t.string  "icon",                                         :null => false
    t.string  "subname",                                      :null => false
    t.string  "suburl",                                       :null => false
    t.boolean "navtype",                   :default => false, :null => false
    t.string  "logo",                                         :null => false
  end

  add_index "pre_common_nav", ["navtype"], :name => "navtype"

  create_table "pre_common_onlinetime", :primary_key => "uid", :force => true do |t|
    t.integer "thismonth",  :limit => 2, :default => 0, :null => false
    t.integer "total",      :limit => 3, :default => 0, :null => false
    t.integer "lastupdate",              :default => 0, :null => false
  end

  create_table "pre_common_patch", :primary_key => "serial", :force => true do |t|
    t.text    "rule",                        :null => false
    t.text    "note",                        :null => false
    t.boolean "status",   :default => false, :null => false
    t.integer "dateline", :default => 0,     :null => false
  end

  create_table "pre_common_plugin", :primary_key => "pluginid", :force => true do |t|
    t.boolean "available",                  :default => false, :null => false
    t.boolean "adminid",                    :default => false, :null => false
    t.string  "name",        :limit => 40,  :default => "",    :null => false
    t.string  "identifier",  :limit => 40,  :default => "",    :null => false
    t.string  "description",                :default => "",    :null => false
    t.string  "datatables",                 :default => "",    :null => false
    t.string  "directory",   :limit => 100, :default => "",    :null => false
    t.string  "copyright",   :limit => 100, :default => "",    :null => false
    t.text    "modules",                                       :null => false
    t.string  "version",     :limit => 20,  :default => "",    :null => false
  end

  add_index "pre_common_plugin", ["identifier"], :name => "identifier", :unique => true

  create_table "pre_common_pluginvar", :primary_key => "pluginvarid", :force => true do |t|
    t.integer "pluginid",     :limit => 2,   :default => 0,      :null => false
    t.integer "displayorder", :limit => 1,   :default => 0,      :null => false
    t.string  "title",        :limit => 100, :default => "",     :null => false
    t.string  "description",                 :default => "",     :null => false
    t.string  "variable",     :limit => 40,  :default => "",     :null => false
    t.string  "type",         :limit => 20,  :default => "text", :null => false
    t.text    "value",                                           :null => false
    t.text    "extra",                                           :null => false
  end

  add_index "pre_common_pluginvar", ["pluginid"], :name => "pluginid"

  create_table "pre_common_process", :primary_key => "processid", :force => true do |t|
    t.integer "expiry"
    t.integer "extra"
  end

  add_index "pre_common_process", ["expiry"], :name => "expiry"

  create_table "pre_common_regip", :id => false, :force => true do |t|
    t.string  "ip",       :limit => 15, :default => "", :null => false
    t.integer "dateline",               :default => 0,  :null => false
    t.integer "count",    :limit => 2,  :default => 0,  :null => false
  end

  add_index "pre_common_regip", ["ip"], :name => "ip"

  create_table "pre_common_relatedlink", :force => true do |t|
    t.string  "name",   :limit => 100, :default => "", :null => false
    t.string  "url",                   :default => "", :null => false
    t.integer "extent", :limit => 1,   :default => 0,  :null => false
  end

  create_table "pre_common_report", :force => true do |t|
    t.string  "urlkey",   :limit => 32, :default => "", :null => false
    t.string  "url",                    :default => "", :null => false
    t.text    "message",                                :null => false
    t.integer "uid",      :limit => 3,  :default => 0,  :null => false
    t.string  "username", :limit => 15, :default => "", :null => false
    t.integer "dateline",               :default => 0,  :null => false
    t.integer "num",      :limit => 2,  :default => 1,  :null => false
    t.integer "opuid",    :limit => 3,  :default => 0,  :null => false
    t.string  "opname",   :limit => 15, :default => "", :null => false
    t.integer "optime",                 :default => 0,  :null => false
    t.string  "opresult",               :default => "", :null => false
    t.integer "fid",      :limit => 3,  :default => 0,  :null => false
  end

  add_index "pre_common_report", ["fid"], :name => "fid"
  add_index "pre_common_report", ["urlkey"], :name => "urlkey"

  create_table "pre_common_searchindex", :primary_key => "searchid", :force => true do |t|
    t.integer "srchmod",      :limit => 1,                  :null => false
    t.string  "keywords",                   :default => "", :null => false
    t.text    "searchstring",                               :null => false
    t.string  "useip",        :limit => 15, :default => "", :null => false
    t.integer "uid",          :limit => 3,  :default => 0,  :null => false
    t.integer "dateline",                   :default => 0,  :null => false
    t.integer "expiration",                 :default => 0,  :null => false
    t.integer "threadsortid", :limit => 2,  :default => 0,  :null => false
    t.integer "num",          :limit => 2,  :default => 0,  :null => false
    t.text    "ids",                                        :null => false
  end

  add_index "pre_common_searchindex", ["srchmod"], :name => "srchmod"

  create_table "pre_common_secquestion", :force => true do |t|
    t.boolean "type",     :null => false
    t.text    "question", :null => false
    t.string  "answer",   :null => false
  end

  create_table "pre_common_session", :id => false, :force => true do |t|
    t.string  "sid",          :limit => 6,  :default => "",    :null => false
    t.integer "ip1",          :limit => 1,  :default => 0,     :null => false
    t.integer "ip2",          :limit => 1,  :default => 0,     :null => false
    t.integer "ip3",          :limit => 1,  :default => 0,     :null => false
    t.integer "ip4",          :limit => 1,  :default => 0,     :null => false
    t.integer "uid",          :limit => 3,  :default => 0,     :null => false
    t.string  "username",     :limit => 15, :default => "",    :null => false
    t.integer "groupid",      :limit => 2,  :default => 0,     :null => false
    t.boolean "invisible",                  :default => false, :null => false
    t.boolean "action",                     :default => false, :null => false
    t.integer "lastactivity",               :default => 0,     :null => false
    t.integer "lastolupdate",               :default => 0,     :null => false
    t.integer "fid",          :limit => 3,  :default => 0,     :null => false
    t.integer "tid",          :limit => 3,  :default => 0,     :null => false
  end

  add_index "pre_common_session", ["sid"], :name => "sid", :unique => true
  add_index "pre_common_session", ["uid"], :name => "uid"

  create_table "pre_common_setting", :primary_key => "skey", :force => true do |t|
    t.text "svalue", :null => false
  end

  create_table "pre_common_smiley", :force => true do |t|
    t.integer "typeid",       :limit => 2,                        :null => false
    t.boolean "displayorder",               :default => false,    :null => false
    t.string  "type",         :limit => 9,  :default => "smiley", :null => false
    t.string  "code",         :limit => 30, :default => "",       :null => false
    t.string  "url",          :limit => 30, :default => "",       :null => false
  end

  add_index "pre_common_smiley", ["type", "displayorder"], :name => "type"

  create_table "pre_common_sphinxcounter", :primary_key => "indexid", :force => true do |t|
    t.integer "maxid", :null => false
  end

  create_table "pre_common_stat", :primary_key => "daytime", :force => true do |t|
    t.integer "login",        :default => 0, :null => false
    t.integer "mobilelogin",  :default => 0, :null => false
    t.integer "connectlogin", :default => 0, :null => false
    t.integer "register",     :default => 0, :null => false
    t.integer "invite",       :default => 0, :null => false
    t.integer "appinvite",    :default => 0, :null => false
    t.integer "doing",        :default => 0, :null => false
    t.integer "blog",         :default => 0, :null => false
    t.integer "pic",          :default => 0, :null => false
    t.integer "poll",         :default => 0, :null => false
    t.integer "activity",     :default => 0, :null => false
    t.integer "share",        :default => 0, :null => false
    t.integer "thread",       :default => 0, :null => false
    t.integer "docomment",    :default => 0, :null => false
    t.integer "blogcomment",  :default => 0, :null => false
    t.integer "piccomment",   :default => 0, :null => false
    t.integer "sharecomment", :default => 0, :null => false
    t.integer "reward",       :default => 0, :null => false
    t.integer "debate",       :default => 0, :null => false
    t.integer "trade",        :default => 0, :null => false
    t.integer "group",        :default => 0, :null => false
    t.integer "groupjoin",    :default => 0, :null => false
    t.integer "groupthread",  :default => 0, :null => false
    t.integer "grouppost",    :default => 0, :null => false
    t.integer "post",         :default => 0, :null => false
    t.integer "wall",         :default => 0, :null => false
    t.integer "poke",         :default => 0, :null => false
    t.integer "click",        :default => 0, :null => false
    t.integer "sendpm",       :default => 0, :null => false
    t.integer "friend",       :default => 0, :null => false
    t.integer "addfriend",    :default => 0, :null => false
  end

  create_table "pre_common_statuser", :id => false, :force => true do |t|
    t.integer "uid",     :limit => 3,  :default => 0,  :null => false
    t.integer "daytime",               :default => 0,  :null => false
    t.string  "type",    :limit => 20, :default => "", :null => false
  end

  add_index "pre_common_statuser", ["uid"], :name => "uid"

  create_table "pre_common_style", :primary_key => "styleid", :force => true do |t|
    t.string  "name",       :limit => 20, :default => "",   :null => false
    t.boolean "available",                :default => true, :null => false
    t.integer "templateid", :limit => 2,  :default => 0,    :null => false
    t.string  "extstyle",                 :default => "",   :null => false
  end

  create_table "pre_common_stylevar", :primary_key => "stylevarid", :force => true do |t|
    t.integer "styleid",    :limit => 2, :default => 0, :null => false
    t.text    "variable",                               :null => false
    t.text    "substitute",                             :null => false
  end

  add_index "pre_common_stylevar", ["styleid"], :name => "styleid"

  create_table "pre_common_syscache", :primary_key => "cname", :force => true do |t|
    t.integer "ctype",    :limit => 1,        :null => false
    t.integer "dateline",                     :null => false
    t.binary  "data",     :limit => 16777215, :null => false
  end

  create_table "pre_common_tag", :primary_key => "tagid", :force => true do |t|
    t.string  "tagname", :limit => 20, :default => "",    :null => false
    t.boolean "status",                :default => false, :null => false
  end

  add_index "pre_common_tag", ["status", "tagid"], :name => "status"
  add_index "pre_common_tag", ["tagname"], :name => "tagname"

  create_table "pre_common_tagitem", :id => false, :force => true do |t|
    t.integer "tagid",  :limit => 2,  :default => 0,  :null => false
    t.integer "itemid", :limit => 3,  :default => 0,  :null => false
    t.string  "idtype", :limit => 10, :default => "", :null => false
  end

  add_index "pre_common_tagitem", ["idtype", "itemid"], :name => "idtype"
  add_index "pre_common_tagitem", ["tagid", "itemid", "idtype"], :name => "item", :unique => true

  create_table "pre_common_task", :primary_key => "taskid", :force => true do |t|
    t.integer "relatedtaskid", :limit => 2,   :default => 0,        :null => false
    t.boolean "available",                    :default => false,    :null => false
    t.string  "name",          :limit => 50,  :default => "",       :null => false
    t.text    "description",                                        :null => false
    t.string  "icon",          :limit => 150, :default => "",       :null => false
    t.integer "applicants",    :limit => 3,   :default => 0,        :null => false
    t.integer "achievers",     :limit => 3,   :default => 0,        :null => false
    t.integer "tasklimits",    :limit => 3,   :default => 0,        :null => false
    t.text    "applyperm",                                          :null => false
    t.string  "scriptname",    :limit => 50,  :default => "",       :null => false
    t.integer "starttime",                    :default => 0,        :null => false
    t.integer "endtime",                      :default => 0,        :null => false
    t.integer "period",                       :default => 0,        :null => false
    t.boolean "periodtype",                   :default => false,    :null => false
    t.string  "reward",        :limit => 6,   :default => "credit", :null => false
    t.string  "prize",         :limit => 15,  :default => "",       :null => false
    t.integer "bonus",                        :default => 0,        :null => false
    t.integer "displayorder",  :limit => 2,   :default => 0,        :null => false
    t.string  "version",       :limit => 15,  :default => "",       :null => false
  end

  create_table "pre_common_taskvar", :primary_key => "taskvarid", :force => true do |t|
    t.integer "taskid",      :limit => 2,   :default => 0,          :null => false
    t.string  "sort",        :limit => 8,   :default => "complete", :null => false
    t.string  "name",        :limit => 100, :default => "",         :null => false
    t.string  "description",                :default => "",         :null => false
    t.string  "variable",    :limit => 40,  :default => "",         :null => false
    t.string  "type",        :limit => 20,  :default => "text",     :null => false
    t.text    "value",                                              :null => false
  end

  add_index "pre_common_taskvar", ["taskid"], :name => "taskid"

  create_table "pre_common_template", :primary_key => "templateid", :force => true do |t|
    t.string "name",      :limit => 30,  :default => "", :null => false
    t.string "directory", :limit => 100, :default => "", :null => false
    t.string "copyright", :limit => 100, :default => "", :null => false
  end

  create_table "pre_common_template_block", :id => false, :force => true do |t|
    t.string  "targettplname", :limit => 100, :default => "", :null => false
    t.string  "tpldirectory",  :limit => 80,  :default => "", :null => false
    t.integer "bid",           :limit => 3,   :default => 0,  :null => false
  end

  add_index "pre_common_template_block", ["bid"], :name => "bid"

  create_table "pre_common_template_permission", :id => false, :force => true do |t|
    t.string  "targettplname",    :limit => 100, :default => "",    :null => false
    t.integer "uid",              :limit => 3,   :default => 0,     :null => false
    t.boolean "allowmanage",                     :default => false, :null => false
    t.boolean "allowrecommend",                  :default => false, :null => false
    t.boolean "needverify",                      :default => false, :null => false
    t.string  "inheritedtplname",                :default => "",    :null => false
  end

  add_index "pre_common_template_permission", ["uid"], :name => "uid"

  create_table "pre_common_uin_black", :primary_key => "uin", :force => true do |t|
    t.integer "uid",      :limit => 3, :default => 0, :null => false
    t.integer "dateline",              :default => 0, :null => false
  end

  add_index "pre_common_uin_black", ["uid"], :name => "uid", :unique => true

  create_table "pre_common_usergroup", :primary_key => "groupid", :force => true do |t|
    t.integer "radminid",        :limit => 1, :default => 0,         :null => false
    t.string  "type",            :limit => 7, :default => "member",  :null => false
    t.string  "system",                       :default => "private", :null => false
    t.string  "grouptitle",                   :default => "",        :null => false
    t.integer "creditshigher",                :default => 0,         :null => false
    t.integer "creditslower",                 :default => 0,         :null => false
    t.integer "stars",           :limit => 1, :default => 0,         :null => false
    t.string  "color",                        :default => "",        :null => false
    t.string  "icon",                         :default => "",        :null => false
    t.boolean "allowvisit",                   :default => false,     :null => false
    t.boolean "allowsendpm",                  :default => true,      :null => false
    t.boolean "allowinvite",                  :default => false,     :null => false
    t.boolean "allowmailinvite",              :default => false,     :null => false
    t.integer "maxinvitenum",    :limit => 1, :default => 0,         :null => false
    t.integer "inviteprice",     :limit => 2, :default => 0,         :null => false
    t.integer "maxinviteday",    :limit => 2, :default => 0,         :null => false
  end

  add_index "pre_common_usergroup", ["creditshigher", "creditslower"], :name => "creditsrange"

  create_table "pre_common_usergroup_field", :primary_key => "groupid", :force => true do |t|
    t.integer "readaccess",             :limit => 1,   :default => 0,     :null => false
    t.boolean "allowpost",                             :default => false, :null => false
    t.boolean "allowreply",                            :default => false, :null => false
    t.boolean "allowpostpoll",                         :default => false, :null => false
    t.boolean "allowpostreward",                       :default => false, :null => false
    t.boolean "allowposttrade",                        :default => false, :null => false
    t.boolean "allowpostactivity",                     :default => false, :null => false
    t.boolean "allowdirectpost",                       :default => false, :null => false
    t.boolean "allowgetattach",                        :default => false, :null => false
    t.boolean "allowgetimage",                         :default => false, :null => false
    t.boolean "allowpostattach",                       :default => false, :null => false
    t.boolean "allowpostimage",                        :default => false, :null => false
    t.boolean "allowvote",                             :default => false, :null => false
    t.boolean "allowsearch",                           :default => false, :null => false
    t.boolean "allowcstatus",                          :default => false, :null => false
    t.boolean "allowinvisible",                        :default => false, :null => false
    t.boolean "allowtransfer",                         :default => false, :null => false
    t.boolean "allowsetreadperm",                      :default => false, :null => false
    t.boolean "allowsetattachperm",                    :default => false, :null => false
    t.boolean "allowposttag",                          :default => false, :null => false
    t.boolean "allowhidecode",                         :default => false, :null => false
    t.boolean "allowhtml",                             :default => false, :null => false
    t.boolean "allowanonymous",                        :default => false, :null => false
    t.boolean "allowsigbbcode",                        :default => false, :null => false
    t.boolean "allowsigimgcode",                       :default => false, :null => false
    t.boolean "allowmagics",                                              :null => false
    t.boolean "disableperiodctrl",                     :default => false, :null => false
    t.boolean "reasonpm",                              :default => false, :null => false
    t.integer "maxprice",               :limit => 2,   :default => 0,     :null => false
    t.integer "maxsigsize",             :limit => 2,   :default => 0,     :null => false
    t.integer "maxattachsize",                         :default => 0,     :null => false
    t.integer "maxsizeperday",                         :default => 0,     :null => false
    t.integer "maxthreadsperhour",      :limit => 1,   :default => 0,     :null => false
    t.integer "maxpostsperhour",        :limit => 1,   :default => 0,     :null => false
    t.string  "attachextensions",       :limit => 100, :default => "",    :null => false
    t.string  "raterange",              :limit => 150, :default => "",    :null => false
    t.integer "mintradeprice",          :limit => 2,   :default => 1,     :null => false
    t.integer "maxtradeprice",          :limit => 2,   :default => 0,     :null => false
    t.integer "minrewardprice",         :limit => 2,   :default => 1,     :null => false
    t.integer "maxrewardprice",         :limit => 2,   :default => 0,     :null => false
    t.boolean "magicsdiscount",                                           :null => false
    t.integer "maxmagicsweight",        :limit => 2,                      :null => false
    t.boolean "allowpostdebate",                       :default => false, :null => false
    t.boolean "tradestick",                                               :null => false
    t.boolean "exempt",                                                   :null => false
    t.integer "maxattachnum",           :limit => 2,   :default => 0,     :null => false
    t.boolean "allowposturl",                          :default => false, :null => false
    t.boolean "allowrecommend",                        :default => true,  :null => false
    t.boolean "allowpostrushreply",                    :default => false, :null => false
    t.integer "maxfriendnum",           :limit => 2,   :default => 0,     :null => false
    t.integer "maxspacesize",                          :default => 0,     :null => false
    t.boolean "allowcomment",                          :default => false, :null => false
    t.integer "allowcommentarticle",    :limit => 2,   :default => 0,     :null => false
    t.integer "searchinterval",         :limit => 2,   :default => 0,     :null => false
    t.boolean "searchignore",                          :default => false, :null => false
    t.boolean "allowblog",                             :default => false, :null => false
    t.boolean "allowdoing",                            :default => false, :null => false
    t.boolean "allowupload",                           :default => false, :null => false
    t.boolean "allowshare",                            :default => false, :null => false
    t.boolean "allowblogmod",                          :default => false, :null => false
    t.boolean "allowdoingmod",                         :default => false, :null => false
    t.boolean "allowuploadmod",                        :default => false, :null => false
    t.boolean "allowsharemod",                         :default => false, :null => false
    t.boolean "allowcss",                              :default => false, :null => false
    t.boolean "allowpoke",                             :default => false, :null => false
    t.boolean "allowfriend",                           :default => false, :null => false
    t.boolean "allowclick",                            :default => false, :null => false
    t.boolean "allowmagic",                            :default => false, :null => false
    t.boolean "allowstat",                             :default => false, :null => false
    t.boolean "allowstatdata",                         :default => false, :null => false
    t.boolean "videophotoignore",                      :default => false, :null => false
    t.boolean "allowviewvideophoto",                   :default => false, :null => false
    t.boolean "allowmyop",                             :default => false, :null => false
    t.boolean "magicdiscount",                         :default => false, :null => false
    t.integer "domainlength",           :limit => 2,   :default => 0,     :null => false
    t.boolean "seccode",                               :default => true,  :null => false
    t.boolean "disablepostctrl",                       :default => false, :null => false
    t.boolean "allowbuildgroup",                       :default => false, :null => false
    t.boolean "allowgroupdirectpost",                  :default => false, :null => false
    t.boolean "allowgroupposturl",                     :default => false, :null => false
    t.integer "edittimelimit",          :limit => 2,   :default => 0,     :null => false
    t.boolean "allowpostarticle",                      :default => false, :null => false
    t.boolean "allowdownlocalimg",                     :default => false, :null => false
    t.boolean "allowdownremoteimg",                    :default => false, :null => false
    t.boolean "allowpostarticlemod",                   :default => false, :null => false
    t.boolean "allowspacediyhtml",                     :default => false, :null => false
    t.boolean "allowspacediybbcode",                   :default => false, :null => false
    t.boolean "allowspacediyimgcode",                  :default => false, :null => false
    t.boolean "allowcommentpost",                      :default => false, :null => false
    t.boolean "allowcommentitem",                      :default => false, :null => false
    t.boolean "allowcommentreply",                     :default => false, :null => false
    t.boolean "allowreplycredit",                      :default => false, :null => false
    t.boolean "ignorecensor",                          :default => false, :null => false
    t.boolean "allowsendallpm",                        :default => false, :null => false
    t.integer "allowsendpmmaxnum",      :limit => 2,   :default => 0,     :null => false
    t.integer "maximagesize",           :limit => 3,   :default => 0,     :null => false
    t.boolean "allowmediacode",                        :default => false, :null => false
    t.integer "allowat",                :limit => 2,   :default => 0,     :null => false
    t.boolean "allowsetpublishdate",                   :default => false, :null => false
    t.boolean "allowfollowcollection",                 :default => false, :null => false
    t.boolean "allowcommentcollection",                :default => false, :null => false
    t.integer "allowcreatecollection",  :limit => 2,   :default => 0,     :null => false
  end

  create_table "pre_common_word", :force => true do |t|
    t.string  "admin",       :limit => 15, :default => "", :null => false
    t.integer "type",        :limit => 2,  :default => 1,  :null => false
    t.string  "find",                      :default => "", :null => false
    t.string  "replacement",               :default => "", :null => false
    t.string  "extra",                     :default => "", :null => false
  end

  create_table "pre_common_word_type", :force => true do |t|
    t.string "typename", :limit => 15, :default => "", :null => false
  end

  create_table "pre_connect_disktask", :primary_key => "taskid", :force => true do |t|
    t.integer "aid",                        :default => 0,  :null => false
    t.integer "uid",                        :default => 0,  :null => false
    t.string  "openid",       :limit => 32, :default => "", :null => false
    t.string  "filename",                   :default => "", :null => false
    t.string  "verifycode",   :limit => 32, :default => "", :null => false
    t.integer "status",       :limit => 2,  :default => 0,  :null => false
    t.integer "dateline",                   :default => 0,  :null => false
    t.integer "downloadtime",               :default => 0,  :null => false
    t.text    "extra"
  end

  add_index "pre_connect_disktask", ["openid"], :name => "openid"
  add_index "pre_connect_disktask", ["status"], :name => "status"

  create_table "pre_connect_feedlog", :primary_key => "flid", :force => true do |t|
    t.integer "tid",           :limit => 3, :default => 0,    :null => false
    t.integer "uid",           :limit => 3, :default => 0,    :null => false
    t.integer "publishtimes",  :limit => 3, :default => 0,    :null => false
    t.integer "lastpublished",              :default => 0,    :null => false
    t.integer "dateline",                   :default => 0,    :null => false
    t.boolean "status",                     :default => true, :null => false
  end

  add_index "pre_connect_feedlog", ["tid"], :name => "tid", :unique => true

  create_table "pre_connect_memberbindlog", :primary_key => "mblid", :force => true do |t|
    t.integer "uid",      :limit => 3,  :default => 0,     :null => false
    t.string  "uin",      :limit => 40,                    :null => false
    t.boolean "type",                   :default => false, :null => false
    t.integer "dateline",               :default => 0,     :null => false
  end

  add_index "pre_connect_memberbindlog", ["dateline"], :name => "dateline"
  add_index "pre_connect_memberbindlog", ["uid"], :name => "uid"
  add_index "pre_connect_memberbindlog", ["uin"], :name => "uin"

  create_table "pre_connect_tthreadlog", :primary_key => "twid", :force => true do |t|
    t.integer "tid",        :limit => 3,  :default => 0, :null => false
    t.string  "conopenid",  :limit => 32,                :null => false
    t.integer "pagetime",                 :default => 0
    t.string  "lasttwid",   :limit => 16
    t.integer "nexttime",                 :default => 0
    t.integer "updatetime",               :default => 0
    t.integer "dateline",                 :default => 0
  end

  add_index "pre_connect_tthreadlog", ["tid", "nexttime"], :name => "nexttime"
  add_index "pre_connect_tthreadlog", ["tid", "updatetime"], :name => "updatetime"

  create_table "pre_forum_access", :id => false, :force => true do |t|
    t.integer "uid",             :limit => 3, :default => 0,     :null => false
    t.integer "fid",             :limit => 3, :default => 0,     :null => false
    t.boolean "allowview",                    :default => false, :null => false
    t.boolean "allowpost",                    :default => false, :null => false
    t.boolean "allowreply",                   :default => false, :null => false
    t.boolean "allowgetattach",               :default => false, :null => false
    t.boolean "allowgetimage",                :default => false, :null => false
    t.boolean "allowpostattach",              :default => false, :null => false
    t.boolean "allowpostimage",               :default => false, :null => false
    t.integer "adminuser",       :limit => 3, :default => 0,     :null => false
    t.integer "dateline",                     :default => 0,     :null => false
  end

  add_index "pre_forum_access", ["fid", "dateline"], :name => "listorder"

  create_table "pre_forum_activity", :primary_key => "tid", :force => true do |t|
    t.integer "uid",           :limit => 3, :default => 0,     :null => false
    t.integer "aid",           :limit => 3, :default => 0,     :null => false
    t.integer "cost",          :limit => 3, :default => 0,     :null => false
    t.integer "starttimefrom",              :default => 0,     :null => false
    t.integer "starttimeto",                :default => 0,     :null => false
    t.string  "place",                      :default => "",    :null => false
    t.string  "class",                      :default => "",    :null => false
    t.boolean "gender",                     :default => false, :null => false
    t.integer "number",        :limit => 2, :default => 0,     :null => false
    t.integer "applynumber",   :limit => 2, :default => 0,     :null => false
    t.integer "expiration",                 :default => 0,     :null => false
    t.text    "ufield",                                        :null => false
    t.integer "credit",        :limit => 2, :default => 0,     :null => false
  end

  add_index "pre_forum_activity", ["applynumber"], :name => "applynumber"
  add_index "pre_forum_activity", ["expiration"], :name => "expiration"
  add_index "pre_forum_activity", ["starttimefrom"], :name => "starttimefrom"
  add_index "pre_forum_activity", ["uid", "starttimefrom"], :name => "uid"

  create_table "pre_forum_activityapply", :primary_key => "applyid", :force => true do |t|
    t.integer "tid",        :limit => 3, :default => 0,     :null => false
    t.string  "username",                :default => "",    :null => false
    t.integer "uid",        :limit => 3, :default => 0,     :null => false
    t.string  "message",                 :default => "",    :null => false
    t.boolean "verified",                :default => false, :null => false
    t.integer "dateline",                :default => 0,     :null => false
    t.integer "payment",    :limit => 3, :default => 0,     :null => false
    t.text    "ufielddata",                                 :null => false
  end

  add_index "pre_forum_activityapply", ["tid", "dateline"], :name => "dateline"
  add_index "pre_forum_activityapply", ["tid"], :name => "tid"
  add_index "pre_forum_activityapply", ["uid"], :name => "uid"

  create_table "pre_forum_announcement", :force => true do |t|
    t.string  "author",       :limit => 15, :default => "",    :null => false
    t.string  "subject",                    :default => "",    :null => false
    t.boolean "type",                       :default => false, :null => false
    t.integer "displayorder", :limit => 1,  :default => 0,     :null => false
    t.integer "starttime",                  :default => 0,     :null => false
    t.integer "endtime",                    :default => 0,     :null => false
    t.text    "message",                                       :null => false
    t.text    "groups",                                        :null => false
  end

  add_index "pre_forum_announcement", ["starttime", "endtime"], :name => "timespan"

  create_table "pre_forum_attachment", :primary_key => "aid", :force => true do |t|
    t.integer "tid",       :limit => 3, :default => 0,     :null => false
    t.integer "pid",                    :default => 0,     :null => false
    t.integer "uid",       :limit => 3, :default => 0,     :null => false
    t.boolean "tableid",                :default => false, :null => false
    t.integer "downloads", :limit => 3, :default => 0,     :null => false
  end

  add_index "pre_forum_attachment", ["pid"], :name => "pid"
  add_index "pre_forum_attachment", ["tid"], :name => "tid"
  add_index "pre_forum_attachment", ["uid"], :name => "uid"

  create_table "pre_forum_attachment_0", :primary_key => "aid", :force => true do |t|
    t.integer "tid",         :limit => 3, :default => 0,     :null => false
    t.integer "pid",                      :default => 0,     :null => false
    t.integer "uid",         :limit => 3, :default => 0,     :null => false
    t.integer "dateline",                 :default => 0,     :null => false
    t.string  "filename",                 :default => "",    :null => false
    t.integer "filesize",                 :default => 0,     :null => false
    t.string  "attachment",               :default => "",    :null => false
    t.boolean "remote",                   :default => false, :null => false
    t.string  "description",                                 :null => false
    t.integer "readperm",    :limit => 1, :default => 0,     :null => false
    t.integer "price",       :limit => 2, :default => 0,     :null => false
    t.boolean "isimage",                  :default => false, :null => false
    t.integer "width",       :limit => 2, :default => 0,     :null => false
    t.boolean "thumb",                    :default => false, :null => false
    t.integer "picid",       :limit => 3, :default => 0,     :null => false
  end

  add_index "pre_forum_attachment_0", ["pid"], :name => "pid"
  add_index "pre_forum_attachment_0", ["tid"], :name => "tid"
  add_index "pre_forum_attachment_0", ["uid"], :name => "uid"

  create_table "pre_forum_attachment_1", :primary_key => "aid", :force => true do |t|
    t.integer "tid",         :limit => 3, :default => 0,     :null => false
    t.integer "pid",                      :default => 0,     :null => false
    t.integer "uid",         :limit => 3, :default => 0,     :null => false
    t.integer "dateline",                 :default => 0,     :null => false
    t.string  "filename",                 :default => "",    :null => false
    t.integer "filesize",                 :default => 0,     :null => false
    t.string  "attachment",               :default => "",    :null => false
    t.boolean "remote",                   :default => false, :null => false
    t.string  "description",                                 :null => false
    t.integer "readperm",    :limit => 1, :default => 0,     :null => false
    t.integer "price",       :limit => 2, :default => 0,     :null => false
    t.boolean "isimage",                  :default => false, :null => false
    t.integer "width",       :limit => 2, :default => 0,     :null => false
    t.boolean "thumb",                    :default => false, :null => false
    t.integer "picid",       :limit => 3, :default => 0,     :null => false
  end

  add_index "pre_forum_attachment_1", ["pid"], :name => "pid"
  add_index "pre_forum_attachment_1", ["tid"], :name => "tid"
  add_index "pre_forum_attachment_1", ["uid"], :name => "uid"

  create_table "pre_forum_attachment_2", :primary_key => "aid", :force => true do |t|
    t.integer "tid",         :limit => 3, :default => 0,     :null => false
    t.integer "pid",                      :default => 0,     :null => false
    t.integer "uid",         :limit => 3, :default => 0,     :null => false
    t.integer "dateline",                 :default => 0,     :null => false
    t.string  "filename",                 :default => "",    :null => false
    t.integer "filesize",                 :default => 0,     :null => false
    t.string  "attachment",               :default => "",    :null => false
    t.boolean "remote",                   :default => false, :null => false
    t.string  "description",                                 :null => false
    t.integer "readperm",    :limit => 1, :default => 0,     :null => false
    t.integer "price",       :limit => 2, :default => 0,     :null => false
    t.boolean "isimage",                  :default => false, :null => false
    t.integer "width",       :limit => 2, :default => 0,     :null => false
    t.boolean "thumb",                    :default => false, :null => false
    t.integer "picid",       :limit => 3, :default => 0,     :null => false
  end

  add_index "pre_forum_attachment_2", ["pid"], :name => "pid"
  add_index "pre_forum_attachment_2", ["tid"], :name => "tid"
  add_index "pre_forum_attachment_2", ["uid"], :name => "uid"

  create_table "pre_forum_attachment_3", :primary_key => "aid", :force => true do |t|
    t.integer "tid",         :limit => 3, :default => 0,     :null => false
    t.integer "pid",                      :default => 0,     :null => false
    t.integer "uid",         :limit => 3, :default => 0,     :null => false
    t.integer "dateline",                 :default => 0,     :null => false
    t.string  "filename",                 :default => "",    :null => false
    t.integer "filesize",                 :default => 0,     :null => false
    t.string  "attachment",               :default => "",    :null => false
    t.boolean "remote",                   :default => false, :null => false
    t.string  "description",                                 :null => false
    t.integer "readperm",    :limit => 1, :default => 0,     :null => false
    t.integer "price",       :limit => 2, :default => 0,     :null => false
    t.boolean "isimage",                  :default => false, :null => false
    t.integer "width",       :limit => 2, :default => 0,     :null => false
    t.boolean "thumb",                    :default => false, :null => false
    t.integer "picid",       :limit => 3, :default => 0,     :null => false
  end

  add_index "pre_forum_attachment_3", ["pid"], :name => "pid"
  add_index "pre_forum_attachment_3", ["tid"], :name => "tid"
  add_index "pre_forum_attachment_3", ["uid"], :name => "uid"

  create_table "pre_forum_attachment_4", :primary_key => "aid", :force => true do |t|
    t.integer "tid",         :limit => 3, :default => 0,     :null => false
    t.integer "pid",                      :default => 0,     :null => false
    t.integer "uid",         :limit => 3, :default => 0,     :null => false
    t.integer "dateline",                 :default => 0,     :null => false
    t.string  "filename",                 :default => "",    :null => false
    t.integer "filesize",                 :default => 0,     :null => false
    t.string  "attachment",               :default => "",    :null => false
    t.boolean "remote",                   :default => false, :null => false
    t.string  "description",                                 :null => false
    t.integer "readperm",    :limit => 1, :default => 0,     :null => false
    t.integer "price",       :limit => 2, :default => 0,     :null => false
    t.boolean "isimage",                  :default => false, :null => false
    t.integer "width",       :limit => 2, :default => 0,     :null => false
    t.boolean "thumb",                    :default => false, :null => false
    t.integer "picid",       :limit => 3, :default => 0,     :null => false
  end

  add_index "pre_forum_attachment_4", ["pid"], :name => "pid"
  add_index "pre_forum_attachment_4", ["tid"], :name => "tid"
  add_index "pre_forum_attachment_4", ["uid"], :name => "uid"

  create_table "pre_forum_attachment_5", :primary_key => "aid", :force => true do |t|
    t.integer "tid",         :limit => 3, :default => 0,     :null => false
    t.integer "pid",                      :default => 0,     :null => false
    t.integer "uid",         :limit => 3, :default => 0,     :null => false
    t.integer "dateline",                 :default => 0,     :null => false
    t.string  "filename",                 :default => "",    :null => false
    t.integer "filesize",                 :default => 0,     :null => false
    t.string  "attachment",               :default => "",    :null => false
    t.boolean "remote",                   :default => false, :null => false
    t.string  "description",                                 :null => false
    t.integer "readperm",    :limit => 1, :default => 0,     :null => false
    t.integer "price",       :limit => 2, :default => 0,     :null => false
    t.boolean "isimage",                  :default => false, :null => false
    t.integer "width",       :limit => 2, :default => 0,     :null => false
    t.boolean "thumb",                    :default => false, :null => false
    t.integer "picid",       :limit => 3, :default => 0,     :null => false
  end

  add_index "pre_forum_attachment_5", ["pid"], :name => "pid"
  add_index "pre_forum_attachment_5", ["tid"], :name => "tid"
  add_index "pre_forum_attachment_5", ["uid"], :name => "uid"

  create_table "pre_forum_attachment_6", :primary_key => "aid", :force => true do |t|
    t.integer "tid",         :limit => 3, :default => 0,     :null => false
    t.integer "pid",                      :default => 0,     :null => false
    t.integer "uid",         :limit => 3, :default => 0,     :null => false
    t.integer "dateline",                 :default => 0,     :null => false
    t.string  "filename",                 :default => "",    :null => false
    t.integer "filesize",                 :default => 0,     :null => false
    t.string  "attachment",               :default => "",    :null => false
    t.boolean "remote",                   :default => false, :null => false
    t.string  "description",                                 :null => false
    t.integer "readperm",    :limit => 1, :default => 0,     :null => false
    t.integer "price",       :limit => 2, :default => 0,     :null => false
    t.boolean "isimage",                  :default => false, :null => false
    t.integer "width",       :limit => 2, :default => 0,     :null => false
    t.boolean "thumb",                    :default => false, :null => false
    t.integer "picid",       :limit => 3, :default => 0,     :null => false
  end

  add_index "pre_forum_attachment_6", ["pid"], :name => "pid"
  add_index "pre_forum_attachment_6", ["tid"], :name => "tid"
  add_index "pre_forum_attachment_6", ["uid"], :name => "uid"

  create_table "pre_forum_attachment_7", :primary_key => "aid", :force => true do |t|
    t.integer "tid",         :limit => 3, :default => 0,     :null => false
    t.integer "pid",                      :default => 0,     :null => false
    t.integer "uid",         :limit => 3, :default => 0,     :null => false
    t.integer "dateline",                 :default => 0,     :null => false
    t.string  "filename",                 :default => "",    :null => false
    t.integer "filesize",                 :default => 0,     :null => false
    t.string  "attachment",               :default => "",    :null => false
    t.boolean "remote",                   :default => false, :null => false
    t.string  "description",                                 :null => false
    t.integer "readperm",    :limit => 1, :default => 0,     :null => false
    t.integer "price",       :limit => 2, :default => 0,     :null => false
    t.boolean "isimage",                  :default => false, :null => false
    t.integer "width",       :limit => 2, :default => 0,     :null => false
    t.boolean "thumb",                    :default => false, :null => false
    t.integer "picid",       :limit => 3, :default => 0,     :null => false
  end

  add_index "pre_forum_attachment_7", ["pid"], :name => "pid"
  add_index "pre_forum_attachment_7", ["tid"], :name => "tid"
  add_index "pre_forum_attachment_7", ["uid"], :name => "uid"

  create_table "pre_forum_attachment_8", :primary_key => "aid", :force => true do |t|
    t.integer "tid",         :limit => 3, :default => 0,     :null => false
    t.integer "pid",                      :default => 0,     :null => false
    t.integer "uid",         :limit => 3, :default => 0,     :null => false
    t.integer "dateline",                 :default => 0,     :null => false
    t.string  "filename",                 :default => "",    :null => false
    t.integer "filesize",                 :default => 0,     :null => false
    t.string  "attachment",               :default => "",    :null => false
    t.boolean "remote",                   :default => false, :null => false
    t.string  "description",                                 :null => false
    t.integer "readperm",    :limit => 1, :default => 0,     :null => false
    t.integer "price",       :limit => 2, :default => 0,     :null => false
    t.boolean "isimage",                  :default => false, :null => false
    t.integer "width",       :limit => 2, :default => 0,     :null => false
    t.boolean "thumb",                    :default => false, :null => false
    t.integer "picid",       :limit => 3, :default => 0,     :null => false
  end

  add_index "pre_forum_attachment_8", ["pid"], :name => "pid"
  add_index "pre_forum_attachment_8", ["tid"], :name => "tid"
  add_index "pre_forum_attachment_8", ["uid"], :name => "uid"

  create_table "pre_forum_attachment_9", :primary_key => "aid", :force => true do |t|
    t.integer "tid",         :limit => 3, :default => 0,     :null => false
    t.integer "pid",                      :default => 0,     :null => false
    t.integer "uid",         :limit => 3, :default => 0,     :null => false
    t.integer "dateline",                 :default => 0,     :null => false
    t.string  "filename",                 :default => "",    :null => false
    t.integer "filesize",                 :default => 0,     :null => false
    t.string  "attachment",               :default => "",    :null => false
    t.boolean "remote",                   :default => false, :null => false
    t.string  "description",                                 :null => false
    t.integer "readperm",    :limit => 1, :default => 0,     :null => false
    t.integer "price",       :limit => 2, :default => 0,     :null => false
    t.boolean "isimage",                  :default => false, :null => false
    t.integer "width",       :limit => 2, :default => 0,     :null => false
    t.boolean "thumb",                    :default => false, :null => false
    t.integer "picid",       :limit => 3, :default => 0,     :null => false
  end

  add_index "pre_forum_attachment_9", ["pid"], :name => "pid"
  add_index "pre_forum_attachment_9", ["tid"], :name => "tid"
  add_index "pre_forum_attachment_9", ["uid"], :name => "uid"

  create_table "pre_forum_attachment_exif", :primary_key => "aid", :force => true do |t|
    t.text "exif", :null => false
  end

  create_table "pre_forum_attachment_unused", :primary_key => "aid", :force => true do |t|
    t.integer "uid",        :limit => 3, :default => 0,     :null => false
    t.integer "dateline",                :default => 0,     :null => false
    t.string  "filename",                :default => "",    :null => false
    t.integer "filesize",                :default => 0,     :null => false
    t.string  "attachment",              :default => "",    :null => false
    t.boolean "remote",                  :default => false, :null => false
    t.boolean "isimage",                 :default => false, :null => false
    t.integer "width",      :limit => 2, :default => 0,     :null => false
    t.boolean "thumb",                   :default => false, :null => false
  end

  add_index "pre_forum_attachment_unused", ["uid"], :name => "uid"

  create_table "pre_forum_attachtype", :force => true do |t|
    t.integer "fid",       :limit => 3,  :default => 0,  :null => false
    t.string  "extension", :limit => 12, :default => "", :null => false
    t.integer "maxsize",                 :default => 0,  :null => false
  end

  add_index "pre_forum_attachtype", ["fid"], :name => "fid"

  create_table "pre_forum_bbcode", :force => true do |t|
    t.boolean "available",                   :default => false, :null => false
    t.string  "tag",          :limit => 100, :default => "",    :null => false
    t.string  "icon",                                           :null => false
    t.text    "replacement",                                    :null => false
    t.string  "example",                     :default => "",    :null => false
    t.text    "explanation",                                    :null => false
    t.boolean "params",                      :default => true,  :null => false
    t.text    "prompt",                                         :null => false
    t.integer "nest",         :limit => 1,   :default => 1,     :null => false
    t.integer "displayorder", :limit => 1,   :default => 0,     :null => false
    t.text    "perm",                                           :null => false
  end

  create_table "pre_forum_collection", :primary_key => "ctid", :force => true do |t|
    t.integer "uid",          :limit => 3,  :default => 0,   :null => false
    t.string  "username",     :limit => 15, :default => "",  :null => false
    t.string  "name",         :limit => 50, :default => "",  :null => false
    t.integer "dateline",                   :default => 0,   :null => false
    t.integer "follownum",    :limit => 3,  :default => 0,   :null => false
    t.integer "threadnum",    :limit => 3,  :default => 0,   :null => false
    t.integer "commentnum",   :limit => 3,  :default => 0,   :null => false
    t.string  "desc",                       :default => "",  :null => false
    t.integer "lastupdate",                 :default => 0,   :null => false
    t.float   "rate",                       :default => 0.0, :null => false
    t.integer "ratenum",      :limit => 3,  :default => 0,   :null => false
    t.integer "lastpost",     :limit => 3,  :default => 0,   :null => false
    t.string  "lastsubject",  :limit => 80, :default => "",  :null => false
    t.integer "lastposttime",               :default => 0,   :null => false
    t.string  "lastposter",   :limit => 15, :default => "",  :null => false
    t.integer "lastvisit",                  :default => 0,   :null => false
    t.string  "keyword",                    :default => "",  :null => false
  end

  add_index "pre_forum_collection", ["dateline"], :name => "dateline"
  add_index "pre_forum_collection", ["follownum"], :name => "follownum"
  add_index "pre_forum_collection", ["threadnum", "lastupdate"], :name => "hotcollection"

  create_table "pre_forum_collectioncomment", :primary_key => "cid", :force => true do |t|
    t.integer "ctid",     :limit => 3,  :default => 0,   :null => false
    t.integer "uid",      :limit => 3,  :default => 0,   :null => false
    t.string  "username", :limit => 15, :default => "",  :null => false
    t.text    "message",                                 :null => false
    t.integer "dateline",               :default => 0,   :null => false
    t.string  "useip",    :limit => 16, :default => "",  :null => false
    t.float   "rate",                   :default => 0.0, :null => false
  end

  add_index "pre_forum_collectioncomment", ["ctid", "dateline"], :name => "ctid"
  add_index "pre_forum_collectioncomment", ["ctid", "uid", "rate"], :name => "userrate"

  create_table "pre_forum_collectionfollow", :id => false, :force => true do |t|
    t.integer "uid",       :limit => 3,  :default => 0,  :null => false
    t.string  "username",  :limit => 15, :default => "", :null => false
    t.integer "ctid",      :limit => 3,  :default => 0,  :null => false
    t.integer "dateline",                :default => 0,  :null => false
    t.integer "lastvisit",               :default => 0,  :null => false
  end

  add_index "pre_forum_collectionfollow", ["ctid", "dateline"], :name => "ctid"

  create_table "pre_forum_collectioninvite", :id => false, :force => true do |t|
    t.integer "ctid",     :limit => 3, :default => 0, :null => false
    t.integer "uid",      :limit => 3, :default => 0, :null => false
    t.integer "dateline",              :default => 0, :null => false
  end

  add_index "pre_forum_collectioninvite", ["dateline"], :name => "dateline"

  create_table "pre_forum_collectionrelated", :primary_key => "tid", :force => true do |t|
    t.text "collection", :null => false
  end

  create_table "pre_forum_collectionteamworker", :id => false, :force => true do |t|
    t.integer "ctid",      :limit => 3,  :default => 0,  :null => false
    t.integer "uid",       :limit => 3,  :default => 0,  :null => false
    t.string  "name",      :limit => 50, :default => "", :null => false
    t.string  "username",  :limit => 15, :default => "", :null => false
    t.integer "lastvisit",               :default => 0,  :null => false
  end

  create_table "pre_forum_collectionthread", :id => false, :force => true do |t|
    t.integer "ctid",     :limit => 3, :default => 0,  :null => false
    t.integer "tid",      :limit => 3, :default => 0,  :null => false
    t.integer "dateline",              :default => 0,  :null => false
    t.string  "reason",                :default => "", :null => false
  end

  add_index "pre_forum_collectionthread", ["ctid", "dateline"], :name => "ctid"

  create_table "pre_forum_creditslog", :id => false, :force => true do |t|
    t.integer "uid",            :limit => 3,  :default => 0,     :null => false
    t.string  "fromto",         :limit => 15, :default => "",    :null => false
    t.boolean "sendcredits",                  :default => false, :null => false
    t.boolean "receivecredits",               :default => false, :null => false
    t.integer "send",                         :default => 0,     :null => false
    t.integer "receive",                      :default => 0,     :null => false
    t.integer "dateline",                     :default => 0,     :null => false
    t.string  "operation",      :limit => 3,  :default => "",    :null => false
  end

  add_index "pre_forum_creditslog", ["uid", "dateline"], :name => "uid"

  create_table "pre_forum_debate", :primary_key => "tid", :force => true do |t|
    t.integer "uid",            :limit => 3,  :default => 0,     :null => false
    t.integer "starttime",                    :default => 0,     :null => false
    t.integer "endtime",                      :default => 0,     :null => false
    t.integer "affirmdebaters", :limit => 3,  :default => 0,     :null => false
    t.integer "negadebaters",   :limit => 3,  :default => 0,     :null => false
    t.integer "affirmvotes",    :limit => 3,  :default => 0,     :null => false
    t.integer "negavotes",      :limit => 3,  :default => 0,     :null => false
    t.string  "umpire",         :limit => 15, :default => "",    :null => false
    t.boolean "winner",                       :default => false, :null => false
    t.string  "bestdebater",    :limit => 50, :default => "",    :null => false
    t.text    "affirmpoint",                                     :null => false
    t.text    "negapoint",                                       :null => false
    t.text    "umpirepoint",                                     :null => false
    t.text    "affirmvoterids",                                  :null => false
    t.text    "negavoterids",                                    :null => false
    t.integer "affirmreplies",  :limit => 3,                     :null => false
    t.integer "negareplies",    :limit => 3,                     :null => false
  end

  add_index "pre_forum_debate", ["uid", "starttime"], :name => "uid"

  create_table "pre_forum_debatepost", :primary_key => "pid", :force => true do |t|
    t.boolean "stand",                 :default => false, :null => false
    t.integer "tid",      :limit => 3, :default => 0,     :null => false
    t.integer "uid",      :limit => 3, :default => 0,     :null => false
    t.integer "dateline",              :default => 0,     :null => false
    t.integer "voters",   :limit => 3, :default => 0,     :null => false
    t.text    "voterids",                                 :null => false
  end

  add_index "pre_forum_debatepost", ["pid", "stand"], :name => "pid"
  add_index "pre_forum_debatepost", ["tid", "uid"], :name => "tid"

  create_table "pre_forum_faq", :force => true do |t|
    t.integer "fpid",         :limit => 2,  :default => 0, :null => false
    t.integer "displayorder", :limit => 1,  :default => 0, :null => false
    t.string  "identifier",   :limit => 20,                :null => false
    t.string  "keyword",      :limit => 50,                :null => false
    t.string  "title",        :limit => 50,                :null => false
    t.text    "message",                                   :null => false
  end

  add_index "pre_forum_faq", ["displayorder"], :name => "displayplay"

  create_table "pre_forum_forum", :primary_key => "fid", :force => true do |t|
    t.integer "fup",              :limit => 3,   :default => 0,       :null => false
    t.string  "type",             :limit => 5,   :default => "forum", :null => false
    t.string  "name",             :limit => 88,  :default => "",      :null => false
    t.boolean "status",                          :default => false,   :null => false
    t.integer "displayorder",     :limit => 2,   :default => 0,       :null => false
    t.integer "styleid",          :limit => 2,   :default => 0,       :null => false
    t.integer "threads",          :limit => 3,   :default => 0,       :null => false
    t.integer "posts",            :limit => 3,   :default => 0,       :null => false
    t.integer "todayposts",       :limit => 3,   :default => 0,       :null => false
    t.string  "lastpost",         :limit => 110, :default => "",      :null => false
    t.string  "domain",           :limit => 15,  :default => "",      :null => false
    t.boolean "allowsmilies",                    :default => false,   :null => false
    t.boolean "allowhtml",                       :default => false,   :null => false
    t.boolean "allowbbcode",                     :default => false,   :null => false
    t.boolean "allowimgcode",                    :default => false,   :null => false
    t.boolean "allowmediacode",                  :default => false,   :null => false
    t.boolean "allowanonymous",                  :default => false,   :null => false
    t.integer "allowpostspecial", :limit => 2,   :default => 0,       :null => false
    t.boolean "allowspecialonly",                :default => false,   :null => false
    t.boolean "allowappend",                     :default => false,   :null => false
    t.boolean "alloweditrules",                  :default => false,   :null => false
    t.boolean "allowfeed",                       :default => true,    :null => false
    t.boolean "allowside",                       :default => false,   :null => false
    t.boolean "recyclebin",                      :default => false,   :null => false
    t.boolean "modnewposts",                     :default => false,   :null => false
    t.boolean "jammer",                          :default => false,   :null => false
    t.boolean "disablewatermark",                :default => false,   :null => false
    t.boolean "inheritedmod",                    :default => false,   :null => false
    t.integer "autoclose",        :limit => 2,   :default => 0,       :null => false
    t.integer "forumcolumns",     :limit => 1,   :default => 0,       :null => false
    t.integer "catforumcolumns",  :limit => 1,   :default => 0,       :null => false
    t.boolean "threadcaches",                    :default => false,   :null => false
    t.boolean "alloweditpost",                   :default => true,    :null => false
    t.boolean "simple",                          :default => false,   :null => false
    t.boolean "modworks",                        :default => false,   :null => false
    t.boolean "allowglobalstick",                :default => true,    :null => false
    t.integer "level",            :limit => 2,   :default => 0,       :null => false
    t.integer "commoncredits",                   :default => 0,       :null => false
    t.boolean "archive",                         :default => false,   :null => false
    t.integer "recommend",        :limit => 2,   :default => 0,       :null => false
    t.integer "favtimes",         :limit => 3,   :default => 0,       :null => false
    t.integer "sharetimes",       :limit => 3,   :default => 0,       :null => false
    t.boolean "disablethumb",                    :default => false,   :null => false
    t.boolean "disablecollect",                  :default => false,   :null => false
  end

  add_index "pre_forum_forum", ["fup", "type", "displayorder"], :name => "fup_type"
  add_index "pre_forum_forum", ["fup"], :name => "fup"
  add_index "pre_forum_forum", ["status", "type", "displayorder"], :name => "forum"

  create_table "pre_forum_forum_threadtable", :id => false, :force => true do |t|
    t.integer "fid",           :limit => 2,                :null => false
    t.integer "threadtableid", :limit => 2,                :null => false
    t.integer "threads",                    :default => 0, :null => false
    t.integer "posts",                      :default => 0, :null => false
  end

  create_table "pre_forum_forumfield", :primary_key => "fid", :force => true do |t|
    t.text    "description",                                             :null => false
    t.string  "password",         :limit => 12,       :default => "",    :null => false
    t.string  "icon",                                 :default => "",    :null => false
    t.string  "redirect",                             :default => "",    :null => false
    t.string  "attachextensions",                     :default => "",    :null => false
    t.text    "creditspolicy",    :limit => 16777215,                    :null => false
    t.text    "formulaperm",                                             :null => false
    t.text    "moderators",                                              :null => false
    t.text    "rules",                                                   :null => false
    t.text    "threadtypes",                                             :null => false
    t.text    "threadsorts",                                             :null => false
    t.text    "viewperm",                                                :null => false
    t.text    "postperm",                                                :null => false
    t.text    "replyperm",                                               :null => false
    t.text    "getattachperm",                                           :null => false
    t.text    "postattachperm",                                          :null => false
    t.text    "postimageperm",                                           :null => false
    t.text    "spviewperm",                                              :null => false
    t.text    "seotitle",                                                :null => false
    t.text    "keywords",                                                :null => false
    t.text    "seodescription",                                          :null => false
    t.text    "supe_pushsetting",                                        :null => false
    t.text    "modrecommend",                                            :null => false
    t.text    "threadplugin",                                            :null => false
    t.text    "extra",                                                   :null => false
    t.boolean "jointype",                             :default => false, :null => false
    t.boolean "gviewperm",                            :default => false, :null => false
    t.integer "membernum",        :limit => 2,        :default => 0,     :null => false
    t.integer "dateline",                             :default => 0,     :null => false
    t.integer "lastupdate",                           :default => 0,     :null => false
    t.integer "activity",                             :default => 0,     :null => false
    t.integer "founderuid",       :limit => 3,        :default => 0,     :null => false
    t.string  "foundername",                          :default => "",    :null => false
    t.string  "banner",                               :default => "",    :null => false
    t.integer "groupnum",         :limit => 2,        :default => 0,     :null => false
    t.text    "commentitem",                                             :null => false
    t.text    "relatedgroup",                                            :null => false
    t.boolean "picstyle",                             :default => false, :null => false
    t.boolean "widthauto",                            :default => false, :null => false
  end

  add_index "pre_forum_forumfield", ["activity"], :name => "activity"
  add_index "pre_forum_forumfield", ["dateline"], :name => "dateline"
  add_index "pre_forum_forumfield", ["lastupdate"], :name => "lastupdate"
  add_index "pre_forum_forumfield", ["membernum"], :name => "membernum"

  create_table "pre_forum_forumrecommend", :primary_key => "tid", :force => true do |t|
    t.integer "fid",          :limit => 3,   :default => 0,     :null => false
    t.integer "typeid",       :limit => 2,                      :null => false
    t.boolean "displayorder",                                   :null => false
    t.string  "subject",      :limit => 80,                     :null => false
    t.string  "author",       :limit => 15,                     :null => false
    t.integer "authorid",     :limit => 3,                      :null => false
    t.integer "moderatorid",  :limit => 3,                      :null => false
    t.integer "expiration",                                     :null => false
    t.boolean "position",                    :default => false, :null => false
    t.boolean "highlight",                   :default => false, :null => false
    t.integer "aid",          :limit => 3,   :default => 0,     :null => false
    t.string  "filename",     :limit => 100, :default => "",    :null => false
  end

  add_index "pre_forum_forumrecommend", ["fid", "displayorder"], :name => "displayorder"
  add_index "pre_forum_forumrecommend", ["position"], :name => "position"

  create_table "pre_forum_groupcreditslog", :id => false, :force => true do |t|
    t.integer "fid",     :limit => 3,                :null => false
    t.integer "uid",     :limit => 3,                :null => false
    t.integer "logdate",              :default => 0, :null => false
  end

  create_table "pre_forum_groupfield", :id => false, :force => true do |t|
    t.integer "fid",      :limit => 3, :default => 0,     :null => false
    t.boolean "privacy",               :default => false, :null => false
    t.integer "dateline",              :default => 0,     :null => false
    t.string  "type",                                     :null => false
    t.text    "data",                                     :null => false
  end

  add_index "pre_forum_groupfield", ["fid", "type"], :name => "types", :unique => true
  add_index "pre_forum_groupfield", ["fid"], :name => "fid"
  add_index "pre_forum_groupfield", ["type"], :name => "type"

  create_table "pre_forum_groupinvite", :id => false, :force => true do |t|
    t.integer "fid",       :limit => 3, :default => 0, :null => false
    t.integer "uid",       :limit => 3, :default => 0, :null => false
    t.integer "inviteuid", :limit => 3, :default => 0, :null => false
    t.integer "dateline",               :default => 0, :null => false
  end

  add_index "pre_forum_groupinvite", ["dateline"], :name => "dateline"
  add_index "pre_forum_groupinvite", ["fid", "inviteuid"], :name => "ids", :unique => true

  create_table "pre_forum_grouplevel", :primary_key => "levelid", :force => true do |t|
    t.string  "type",          :limit => 7, :default => "default", :null => false
    t.string  "leveltitle",                 :default => "",        :null => false
    t.integer "creditshigher",              :default => 0,         :null => false
    t.integer "creditslower",               :default => 0,         :null => false
    t.string  "icon",                       :default => "",        :null => false
    t.text    "creditspolicy",                                     :null => false
    t.text    "postpolicy",                                        :null => false
    t.text    "specialswitch",                                     :null => false
  end

  add_index "pre_forum_grouplevel", ["creditshigher", "creditslower"], :name => "creditsrange"

  create_table "pre_forum_groupuser", :id => false, :force => true do |t|
    t.integer "fid",          :limit => 3,  :default => 0,     :null => false
    t.integer "uid",          :limit => 3,  :default => 0,     :null => false
    t.string  "username",     :limit => 15,                    :null => false
    t.integer "level",        :limit => 1,  :default => 0,     :null => false
    t.integer "threads",      :limit => 3,  :default => 0,     :null => false
    t.integer "replies",      :limit => 3,  :default => 0,     :null => false
    t.integer "joindateline",               :default => 0,     :null => false
    t.integer "lastupdate",                 :default => 0,     :null => false
    t.boolean "privacy",                    :default => false, :null => false
  end

  add_index "pre_forum_groupuser", ["fid", "level", "lastupdate"], :name => "userlist"
  add_index "pre_forum_groupuser", ["uid", "lastupdate"], :name => "uid_lastupdate"

  create_table "pre_forum_imagetype", :primary_key => "typeid", :force => true do |t|
    t.boolean "available",                   :default => false,    :null => false
    t.string  "name",         :limit => 20,                        :null => false
    t.string  "type",         :limit => 6,   :default => "smiley", :null => false
    t.integer "displayorder", :limit => 1,   :default => 0,        :null => false
    t.string  "directory",    :limit => 100,                       :null => false
  end

  create_table "pre_forum_medal", :primary_key => "medalid", :force => true do |t|
    t.string  "name",         :limit => 50,       :default => "",    :null => false
    t.boolean "available",                        :default => false, :null => false
    t.string  "image",                            :default => "",    :null => false
    t.boolean "type",                             :default => false, :null => false
    t.integer "displayorder", :limit => 1,        :default => 0,     :null => false
    t.string  "description",                                         :null => false
    t.integer "expiration",   :limit => 2,        :default => 0,     :null => false
    t.text    "permission",   :limit => 16777215,                    :null => false
    t.boolean "credit",                           :default => false, :null => false
    t.integer "price",        :limit => 3,        :default => 0,     :null => false
  end

  add_index "pre_forum_medal", ["available", "displayorder"], :name => "available"
  add_index "pre_forum_medal", ["displayorder"], :name => "displayorder"

  create_table "pre_forum_medallog", :force => true do |t|
    t.integer "uid",        :limit => 3, :default => 0,     :null => false
    t.integer "medalid",    :limit => 2, :default => 0,     :null => false
    t.boolean "type",                    :default => false, :null => false
    t.integer "dateline",                :default => 0,     :null => false
    t.integer "expiration",              :default => 0,     :null => false
    t.boolean "status",                  :default => false, :null => false
  end

  add_index "pre_forum_medallog", ["dateline"], :name => "dateline"
  add_index "pre_forum_medallog", ["status", "expiration"], :name => "status"
  add_index "pre_forum_medallog", ["type"], :name => "type"
  add_index "pre_forum_medallog", ["uid", "medalid", "type"], :name => "uid"

  create_table "pre_forum_memberrecommend", :id => false, :force => true do |t|
    t.integer "tid",          :limit => 3, :null => false
    t.integer "recommenduid", :limit => 3, :null => false
    t.integer "dateline",                  :null => false
  end

  add_index "pre_forum_memberrecommend", ["recommenduid"], :name => "uid"
  add_index "pre_forum_memberrecommend", ["tid"], :name => "tid"

  create_table "pre_forum_moderator", :id => false, :force => true do |t|
    t.integer "uid",          :limit => 3, :default => 0,     :null => false
    t.integer "fid",          :limit => 3, :default => 0,     :null => false
    t.integer "displayorder", :limit => 1, :default => 0,     :null => false
    t.boolean "inherited",                 :default => false, :null => false
  end

  create_table "pre_forum_modwork", :id => false, :force => true do |t|
    t.integer "uid",       :limit => 3, :default => 0,            :null => false
    t.string  "modaction", :limit => 3, :default => "",           :null => false
    t.date    "dateline",               :default => '2006-01-01', :null => false
    t.integer "count",     :limit => 2, :default => 0,            :null => false
    t.integer "posts",     :limit => 2, :default => 0,            :null => false
  end

  add_index "pre_forum_modwork", ["uid", "dateline"], :name => "uid"

  create_table "pre_forum_onlinelist", :id => false, :force => true do |t|
    t.integer "groupid",      :limit => 2,  :default => 0,  :null => false
    t.integer "displayorder", :limit => 1,  :default => 0,  :null => false
    t.string  "title",        :limit => 30, :default => "", :null => false
    t.string  "url",          :limit => 30, :default => "", :null => false
  end

  create_table "pre_forum_order", :id => false, :force => true do |t|
    t.string  "orderid",     :limit => 32, :default => "",  :null => false
    t.string  "status",      :limit => 3,  :default => "",  :null => false
    t.string  "buyer",       :limit => 50, :default => "",  :null => false
    t.string  "admin",       :limit => 15, :default => "",  :null => false
    t.integer "uid",         :limit => 3,  :default => 0,   :null => false
    t.integer "amount",                    :default => 0,   :null => false
    t.float   "price",       :limit => 7,  :default => 0.0, :null => false
    t.integer "submitdate",                :default => 0,   :null => false
    t.integer "confirmdate",               :default => 0,   :null => false
    t.string  "email",       :limit => 40, :default => "",  :null => false
    t.string  "ip",          :limit => 15, :default => "",  :null => false
  end

  add_index "pre_forum_order", ["orderid"], :name => "orderid", :unique => true
  add_index "pre_forum_order", ["submitdate"], :name => "submitdate"
  add_index "pre_forum_order", ["uid", "submitdate"], :name => "uid"

  create_table "pre_forum_poll", :primary_key => "tid", :force => true do |t|
    t.boolean "overt",                    :default => false, :null => false
    t.boolean "multiple",                 :default => false, :null => false
    t.boolean "visible",                  :default => false, :null => false
    t.integer "maxchoices",  :limit => 1, :default => 0,     :null => false
    t.integer "expiration",               :default => 0,     :null => false
    t.string  "pollpreview",              :default => "",    :null => false
    t.integer "voters",      :limit => 3, :default => 0,     :null => false
  end

  create_table "pre_forum_polloption", :primary_key => "polloptionid", :force => true do |t|
    t.integer "tid",          :limit => 3,        :default => 0,  :null => false
    t.integer "votes",        :limit => 3,        :default => 0,  :null => false
    t.integer "displayorder", :limit => 1,        :default => 0,  :null => false
    t.string  "polloption",   :limit => 80,       :default => "", :null => false
    t.text    "voterids",     :limit => 16777215,                 :null => false
  end

  add_index "pre_forum_polloption", ["tid", "displayorder"], :name => "tid"

  create_table "pre_forum_pollvoter", :id => false, :force => true do |t|
    t.integer "tid",      :limit => 3,  :default => 0,  :null => false
    t.integer "uid",      :limit => 3,  :default => 0,  :null => false
    t.string  "username", :limit => 15, :default => "", :null => false
    t.text    "options",                                :null => false
    t.integer "dateline",               :default => 0,  :null => false
  end

  add_index "pre_forum_pollvoter", ["tid"], :name => "tid"
  add_index "pre_forum_pollvoter", ["uid", "dateline"], :name => "uid"

  create_table "pre_forum_post", :id => false, :force => true do |t|
    t.integer "pid",                                                :null => false
    t.integer "fid",         :limit => 3,        :default => 0,     :null => false
    t.integer "tid",         :limit => 3,        :default => 0,     :null => false
    t.boolean "first",                           :default => false, :null => false
    t.string  "author",      :limit => 15,       :default => "",    :null => false
    t.integer "authorid",    :limit => 3,        :default => 0,     :null => false
    t.string  "subject",     :limit => 80,       :default => "",    :null => false
    t.integer "dateline",                        :default => 0,     :null => false
    t.text    "message",     :limit => 16777215,                    :null => false
    t.string  "useip",       :limit => 15,       :default => "",    :null => false
    t.boolean "invisible",                       :default => false, :null => false
    t.boolean "anonymous",                       :default => false, :null => false
    t.boolean "usesig",                          :default => false, :null => false
    t.boolean "htmlon",                          :default => false, :null => false
    t.boolean "bbcodeoff",                       :default => false, :null => false
    t.boolean "smileyoff",                       :default => false, :null => false
    t.boolean "parseurloff",                     :default => false, :null => false
    t.boolean "attachment",                      :default => false, :null => false
    t.integer "rate",        :limit => 2,        :default => 0,     :null => false
    t.integer "ratetimes",   :limit => 1,        :default => 0,     :null => false
    t.integer "status",                          :default => 0,     :null => false
    t.string  "tags",                            :default => "0",   :null => false
    t.boolean "comment",                         :default => false, :null => false
    t.integer "replycredit",                     :default => 0,     :null => false
    t.integer "position",                                           :null => false
  end

  add_index "pre_forum_post", ["authorid", "invisible"], :name => "authorid"
  add_index "pre_forum_post", ["dateline"], :name => "dateline"
  add_index "pre_forum_post", ["fid"], :name => "fid"
  add_index "pre_forum_post", ["invisible"], :name => "invisible"
  add_index "pre_forum_post", ["pid"], :name => "pid", :unique => true
  add_index "pre_forum_post", ["tid", "first"], :name => "first"
  add_index "pre_forum_post", ["tid", "invisible", "dateline"], :name => "displayorder"

  create_table "pre_forum_post_location", :primary_key => "pid", :force => true do |t|
    t.integer "tid",      :limit => 3, :default => 0
    t.integer "uid",      :limit => 3, :default => 0
    t.string  "mapx",                                 :null => false
    t.string  "mapy",                                 :null => false
    t.string  "location",                             :null => false
  end

  add_index "pre_forum_post_location", ["tid"], :name => "tid"
  add_index "pre_forum_post_location", ["uid"], :name => "uid"

  create_table "pre_forum_post_moderate", :force => true do |t|
    t.integer "status",   :limit => 1, :default => 0, :null => false
    t.integer "dateline",              :default => 0, :null => false
  end

  add_index "pre_forum_post_moderate", ["status", "dateline"], :name => "status"

  create_table "pre_forum_post_tableid", :primary_key => "pid", :force => true do |t|
  end

  create_table "pre_forum_postcache", :primary_key => "pid", :force => true do |t|
    t.text    "comment",                 :null => false
    t.text    "rate",                    :null => false
    t.integer "dateline", :default => 0, :null => false
  end

  add_index "pre_forum_postcache", ["dateline"], :name => "dateline"

  create_table "pre_forum_postcomment", :force => true do |t|
    t.integer "tid",      :limit => 3,  :default => 0,     :null => false
    t.integer "pid",                    :default => 0,     :null => false
    t.string  "author",   :limit => 15, :default => "",    :null => false
    t.integer "authorid", :limit => 3,  :default => 0,     :null => false
    t.integer "dateline",               :default => 0,     :null => false
    t.string  "comment",                :default => "",    :null => false
    t.boolean "score",                  :default => false, :null => false
    t.string  "useip",    :limit => 15, :default => "",    :null => false
    t.integer "rpid",                   :default => 0,     :null => false
  end

  add_index "pre_forum_postcomment", ["authorid"], :name => "authorid"
  add_index "pre_forum_postcomment", ["pid", "dateline"], :name => "pid"
  add_index "pre_forum_postcomment", ["rpid"], :name => "rpid"
  add_index "pre_forum_postcomment", ["score"], :name => "score"
  add_index "pre_forum_postcomment", ["tid"], :name => "tid"

  create_table "pre_forum_postlog", :id => false, :force => true do |t|
    t.integer "pid",                    :default => 0,  :null => false
    t.integer "tid",      :limit => 3,  :default => 0,  :null => false
    t.integer "fid",      :limit => 2,  :default => 0,  :null => false
    t.integer "uid",      :limit => 3,  :default => 0,  :null => false
    t.string  "action",   :limit => 10, :default => "", :null => false
    t.integer "dateline",               :default => 0,  :null => false
  end

  add_index "pre_forum_postlog", ["dateline"], :name => "dateline"
  add_index "pre_forum_postlog", ["fid"], :name => "fid"
  add_index "pre_forum_postlog", ["uid"], :name => "uid"

  create_table "pre_forum_poststick", :id => false, :force => true do |t|
    t.integer "tid",      :limit => 3, :null => false
    t.integer "pid",                   :null => false
    t.integer "position",              :null => false
    t.integer "dateline",              :null => false
  end

  add_index "pre_forum_poststick", ["tid", "dateline"], :name => "dateline"

  create_table "pre_forum_promotion", :primary_key => "ip", :force => true do |t|
    t.integer "uid",      :limit => 3,  :default => 0,  :null => false
    t.string  "username", :limit => 15, :default => "", :null => false
  end

  create_table "pre_forum_ratelog", :id => false, :force => true do |t|
    t.integer "pid",                      :default => 0,     :null => false
    t.integer "uid",        :limit => 3,  :default => 0,     :null => false
    t.string  "username",   :limit => 15, :default => "",    :null => false
    t.boolean "extcredits",               :default => false, :null => false
    t.integer "dateline",                 :default => 0,     :null => false
    t.integer "score",      :limit => 2,  :default => 0,     :null => false
    t.string  "reason",     :limit => 40, :default => "",    :null => false
  end

  add_index "pre_forum_ratelog", ["dateline"], :name => "dateline"
  add_index "pre_forum_ratelog", ["pid", "dateline"], :name => "pid"
  add_index "pre_forum_ratelog", ["uid"], :name => "uid"

  create_table "pre_forum_relatedthread", :id => false, :force => true do |t|
    t.integer "tid",            :limit => 3, :default => 0,         :null => false
    t.string  "type",           :limit => 7, :default => "general", :null => false
    t.integer "expiration",                  :default => 0,         :null => false
    t.string  "keywords",                    :default => "",        :null => false
    t.text    "relatedthreads",                                     :null => false
  end

  create_table "pre_forum_replycredit", :primary_key => "tid", :force => true do |t|
    t.integer "extcredits",     :limit => 3, :default => 0,     :null => false
    t.boolean "extcreditstype",              :default => false, :null => false
    t.integer "times",          :limit => 2, :default => 0,     :null => false
    t.integer "membertimes",    :limit => 2, :default => 0,     :null => false
    t.boolean "random",                      :default => false, :null => false
  end

  create_table "pre_forum_rsscache", :id => false, :force => true do |t|
    t.integer "lastupdate",                :default => 0,  :null => false
    t.integer "fid",         :limit => 3,  :default => 0,  :null => false
    t.integer "tid",         :limit => 3,  :default => 0,  :null => false
    t.integer "dateline",                  :default => 0,  :null => false
    t.string  "forum",       :limit => 50, :default => "", :null => false
    t.string  "author",      :limit => 15, :default => "", :null => false
    t.string  "subject",     :limit => 80, :default => "", :null => false
    t.string  "description",               :default => "", :null => false
    t.string  "guidetype",   :limit => 10, :default => "", :null => false
  end

  add_index "pre_forum_rsscache", ["fid", "dateline"], :name => "fid"
  add_index "pre_forum_rsscache", ["tid"], :name => "tid", :unique => true

  create_table "pre_forum_spacecache", :id => false, :force => true do |t|
    t.integer "uid",        :limit => 3,  :default => 0, :null => false
    t.string  "variable",   :limit => 20,                :null => false
    t.text    "value",                                   :null => false
    t.integer "expiration",               :default => 0, :null => false
  end

  create_table "pre_forum_statlog", :id => false, :force => true do |t|
    t.date    "logdate",                             :null => false
    t.integer "fid",     :limit => 3,                :null => false
    t.integer "type",    :limit => 2, :default => 0, :null => false
    t.integer "value",                :default => 0, :null => false
  end

  create_table "pre_forum_thread", :primary_key => "tid", :force => true do |t|
    t.integer "fid",           :limit => 3,  :default => 0,     :null => false
    t.integer "posttableid",   :limit => 2,  :default => 0,     :null => false
    t.integer "typeid",        :limit => 2,  :default => 0,     :null => false
    t.integer "sortid",        :limit => 2,  :default => 0,     :null => false
    t.integer "readperm",      :limit => 1,  :default => 0,     :null => false
    t.integer "price",         :limit => 2,  :default => 0,     :null => false
    t.string  "author",        :limit => 15, :default => "",    :null => false
    t.integer "authorid",      :limit => 3,  :default => 0,     :null => false
    t.string  "subject",       :limit => 80, :default => "",    :null => false
    t.integer "dateline",                    :default => 0,     :null => false
    t.integer "lastpost",                    :default => 0,     :null => false
    t.string  "lastposter",    :limit => 15, :default => "",    :null => false
    t.integer "views",                       :default => 0,     :null => false
    t.integer "replies",       :limit => 3,  :default => 0,     :null => false
    t.boolean "displayorder",                :default => false, :null => false
    t.boolean "highlight",                   :default => false, :null => false
    t.boolean "digest",                      :default => false, :null => false
    t.boolean "rate",                        :default => false, :null => false
    t.boolean "special",                     :default => false, :null => false
    t.boolean "attachment",                  :default => false, :null => false
    t.boolean "moderated",                   :default => false, :null => false
    t.integer "closed",        :limit => 3,  :default => 0,     :null => false
    t.boolean "stickreply",                  :default => false, :null => false
    t.integer "recommends",    :limit => 2,  :default => 0,     :null => false
    t.integer "recommend_add", :limit => 2,  :default => 0,     :null => false
    t.integer "recommend_sub", :limit => 2,  :default => 0,     :null => false
    t.integer "heats",                       :default => 0,     :null => false
    t.integer "status",        :limit => 2,  :default => 0,     :null => false
    t.boolean "isgroup",                     :default => false, :null => false
    t.integer "favtimes",      :limit => 3,  :default => 0,     :null => false
    t.integer "sharetimes",    :limit => 3,  :default => 0,     :null => false
    t.integer "stamp",         :limit => 1,  :default => -1,    :null => false
    t.integer "icon",          :limit => 1,  :default => -1,    :null => false
    t.integer "pushedaid",     :limit => 3,  :default => 0,     :null => false
    t.integer "cover",         :limit => 2,  :default => 0,     :null => false
    t.integer "replycredit",   :limit => 2,  :default => 0,     :null => false
    t.string  "relatebytag",                 :default => "0",   :null => false
    t.integer "maxposition",                 :default => 0,     :null => false
  end

  add_index "pre_forum_thread", ["authorid"], :name => "authorid"
  add_index "pre_forum_thread", ["digest"], :name => "digest"
  add_index "pre_forum_thread", ["fid", "displayorder", "lastpost"], :name => "displayorder"
  add_index "pre_forum_thread", ["fid", "typeid", "displayorder", "lastpost"], :name => "typeid"
  add_index "pre_forum_thread", ["heats"], :name => "heats"
  add_index "pre_forum_thread", ["isgroup", "lastpost"], :name => "isgroup"
  add_index "pre_forum_thread", ["recommends"], :name => "recommends"
  add_index "pre_forum_thread", ["sortid"], :name => "sortid"
  add_index "pre_forum_thread", ["special"], :name => "special"

  create_table "pre_forum_thread_moderate", :force => true do |t|
    t.integer "status",   :limit => 1, :default => 0, :null => false
    t.integer "dateline",              :default => 0, :null => false
  end

  add_index "pre_forum_thread_moderate", ["status", "dateline"], :name => "status"

  create_table "pre_forum_threadaddviews", :primary_key => "tid", :force => true do |t|
    t.integer "addviews", :default => 0, :null => false
  end

  create_table "pre_forum_threadclass", :primary_key => "typeid", :force => true do |t|
    t.integer "fid",          :limit => 3,                    :null => false
    t.string  "name",                                         :null => false
    t.integer "displayorder", :limit => 3,                    :null => false
    t.string  "icon",                                         :null => false
    t.boolean "moderators",                :default => false, :null => false
  end

  add_index "pre_forum_threadclass", ["fid", "displayorder"], :name => "fid"

  create_table "pre_forum_threadclosed", :primary_key => "tid", :force => true do |t|
    t.integer "redirect", :limit => 3, :default => 0, :null => false
  end

  create_table "pre_forum_threaddisablepos", :primary_key => "tid", :force => true do |t|
  end

  create_table "pre_forum_threadimage", :id => false, :force => true do |t|
    t.integer "tid",        :limit => 3, :default => 0,     :null => false
    t.string  "attachment",              :default => "",    :null => false
    t.boolean "remote",                  :default => false, :null => false
  end

  add_index "pre_forum_threadimage", ["tid"], :name => "tid"

  create_table "pre_forum_threadlog", :id => false, :force => true do |t|
    t.integer "tid",      :limit => 3,  :default => 0, :null => false
    t.integer "fid",      :limit => 2,  :default => 0, :null => false
    t.integer "uid",      :limit => 3,  :default => 0, :null => false
    t.integer "otherid",  :limit => 2,  :default => 0, :null => false
    t.string  "action",   :limit => 10,                :null => false
    t.integer "expiry",                 :default => 0, :null => false
    t.integer "dateline",               :default => 0, :null => false
  end

  add_index "pre_forum_threadlog", ["dateline"], :name => "dateline"

  create_table "pre_forum_threadmod", :id => false, :force => true do |t|
    t.integer "tid",        :limit => 3,  :default => 0,     :null => false
    t.integer "uid",        :limit => 3,  :default => 0,     :null => false
    t.string  "username",   :limit => 15, :default => "",    :null => false
    t.integer "dateline",                 :default => 0,     :null => false
    t.integer "expiration",               :default => 0,     :null => false
    t.string  "action",     :limit => 5,  :default => "",    :null => false
    t.boolean "status",                   :default => false, :null => false
    t.integer "magicid",    :limit => 2,                     :null => false
    t.integer "stamp",      :limit => 1,                     :null => false
    t.string  "reason",     :limit => 40, :default => "",    :null => false
  end

  add_index "pre_forum_threadmod", ["expiration", "status"], :name => "expiration"
  add_index "pre_forum_threadmod", ["tid", "dateline"], :name => "tid"

  create_table "pre_forum_threadpartake", :id => false, :force => true do |t|
    t.integer "tid",      :limit => 3, :default => 0, :null => false
    t.integer "uid",      :limit => 3, :default => 0, :null => false
    t.integer "dateline",              :default => 0, :null => false
  end

  add_index "pre_forum_threadpartake", ["tid", "uid"], :name => "tid"

  create_table "pre_forum_threadpreview", :primary_key => "tid", :force => true do |t|
    t.integer "relay",   :default => 0, :null => false
    t.text    "content",                :null => false
  end

  create_table "pre_forum_threadrush", :primary_key => "tid", :force => true do |t|
    t.integer "stopfloor",     :limit => 3, :default => 0,    :null => false
    t.integer "starttimefrom",              :default => 0,    :null => false
    t.integer "starttimeto",                :default => 0,    :null => false
    t.text    "rewardfloor",                                  :null => false
    t.integer "creditlimit",                :default => -996, :null => false
  end

  create_table "pre_forum_threadtype", :primary_key => "typeid", :force => true do |t|
    t.integer "fid",          :limit => 3, :default => 0,     :null => false
    t.integer "displayorder", :limit => 2, :default => 0,     :null => false
    t.string  "name",                      :default => "",    :null => false
    t.string  "description",               :default => "",    :null => false
    t.string  "icon",                      :default => "",    :null => false
    t.integer "special",      :limit => 2, :default => 0,     :null => false
    t.integer "modelid",      :limit => 2, :default => 0,     :null => false
    t.boolean "expiration",                :default => false, :null => false
    t.text    "template",                                     :null => false
    t.text    "stemplate",                                    :null => false
    t.text    "ptemplate",                                    :null => false
    t.text    "btemplate",                                    :null => false
  end

  create_table "pre_forum_trade", :id => false, :force => true do |t|
    t.integer "tid",            :limit => 3,                                                    :null => false
    t.integer "pid",                                                                            :null => false
    t.integer "typeid",         :limit => 2,                                                    :null => false
    t.integer "sellerid",       :limit => 3,                                                    :null => false
    t.string  "seller",         :limit => 15,                                                   :null => false
    t.string  "account",        :limit => 50,                                                   :null => false
    t.string  "tenpayaccount",  :limit => 20,                                :default => "",    :null => false
    t.string  "subject",        :limit => 100,                                                  :null => false
    t.decimal "price",                         :precision => 8, :scale => 2,                    :null => false
    t.integer "amount",         :limit => 2,                                 :default => 1,     :null => false
    t.boolean "quality",                                                     :default => false, :null => false
    t.string  "locus",          :limit => 20,                                                   :null => false
    t.boolean "transport",                                                   :default => false, :null => false
    t.integer "ordinaryfee",    :limit => 2,                                 :default => 0,     :null => false
    t.integer "expressfee",     :limit => 2,                                 :default => 0,     :null => false
    t.integer "emsfee",         :limit => 2,                                 :default => 0,     :null => false
    t.boolean "itemtype",                                                    :default => false, :null => false
    t.integer "dateline",                                                    :default => 0,     :null => false
    t.integer "expiration",                                                  :default => 0,     :null => false
    t.string  "lastbuyer",      :limit => 15,                                                   :null => false
    t.integer "lastupdate",                                                  :default => 0,     :null => false
    t.integer "totalitems",     :limit => 2,                                 :default => 0,     :null => false
    t.decimal "tradesum",                      :precision => 8, :scale => 2, :default => 0.0,   :null => false
    t.boolean "closed",                                                      :default => false, :null => false
    t.integer "aid",            :limit => 3,                                                    :null => false
    t.boolean "displayorder",                                                                   :null => false
    t.decimal "costprice",                     :precision => 8, :scale => 2,                    :null => false
    t.integer "credit",                                                      :default => 0,     :null => false
    t.integer "costcredit",                                                  :default => 0,     :null => false
    t.integer "credittradesum",                                              :default => 0,     :null => false
  end

  add_index "pre_forum_trade", ["credittradesum"], :name => "credittradesum"
  add_index "pre_forum_trade", ["expiration"], :name => "expiration"
  add_index "pre_forum_trade", ["pid"], :name => "pid"
  add_index "pre_forum_trade", ["sellerid", "tradesum", "totalitems"], :name => "sellertrades"
  add_index "pre_forum_trade", ["sellerid"], :name => "sellerid"
  add_index "pre_forum_trade", ["tid", "displayorder"], :name => "displayorder"
  add_index "pre_forum_trade", ["totalitems"], :name => "totalitems"
  add_index "pre_forum_trade", ["tradesum"], :name => "tradesum"
  add_index "pre_forum_trade", ["typeid"], :name => "typeid"

  create_table "pre_forum_tradecomment", :force => true do |t|
    t.string  "orderid",     :limit => 32,  :null => false
    t.integer "pid",                        :null => false
    t.boolean "type",                       :null => false
    t.integer "raterid",     :limit => 3,   :null => false
    t.string  "rater",       :limit => 15,  :null => false
    t.integer "rateeid",     :limit => 3,   :null => false
    t.string  "ratee",       :limit => 15,  :null => false
    t.string  "message",     :limit => 200, :null => false
    t.string  "explanation", :limit => 200, :null => false
    t.boolean "score",                      :null => false
    t.integer "dateline",                   :null => false
  end

  add_index "pre_forum_tradecomment", ["orderid"], :name => "orderid"
  add_index "pre_forum_tradecomment", ["rateeid", "type", "dateline"], :name => "rateeid"
  add_index "pre_forum_tradecomment", ["raterid", "type", "dateline"], :name => "raterid"

  create_table "pre_forum_tradelog", :id => false, :force => true do |t|
    t.integer "tid",           :limit => 3,                                                    :null => false
    t.integer "pid",                                                                           :null => false
    t.string  "orderid",       :limit => 32,                                                   :null => false
    t.string  "tradeno",       :limit => 32,                                                   :null => false
    t.boolean "paytype",                                                    :default => false, :null => false
    t.string  "subject",       :limit => 100,                                                  :null => false
    t.decimal "price",                        :precision => 8, :scale => 2, :default => 0.0,   :null => false
    t.boolean "quality",                                                    :default => false, :null => false
    t.boolean "itemtype",                                                   :default => false, :null => false
    t.integer "number",        :limit => 2,                                 :default => 0,     :null => false
    t.decimal "tax",                          :precision => 6, :scale => 2, :default => 0.0,   :null => false
    t.string  "locus",         :limit => 100,                                                  :null => false
    t.integer "sellerid",      :limit => 3,                                                    :null => false
    t.string  "seller",        :limit => 15,                                                   :null => false
    t.string  "selleraccount", :limit => 50,                                                   :null => false
    t.string  "tenpayaccount", :limit => 20,                                :default => "0",   :null => false
    t.integer "buyerid",       :limit => 3,                                                    :null => false
    t.string  "buyer",         :limit => 15,                                                   :null => false
    t.string  "buyercontact",  :limit => 50,                                                   :null => false
    t.integer "buyercredits",  :limit => 2,                                 :default => 0,     :null => false
    t.string  "buyermsg",      :limit => 200
    t.boolean "status",                                                     :default => false, :null => false
    t.integer "lastupdate",                                                 :default => 0,     :null => false
    t.boolean "offline",                                                    :default => false, :null => false
    t.string  "buyername",     :limit => 50,                                                   :null => false
    t.string  "buyerzip",      :limit => 10,                                                   :null => false
    t.string  "buyerphone",    :limit => 20,                                                   :null => false
    t.string  "buyermobile",   :limit => 20,                                                   :null => false
    t.boolean "transport",                                                  :default => false, :null => false
    t.integer "transportfee",  :limit => 2,                                 :default => 0,     :null => false
    t.decimal "baseprice",                    :precision => 8, :scale => 2,                    :null => false
    t.boolean "discount",                                                   :default => false, :null => false
    t.boolean "ratestatus",                                                 :default => false, :null => false
    t.text    "message",                                                                       :null => false
    t.integer "credit",                                                     :default => 0,     :null => false
    t.integer "basecredit",                                                 :default => 0,     :null => false
  end

  add_index "pre_forum_tradelog", ["buyerid", "status", "lastupdate"], :name => "buyerlog"
  add_index "pre_forum_tradelog", ["buyerid"], :name => "buyerid"
  add_index "pre_forum_tradelog", ["orderid"], :name => "orderid", :unique => true
  add_index "pre_forum_tradelog", ["pid"], :name => "pid"
  add_index "pre_forum_tradelog", ["sellerid", "status", "lastupdate"], :name => "sellerlog"
  add_index "pre_forum_tradelog", ["sellerid"], :name => "sellerid"
  add_index "pre_forum_tradelog", ["status"], :name => "status"
  add_index "pre_forum_tradelog", ["tid", "pid"], :name => "tid"

  create_table "pre_forum_typeoption", :primary_key => "optionid", :force => true do |t|
    t.integer "classid",      :limit => 2,        :default => 0,  :null => false
    t.integer "displayorder", :limit => 1,        :default => 0,  :null => false
    t.boolean "expiration",                                       :null => false
    t.string  "protect",                                          :null => false
    t.string  "title",                            :default => "", :null => false
    t.string  "description",                      :default => "", :null => false
    t.string  "identifier",                       :default => "", :null => false
    t.string  "type",                             :default => "", :null => false
    t.string  "unit",                                             :null => false
    t.text    "rules",        :limit => 16777215,                 :null => false
    t.text    "permprompt",   :limit => 16777215,                 :null => false
  end

  add_index "pre_forum_typeoption", ["classid"], :name => "classid"

  create_table "pre_forum_typeoptionvar", :id => false, :force => true do |t|
    t.integer "sortid",     :limit => 2,        :default => 0, :null => false
    t.integer "tid",        :limit => 3,        :default => 0, :null => false
    t.integer "fid",        :limit => 3,        :default => 0, :null => false
    t.integer "optionid",   :limit => 2,        :default => 0, :null => false
    t.integer "expiration",                     :default => 0, :null => false
    t.text    "value",      :limit => 16777215,                :null => false
  end

  add_index "pre_forum_typeoptionvar", ["fid"], :name => "fid"
  add_index "pre_forum_typeoptionvar", ["sortid"], :name => "sortid"
  add_index "pre_forum_typeoptionvar", ["tid"], :name => "tid"

  create_table "pre_forum_typevar", :id => false, :force => true do |t|
    t.integer "sortid",       :limit => 2, :default => 0,     :null => false
    t.integer "optionid",     :limit => 2, :default => 0,     :null => false
    t.boolean "available",                 :default => false, :null => false
    t.boolean "required",                  :default => false, :null => false
    t.boolean "unchangeable",              :default => false, :null => false
    t.boolean "search",                    :default => false, :null => false
    t.integer "displayorder", :limit => 1, :default => 0,     :null => false
    t.boolean "subjectshow",               :default => false, :null => false
  end

  add_index "pre_forum_typevar", ["sortid", "optionid"], :name => "optionid", :unique => true
  add_index "pre_forum_typevar", ["sortid"], :name => "sortid"

  create_table "pre_forum_warning", :primary_key => "wid", :force => true do |t|
    t.integer "pid",                      :null => false
    t.integer "operatorid", :limit => 3,  :null => false
    t.string  "operator",   :limit => 15, :null => false
    t.integer "authorid",   :limit => 3,  :null => false
    t.string  "author",     :limit => 15, :null => false
    t.integer "dateline",                 :null => false
    t.string  "reason",     :limit => 40, :null => false
  end

  add_index "pre_forum_warning", ["authorid"], :name => "authorid"
  add_index "pre_forum_warning", ["pid"], :name => "pid", :unique => true

  create_table "pre_home_album", :primary_key => "albumid", :force => true do |t|
    t.string  "albumname",  :limit => 50, :default => "",    :null => false
    t.integer "catid",      :limit => 2,  :default => 0,     :null => false
    t.integer "uid",        :limit => 3,  :default => 0,     :null => false
    t.string  "username",   :limit => 15, :default => "",    :null => false
    t.integer "dateline",                 :default => 0,     :null => false
    t.integer "updatetime",               :default => 0,     :null => false
    t.integer "picnum",     :limit => 2,  :default => 0,     :null => false
    t.string  "pic",        :limit => 60, :default => "",    :null => false
    t.boolean "picflag",                  :default => false, :null => false
    t.boolean "friend",                   :default => false, :null => false
    t.string  "password",   :limit => 10, :default => "",    :null => false
    t.text    "target_ids",                                  :null => false
    t.integer "favtimes",   :limit => 3,                     :null => false
    t.integer "sharetimes", :limit => 3,                     :null => false
    t.text    "depict",                                      :null => false
  end

  add_index "pre_home_album", ["uid", "updatetime"], :name => "uid"
  add_index "pre_home_album", ["updatetime"], :name => "updatetime"

  create_table "pre_home_album_category", :primary_key => "catid", :force => true do |t|
    t.integer "upid",         :limit => 3, :default => 0,  :null => false
    t.string  "catname",                   :default => "", :null => false
    t.integer "num",          :limit => 3, :default => 0,  :null => false
    t.integer "displayorder", :limit => 2, :default => 0,  :null => false
  end

  create_table "pre_home_appcreditlog", :primary_key => "logid", :force => true do |t|
    t.integer "uid",      :limit => 3,  :default => 0,     :null => false
    t.integer "appid",    :limit => 3,  :default => 0,     :null => false
    t.string  "appname",  :limit => 60, :default => "",    :null => false
    t.boolean "type",                   :default => false, :null => false
    t.integer "credit",   :limit => 3,  :default => 0,     :null => false
    t.text    "note",                                      :null => false
    t.integer "dateline",               :default => 0,     :null => false
  end

  add_index "pre_home_appcreditlog", ["appid"], :name => "appid"
  add_index "pre_home_appcreditlog", ["uid", "dateline"], :name => "uid"

  create_table "pre_home_blacklist", :id => false, :force => true do |t|
    t.integer "uid",      :limit => 3, :default => 0, :null => false
    t.integer "buid",     :limit => 3, :default => 0, :null => false
    t.integer "dateline",              :default => 0, :null => false
  end

  add_index "pre_home_blacklist", ["uid", "dateline"], :name => "uid"

  create_table "pre_home_blog", :primary_key => "blogid", :force => true do |t|
    t.integer "uid",        :limit => 3,  :default => 0,     :null => false
    t.string  "username",   :limit => 15, :default => "",    :null => false
    t.string  "subject",    :limit => 80, :default => "",    :null => false
    t.integer "classid",    :limit => 2,  :default => 0,     :null => false
    t.integer "catid",      :limit => 2,  :default => 0,     :null => false
    t.integer "viewnum",    :limit => 3,  :default => 0,     :null => false
    t.integer "replynum",   :limit => 3,  :default => 0,     :null => false
    t.integer "hot",        :limit => 3,  :default => 0,     :null => false
    t.integer "dateline",                 :default => 0,     :null => false
    t.boolean "picflag",                  :default => false, :null => false
    t.boolean "noreply",                  :default => false, :null => false
    t.boolean "friend",                   :default => false, :null => false
    t.string  "password",   :limit => 10, :default => "",    :null => false
    t.integer "favtimes",   :limit => 3,  :default => 0,     :null => false
    t.integer "sharetimes", :limit => 3,  :default => 0,     :null => false
    t.boolean "status",                   :default => false, :null => false
    t.integer "click1",     :limit => 2,  :default => 0,     :null => false
    t.integer "click2",     :limit => 2,  :default => 0,     :null => false
    t.integer "click3",     :limit => 2,  :default => 0,     :null => false
    t.integer "click4",     :limit => 2,  :default => 0,     :null => false
    t.integer "click5",     :limit => 2,  :default => 0,     :null => false
    t.integer "click6",     :limit => 2,  :default => 0,     :null => false
    t.integer "click7",     :limit => 2,  :default => 0,     :null => false
    t.integer "click8",     :limit => 2,  :default => 0,     :null => false
  end

  add_index "pre_home_blog", ["dateline"], :name => "dateline"
  add_index "pre_home_blog", ["hot"], :name => "hot"
  add_index "pre_home_blog", ["uid", "dateline"], :name => "uid"

  create_table "pre_home_blog_category", :primary_key => "catid", :force => true do |t|
    t.integer "upid",         :limit => 3, :default => 0,  :null => false
    t.string  "catname",                   :default => "", :null => false
    t.integer "num",          :limit => 3, :default => 0,  :null => false
    t.integer "displayorder", :limit => 2, :default => 0,  :null => false
  end

  create_table "pre_home_blog_moderate", :force => true do |t|
    t.integer "status",   :limit => 1, :default => 0, :null => false
    t.integer "dateline",              :default => 0, :null => false
  end

  add_index "pre_home_blog_moderate", ["status", "dateline"], :name => "status"

  create_table "pre_home_blogfield", :primary_key => "blogid", :force => true do |t|
    t.integer "uid",         :limit => 3,        :default => 0,  :null => false
    t.string  "pic",                             :default => "", :null => false
    t.string  "tag",                             :default => "", :null => false
    t.text    "message",     :limit => 16777215,                 :null => false
    t.string  "postip",                          :default => "", :null => false
    t.text    "related",                                         :null => false
    t.integer "relatedtime",                     :default => 0,  :null => false
    t.text    "target_ids",                                      :null => false
    t.text    "hotuser",                                         :null => false
    t.integer "magiccolor",  :limit => 1,        :default => 0,  :null => false
    t.integer "magicpaper",  :limit => 1,        :default => 0,  :null => false
    t.integer "pushedaid",   :limit => 3,        :default => 0,  :null => false
  end

  add_index "pre_home_blogfield", ["uid"], :name => "uid"

  create_table "pre_home_class", :primary_key => "classid", :force => true do |t|
    t.string  "classname", :limit => 40, :default => "", :null => false
    t.integer "uid",       :limit => 3,  :default => 0,  :null => false
    t.integer "dateline",                :default => 0,  :null => false
  end

  add_index "pre_home_class", ["uid"], :name => "uid"

  create_table "pre_home_click", :primary_key => "clickid", :force => true do |t|
    t.string  "name",         :limit => 50,  :default => "",    :null => false
    t.string  "icon",         :limit => 100, :default => "",    :null => false
    t.string  "idtype",       :limit => 15,  :default => "",    :null => false
    t.boolean "available",                   :default => false, :null => false
    t.integer "displayorder", :limit => 1,   :default => 0,     :null => false
  end

  add_index "pre_home_click", ["idtype", "displayorder"], :name => "idtype"

  create_table "pre_home_clickuser", :id => false, :force => true do |t|
    t.integer "uid",      :limit => 3,  :default => 0,  :null => false
    t.string  "username", :limit => 15, :default => "", :null => false
    t.integer "id",       :limit => 3,  :default => 0,  :null => false
    t.string  "idtype",   :limit => 15, :default => "", :null => false
    t.integer "clickid",  :limit => 2,  :default => 0,  :null => false
    t.integer "dateline",               :default => 0,  :null => false
  end

  add_index "pre_home_clickuser", ["id", "idtype", "dateline"], :name => "id"
  add_index "pre_home_clickuser", ["uid", "idtype", "dateline"], :name => "uid"

  create_table "pre_home_comment", :primary_key => "cid", :force => true do |t|
    t.integer "uid",          :limit => 3,  :default => 0,     :null => false
    t.integer "id",           :limit => 3,  :default => 0,     :null => false
    t.string  "idtype",       :limit => 20, :default => "",    :null => false
    t.integer "authorid",     :limit => 3,  :default => 0,     :null => false
    t.string  "author",       :limit => 15, :default => "",    :null => false
    t.string  "ip",           :limit => 20, :default => "",    :null => false
    t.integer "dateline",                   :default => 0,     :null => false
    t.text    "message",                                       :null => false
    t.boolean "magicflicker",               :default => false, :null => false
    t.boolean "status",                     :default => false, :null => false
  end

  add_index "pre_home_comment", ["authorid", "idtype"], :name => "authorid"
  add_index "pre_home_comment", ["id", "idtype", "dateline"], :name => "id"

  create_table "pre_home_comment_moderate", :force => true do |t|
    t.string  "idtype",   :limit => 15, :default => "", :null => false
    t.integer "status",   :limit => 1,  :default => 0,  :null => false
    t.integer "dateline",               :default => 0,  :null => false
  end

  add_index "pre_home_comment_moderate", ["idtype", "status", "dateline"], :name => "idtype"

  create_table "pre_home_docomment", :force => true do |t|
    t.integer "upid",                   :default => 0,  :null => false
    t.integer "doid",     :limit => 3,  :default => 0,  :null => false
    t.integer "uid",      :limit => 3,  :default => 0,  :null => false
    t.string  "username", :limit => 15, :default => "", :null => false
    t.integer "dateline",               :default => 0,  :null => false
    t.text    "message",                                :null => false
    t.string  "ip",       :limit => 20, :default => "", :null => false
    t.integer "grade",    :limit => 2,  :default => 0,  :null => false
  end

  add_index "pre_home_docomment", ["dateline"], :name => "dateline"
  add_index "pre_home_docomment", ["doid", "dateline"], :name => "doid"

  create_table "pre_home_doing", :primary_key => "doid", :force => true do |t|
    t.integer "uid",      :limit => 3,  :default => 0,     :null => false
    t.string  "username", :limit => 15, :default => "",    :null => false
    t.string  "from",     :limit => 20, :default => "",    :null => false
    t.integer "dateline",               :default => 0,     :null => false
    t.text    "message",                                   :null => false
    t.string  "ip",       :limit => 20, :default => "",    :null => false
    t.integer "replynum",               :default => 0,     :null => false
    t.boolean "status",                 :default => false, :null => false
  end

  add_index "pre_home_doing", ["dateline"], :name => "dateline"
  add_index "pre_home_doing", ["uid", "dateline"], :name => "uid"

  create_table "pre_home_doing_moderate", :force => true do |t|
    t.integer "status",   :limit => 1, :default => 0, :null => false
    t.integer "dateline",              :default => 0, :null => false
  end

  add_index "pre_home_doing_moderate", ["status", "dateline"], :name => "status"

  create_table "pre_home_favorite", :primary_key => "favid", :force => true do |t|
    t.integer "uid",         :limit => 3, :default => 0,  :null => false
    t.integer "id",          :limit => 3, :default => 0,  :null => false
    t.string  "idtype",                   :default => "", :null => false
    t.integer "spaceuid",    :limit => 3, :default => 0,  :null => false
    t.string  "title",                    :default => "", :null => false
    t.text    "description",                              :null => false
    t.integer "dateline",                 :default => 0,  :null => false
  end

  add_index "pre_home_favorite", ["id", "idtype"], :name => "idtype"
  add_index "pre_home_favorite", ["uid", "idtype", "dateline"], :name => "uid"

  create_table "pre_home_feed", :primary_key => "feedid", :force => true do |t|
    t.integer "appid",          :limit => 2,  :default => 0,     :null => false
    t.string  "icon",           :limit => 30, :default => "",    :null => false
    t.integer "uid",            :limit => 3,  :default => 0,     :null => false
    t.string  "username",       :limit => 15, :default => "",    :null => false
    t.integer "dateline",                     :default => 0,     :null => false
    t.boolean "friend",                       :default => false, :null => false
    t.string  "hash_template",  :limit => 32, :default => "",    :null => false
    t.string  "hash_data",      :limit => 32, :default => "",    :null => false
    t.text    "title_template",                                  :null => false
    t.text    "title_data",                                      :null => false
    t.text    "body_template",                                   :null => false
    t.text    "body_data",                                       :null => false
    t.text    "body_general",                                    :null => false
    t.string  "image_1",                      :default => "",    :null => false
    t.string  "image_1_link",                 :default => "",    :null => false
    t.string  "image_2",                      :default => "",    :null => false
    t.string  "image_2_link",                 :default => "",    :null => false
    t.string  "image_3",                      :default => "",    :null => false
    t.string  "image_3_link",                 :default => "",    :null => false
    t.string  "image_4",                      :default => "",    :null => false
    t.string  "image_4_link",                 :default => "",    :null => false
    t.text    "target_ids",                                      :null => false
    t.integer "id",             :limit => 3,  :default => 0,     :null => false
    t.string  "idtype",         :limit => 15, :default => "",    :null => false
    t.integer "hot",            :limit => 3,  :default => 0,     :null => false
  end

  add_index "pre_home_feed", ["dateline"], :name => "dateline"
  add_index "pre_home_feed", ["hot"], :name => "hot"
  add_index "pre_home_feed", ["id", "idtype"], :name => "id"
  add_index "pre_home_feed", ["uid", "dateline"], :name => "uid"

  create_table "pre_home_feed_app", :primary_key => "feedid", :force => true do |t|
    t.integer "appid",          :limit => 2,  :default => 0,     :null => false
    t.string  "icon",           :limit => 30, :default => "",    :null => false
    t.integer "uid",            :limit => 3,  :default => 0,     :null => false
    t.string  "username",       :limit => 15, :default => "",    :null => false
    t.integer "dateline",                     :default => 0,     :null => false
    t.boolean "friend",                       :default => false, :null => false
    t.string  "hash_template",  :limit => 32, :default => "",    :null => false
    t.string  "hash_data",      :limit => 32, :default => "",    :null => false
    t.text    "title_template",                                  :null => false
    t.text    "title_data",                                      :null => false
    t.text    "body_template",                                   :null => false
    t.text    "body_data",                                       :null => false
    t.text    "body_general",                                    :null => false
    t.string  "image_1",                      :default => "",    :null => false
    t.string  "image_1_link",                 :default => "",    :null => false
    t.string  "image_2",                      :default => "",    :null => false
    t.string  "image_2_link",                 :default => "",    :null => false
    t.string  "image_3",                      :default => "",    :null => false
    t.string  "image_3_link",                 :default => "",    :null => false
    t.string  "image_4",                      :default => "",    :null => false
    t.string  "image_4_link",                 :default => "",    :null => false
    t.text    "target_ids",                                      :null => false
  end

  add_index "pre_home_feed_app", ["dateline"], :name => "dateline"
  add_index "pre_home_feed_app", ["uid", "dateline"], :name => "uid"

  create_table "pre_home_follow", :id => false, :force => true do |t|
    t.integer "uid",       :limit => 3,  :default => 0,     :null => false
    t.string  "username",  :limit => 15, :default => "",    :null => false
    t.integer "followuid", :limit => 3,  :default => 0,     :null => false
    t.string  "fusername", :limit => 15, :default => "",    :null => false
    t.string  "bkname",                  :default => "",    :null => false
    t.boolean "status",                  :default => false, :null => false
    t.boolean "mutual",                  :default => false, :null => false
    t.integer "dateline",                :default => 0,     :null => false
  end

  create_table "pre_home_follow_feed", :primary_key => "feedid", :force => true do |t|
    t.integer "uid",      :limit => 3,  :default => 0,  :null => false
    t.string  "username", :limit => 15, :default => "", :null => false
    t.integer "tid",      :limit => 3,  :default => 0,  :null => false
    t.text    "note",                                   :null => false
    t.integer "dateline",               :default => 0,  :null => false
  end

  add_index "pre_home_follow_feed", ["uid", "dateline"], :name => "uid"

  create_table "pre_home_follow_feed_archiver", :primary_key => "feedid", :force => true do |t|
    t.integer "uid",      :limit => 3,  :default => 0,  :null => false
    t.string  "username", :limit => 15, :default => "", :null => false
    t.integer "tid",      :limit => 3,  :default => 0,  :null => false
    t.text    "note",                                   :null => false
    t.integer "dateline",               :default => 0,  :null => false
  end

  add_index "pre_home_follow_feed_archiver", ["uid", "dateline"], :name => "uid"

  create_table "pre_home_friend", :id => false, :force => true do |t|
    t.integer "uid",       :limit => 3,  :default => 0,  :null => false
    t.integer "fuid",      :limit => 3,  :default => 0,  :null => false
    t.string  "fusername", :limit => 15, :default => "", :null => false
    t.integer "gid",       :limit => 2,  :default => 0,  :null => false
    t.integer "num",       :limit => 3,  :default => 0,  :null => false
    t.integer "dateline",                :default => 0,  :null => false
    t.string  "note",                    :default => "", :null => false
  end

  add_index "pre_home_friend", ["fuid"], :name => "fuid"
  add_index "pre_home_friend", ["uid", "num", "dateline"], :name => "uid"

  create_table "pre_home_friend_request", :id => false, :force => true do |t|
    t.integer "uid",       :limit => 3,  :default => 0,  :null => false
    t.integer "fuid",      :limit => 3,  :default => 0,  :null => false
    t.string  "fusername", :limit => 15, :default => "", :null => false
    t.integer "gid",       :limit => 2,  :default => 0,  :null => false
    t.string  "note",      :limit => 60, :default => "", :null => false
    t.integer "dateline",                :default => 0,  :null => false
  end

  add_index "pre_home_friend_request", ["fuid"], :name => "fuid"
  add_index "pre_home_friend_request", ["uid", "dateline"], :name => "dateline"

  create_table "pre_home_friendlog", :id => false, :force => true do |t|
    t.integer "uid",      :limit => 3,  :default => 0,  :null => false
    t.integer "fuid",     :limit => 3,  :default => 0,  :null => false
    t.string  "action",   :limit => 10, :default => "", :null => false
    t.integer "dateline",               :default => 0,  :null => false
  end

  create_table "pre_home_notification", :force => true do |t|
    t.integer "uid",         :limit => 3,  :default => 0,     :null => false
    t.string  "type",        :limit => 20, :default => "",    :null => false
    t.boolean "new",                       :default => false, :null => false
    t.integer "authorid",    :limit => 3,  :default => 0,     :null => false
    t.string  "author",      :limit => 15, :default => "",    :null => false
    t.text    "note",                                         :null => false
    t.integer "dateline",                  :default => 0,     :null => false
    t.integer "from_id",     :limit => 3,  :default => 0,     :null => false
    t.string  "from_idtype", :limit => 20, :default => "",    :null => false
    t.integer "from_num",    :limit => 3,  :default => 0,     :null => false
  end

  add_index "pre_home_notification", ["from_id", "from_idtype"], :name => "from_id"
  add_index "pre_home_notification", ["uid", "new", "dateline"], :name => "uid"

  create_table "pre_home_pic", :primary_key => "picid", :force => true do |t|
    t.integer "albumid",    :limit => 3,  :default => 0,     :null => false
    t.integer "uid",        :limit => 3,  :default => 0,     :null => false
    t.string  "username",   :limit => 15, :default => "",    :null => false
    t.integer "dateline",                 :default => 0,     :null => false
    t.string  "postip",                   :default => "",    :null => false
    t.string  "filename",                 :default => "",    :null => false
    t.string  "title",                    :default => "",    :null => false
    t.string  "type",                     :default => "",    :null => false
    t.integer "size",                     :default => 0,     :null => false
    t.string  "filepath",                 :default => "",    :null => false
    t.boolean "thumb",                    :default => false, :null => false
    t.boolean "remote",                   :default => false, :null => false
    t.integer "hot",        :limit => 3,  :default => 0,     :null => false
    t.integer "sharetimes", :limit => 3,  :default => 0,     :null => false
    t.integer "click1",     :limit => 2,  :default => 0,     :null => false
    t.integer "click2",     :limit => 2,  :default => 0,     :null => false
    t.integer "click3",     :limit => 2,  :default => 0,     :null => false
    t.integer "click4",     :limit => 2,  :default => 0,     :null => false
    t.integer "click5",     :limit => 2,  :default => 0,     :null => false
    t.integer "click6",     :limit => 2,  :default => 0,     :null => false
    t.integer "click7",     :limit => 2,  :default => 0,     :null => false
    t.integer "click8",     :limit => 2,  :default => 0,     :null => false
    t.integer "magicframe", :limit => 1,  :default => 0,     :null => false
    t.boolean "status",                   :default => false, :null => false
  end

  add_index "pre_home_pic", ["albumid", "dateline"], :name => "albumid"
  add_index "pre_home_pic", ["uid"], :name => "uid"

  create_table "pre_home_pic_moderate", :force => true do |t|
    t.integer "status",   :limit => 1, :default => 0, :null => false
    t.integer "dateline",              :default => 0, :null => false
  end

  add_index "pre_home_pic_moderate", ["status", "dateline"], :name => "status"

  create_table "pre_home_picfield", :primary_key => "picid", :force => true do |t|
    t.text "hotuser", :null => false
  end

  create_table "pre_home_poke", :id => false, :force => true do |t|
    t.integer "uid",          :limit => 3,  :default => 0,  :null => false
    t.integer "fromuid",      :limit => 3,  :default => 0,  :null => false
    t.string  "fromusername", :limit => 15, :default => "", :null => false
    t.string  "note",                       :default => "", :null => false
    t.integer "dateline",                   :default => 0,  :null => false
    t.integer "iconid",       :limit => 2,  :default => 0,  :null => false
  end

  add_index "pre_home_poke", ["uid", "dateline"], :name => "uid"

  create_table "pre_home_pokearchive", :primary_key => "pid", :force => true do |t|
    t.integer "pokeuid",               :default => 0,  :null => false
    t.integer "uid",      :limit => 3, :default => 0,  :null => false
    t.integer "fromuid",  :limit => 3, :default => 0,  :null => false
    t.string  "note",                  :default => "", :null => false
    t.integer "dateline",              :default => 0,  :null => false
    t.integer "iconid",   :limit => 2, :default => 0,  :null => false
  end

  add_index "pre_home_pokearchive", ["pokeuid"], :name => "pokeuid"

  create_table "pre_home_share", :primary_key => "sid", :force => true do |t|
    t.integer "itemid",         :limit => 3,                  :null => false
    t.string  "type",           :limit => 30, :default => "", :null => false
    t.integer "uid",            :limit => 3,  :default => 0,  :null => false
    t.string  "username",       :limit => 15, :default => "", :null => false
    t.integer "fromuid",        :limit => 3,  :default => 0,  :null => false
    t.integer "dateline",                     :default => 0,  :null => false
    t.text    "title_template",                               :null => false
    t.text    "body_template",                                :null => false
    t.text    "body_data",                                    :null => false
    t.text    "body_general",                                 :null => false
    t.string  "image",                        :default => "", :null => false
    t.string  "image_link",                   :default => "", :null => false
    t.integer "hot",            :limit => 3,  :default => 0,  :null => false
    t.text    "hotuser",                                      :null => false
    t.boolean "status",                                       :null => false
  end

  add_index "pre_home_share", ["dateline"], :name => "dateline"
  add_index "pre_home_share", ["hot"], :name => "hot"
  add_index "pre_home_share", ["uid", "dateline"], :name => "uid"

  create_table "pre_home_share_moderate", :force => true do |t|
    t.integer "status",   :limit => 1, :default => 0, :null => false
    t.integer "dateline",              :default => 0, :null => false
  end

  add_index "pre_home_share_moderate", ["status", "dateline"], :name => "status"

  create_table "pre_home_show", :primary_key => "uid", :force => true do |t|
    t.string  "username",  :limit => 15,  :default => "", :null => false
    t.integer "unitprice",                :default => 1,  :null => false
    t.integer "credit",                   :default => 0,  :null => false
    t.string  "note",      :limit => 100, :default => "", :null => false
  end

  add_index "pre_home_show", ["credit"], :name => "credit"
  add_index "pre_home_show", ["unitprice"], :name => "unitprice"

  create_table "pre_home_specialuser", :id => false, :force => true do |t|
    t.integer "uid",          :limit => 3,  :default => 0,     :null => false
    t.string  "username",     :limit => 15, :default => "",    :null => false
    t.boolean "status",                     :default => false, :null => false
    t.integer "dateline",                   :default => 0,     :null => false
    t.text    "reason",                                        :null => false
    t.integer "opuid",        :limit => 3,  :default => 0,     :null => false
    t.string  "opusername",   :limit => 15, :default => "",    :null => false
    t.integer "displayorder", :limit => 3,  :default => 0,     :null => false
  end

  add_index "pre_home_specialuser", ["status", "displayorder"], :name => "displayorder"
  add_index "pre_home_specialuser", ["uid", "status"], :name => "uid"

  create_table "pre_home_userapp", :id => false, :force => true do |t|
    t.integer "uid",              :limit => 3,  :default => 0,     :null => false
    t.integer "appid",            :limit => 3,  :default => 0,     :null => false
    t.string  "appname",          :limit => 60, :default => "",    :null => false
    t.boolean "privacy",                        :default => false, :null => false
    t.boolean "allowsidenav",                   :default => false, :null => false
    t.boolean "allowfeed",                      :default => false, :null => false
    t.boolean "allowprofilelink",               :default => false, :null => false
    t.boolean "narrow",                         :default => false, :null => false
    t.integer "menuorder",        :limit => 2,  :default => 0,     :null => false
    t.integer "displayorder",     :limit => 2,  :default => 0,     :null => false
  end

  add_index "pre_home_userapp", ["uid", "appid"], :name => "uid"
  add_index "pre_home_userapp", ["uid", "displayorder"], :name => "displayorder"
  add_index "pre_home_userapp", ["uid", "menuorder"], :name => "menuorder"

  create_table "pre_home_userappfield", :id => false, :force => true do |t|
    t.integer "uid",         :limit => 3, :default => 0, :null => false
    t.integer "appid",       :limit => 3, :default => 0, :null => false
    t.text    "profilelink",                             :null => false
    t.text    "myml",                                    :null => false
  end

  add_index "pre_home_userappfield", ["uid", "appid"], :name => "uid"

  create_table "pre_home_visitor", :id => false, :force => true do |t|
    t.integer "uid",       :limit => 3,  :default => 0,  :null => false
    t.integer "vuid",      :limit => 3,  :default => 0,  :null => false
    t.string  "vusername", :limit => 15, :default => "", :null => false
    t.integer "dateline",                :default => 0,  :null => false
  end

  add_index "pre_home_visitor", ["dateline"], :name => "dateline"
  add_index "pre_home_visitor", ["vuid"], :name => "vuid"

  create_table "pre_portal_article_content", :primary_key => "cid", :force => true do |t|
    t.integer "aid",       :limit => 3, :default => 0,  :null => false
    t.integer "id",                     :default => 0,  :null => false
    t.string  "idtype",                 :default => "", :null => false
    t.string  "title",                  :default => "", :null => false
    t.text    "content",                                :null => false
    t.integer "pageorder", :limit => 2, :default => 0,  :null => false
    t.integer "dateline",               :default => 0,  :null => false
  end

  add_index "pre_portal_article_content", ["aid", "pageorder"], :name => "aid"
  add_index "pre_portal_article_content", ["pageorder"], :name => "pageorder"

  create_table "pre_portal_article_count", :primary_key => "aid", :force => true do |t|
    t.integer "catid",      :limit => 3, :default => 0, :null => false
    t.integer "viewnum",    :limit => 3, :default => 0, :null => false
    t.integer "commentnum", :limit => 3, :default => 0, :null => false
    t.integer "favtimes",   :limit => 3, :default => 0, :null => false
    t.integer "sharetimes", :limit => 3, :default => 0, :null => false
  end

  create_table "pre_portal_article_moderate", :force => true do |t|
    t.integer "status",   :limit => 1, :default => 0, :null => false
    t.integer "dateline",              :default => 0, :null => false
  end

  add_index "pre_portal_article_moderate", ["status", "dateline"], :name => "status"

  create_table "pre_portal_article_related", :id => false, :force => true do |t|
    t.integer "aid",          :limit => 3,                :null => false
    t.integer "raid",         :limit => 3, :default => 0, :null => false
    t.integer "displayorder", :limit => 3, :default => 0, :null => false
  end

  add_index "pre_portal_article_related", ["aid", "displayorder"], :name => "aid"

  create_table "pre_portal_article_title", :primary_key => "aid", :force => true do |t|
    t.integer "catid",        :limit => 3, :default => 0,     :null => false
    t.integer "bid",          :limit => 3, :default => 0,     :null => false
    t.integer "uid",          :limit => 3, :default => 0,     :null => false
    t.string  "username",                  :default => "",    :null => false
    t.string  "title",                     :default => "",    :null => false
    t.string  "highlight",                 :default => "",    :null => false
    t.string  "author",                    :default => "",    :null => false
    t.string  "from",                      :default => "",    :null => false
    t.string  "fromurl",                   :default => "",    :null => false
    t.string  "url",                       :default => "",    :null => false
    t.string  "summary",                   :default => "",    :null => false
    t.string  "pic",                       :default => "",    :null => false
    t.boolean "thumb",                     :default => false, :null => false
    t.boolean "remote",                    :default => false, :null => false
    t.integer "id",                        :default => 0,     :null => false
    t.string  "idtype",                    :default => "",    :null => false
    t.integer "contents",     :limit => 2, :default => 0,     :null => false
    t.boolean "allowcomment",              :default => false, :null => false
    t.boolean "owncomment",                :default => false, :null => false
    t.integer "click1",       :limit => 2, :default => 0,     :null => false
    t.integer "click2",       :limit => 2, :default => 0,     :null => false
    t.integer "click3",       :limit => 2, :default => 0,     :null => false
    t.integer "click4",       :limit => 2, :default => 0,     :null => false
    t.integer "click5",       :limit => 2, :default => 0,     :null => false
    t.integer "click6",       :limit => 2, :default => 0,     :null => false
    t.integer "click7",       :limit => 2, :default => 0,     :null => false
    t.integer "click8",       :limit => 2, :default => 0,     :null => false
    t.integer "tag",          :limit => 1, :default => 0,     :null => false
    t.integer "dateline",                  :default => 0,     :null => false
    t.boolean "status",                    :default => false, :null => false
    t.boolean "showinnernav",              :default => false, :null => false
  end

  add_index "pre_portal_article_title", ["catid", "dateline"], :name => "catid"

  create_table "pre_portal_article_trash", :primary_key => "aid", :force => true do |t|
    t.text "content", :null => false
  end

  create_table "pre_portal_attachment", :primary_key => "attachid", :force => true do |t|
    t.integer "uid",        :limit => 3, :default => 0,     :null => false
    t.integer "dateline",                :default => 0,     :null => false
    t.string  "filename",                :default => "",    :null => false
    t.string  "filetype",                :default => "",    :null => false
    t.integer "filesize",                :default => 0,     :null => false
    t.string  "attachment",              :default => "",    :null => false
    t.boolean "isimage",                 :default => false, :null => false
    t.boolean "thumb",                   :default => false, :null => false
    t.boolean "remote",                  :default => false, :null => false
    t.integer "aid",        :limit => 3, :default => 0,     :null => false
  end

  add_index "pre_portal_attachment", ["aid", "attachid"], :name => "aid"

  create_table "pre_portal_category", :primary_key => "catid", :force => true do |t|
    t.integer "upid",                 :limit => 3, :default => 0,     :null => false
    t.string  "catname",                           :default => "",    :null => false
    t.integer "articles",             :limit => 3, :default => 0,     :null => false
    t.boolean "allowcomment",                      :default => true,  :null => false
    t.integer "displayorder",         :limit => 2, :default => 0,     :null => false
    t.boolean "notinheritedarticle",               :default => false, :null => false
    t.boolean "notinheritedblock",                 :default => false, :null => false
    t.string  "domain",                            :default => "",    :null => false
    t.string  "url",                               :default => "",    :null => false
    t.integer "uid",                  :limit => 3, :default => 0,     :null => false
    t.string  "username",                          :default => "",    :null => false
    t.integer "dateline",                          :default => 0,     :null => false
    t.boolean "closed",                            :default => false, :null => false
    t.boolean "shownav",                           :default => false, :null => false
    t.text    "description",                                          :null => false
    t.text    "seotitle",                                             :null => false
    t.text    "keyword",                                              :null => false
    t.string  "primaltplname",                     :default => "",    :null => false
    t.string  "articleprimaltplname",              :default => "",    :null => false
    t.boolean "disallowpublish",                   :default => false, :null => false
    t.string  "foldername",                        :default => "",    :null => false
    t.string  "notshowarticlesummay",              :default => "",    :null => false
    t.integer "perpage",              :limit => 2, :default => 0,     :null => false
    t.integer "maxpages",             :limit => 2, :default => 0,     :null => false
  end

  create_table "pre_portal_category_permission", :id => false, :force => true do |t|
    t.integer "catid",          :limit => 3, :default => 0,     :null => false
    t.integer "uid",            :limit => 3, :default => 0,     :null => false
    t.boolean "allowpublish",                :default => false, :null => false
    t.boolean "allowmanage",                 :default => false, :null => false
    t.integer "inheritedcatid", :limit => 3, :default => 0,     :null => false
  end

  add_index "pre_portal_category_permission", ["uid"], :name => "uid"

  create_table "pre_portal_comment", :primary_key => "cid", :force => true do |t|
    t.integer "uid",      :limit => 3,  :default => 0,     :null => false
    t.string  "username",               :default => "",    :null => false
    t.integer "id",       :limit => 3,  :default => 0,     :null => false
    t.string  "idtype",   :limit => 20, :default => "",    :null => false
    t.string  "postip",                 :default => "",    :null => false
    t.integer "dateline",               :default => 0,     :null => false
    t.boolean "status",                 :default => false, :null => false
    t.text    "message",                                   :null => false
  end

  add_index "pre_portal_comment", ["id", "idtype", "dateline"], :name => "idtype"

  create_table "pre_portal_comment_moderate", :force => true do |t|
    t.string  "idtype",   :limit => 15, :default => "", :null => false
    t.integer "status",   :limit => 1,  :default => 0,  :null => false
    t.integer "dateline",               :default => 0,  :null => false
  end

  add_index "pre_portal_comment_moderate", ["idtype", "status", "dateline"], :name => "idtype"

  create_table "pre_portal_rsscache", :id => false, :force => true do |t|
    t.integer "lastupdate",                :default => 0,  :null => false
    t.integer "catid",       :limit => 3,  :default => 0,  :null => false
    t.integer "aid",         :limit => 3,  :default => 0,  :null => false
    t.integer "dateline",                  :default => 0,  :null => false
    t.string  "catname",     :limit => 50, :default => "", :null => false
    t.string  "author",      :limit => 15, :default => "", :null => false
    t.string  "subject",     :limit => 80, :default => "", :null => false
    t.string  "description",               :default => "", :null => false
  end

  add_index "pre_portal_rsscache", ["aid"], :name => "aid", :unique => true
  add_index "pre_portal_rsscache", ["catid", "dateline"], :name => "catid"

  create_table "pre_portal_topic", :primary_key => "topicid", :force => true do |t|
    t.string  "title",                      :default => "",    :null => false
    t.string  "name",                       :default => "",    :null => false
    t.string  "domain",                     :default => "",    :null => false
    t.text    "summary",                                       :null => false
    t.text    "keyword",                                       :null => false
    t.string  "cover",                      :default => "",    :null => false
    t.boolean "picflag",                    :default => false, :null => false
    t.string  "primaltplname",              :default => "",    :null => false
    t.boolean "useheader",                  :default => false, :null => false
    t.boolean "usefooter",                  :default => false, :null => false
    t.integer "uid",           :limit => 3, :default => 0,     :null => false
    t.string  "username",                   :default => "",    :null => false
    t.integer "viewnum",       :limit => 3, :default => 0,     :null => false
    t.integer "dateline",                   :default => 0,     :null => false
    t.boolean "closed",                     :default => false, :null => false
    t.boolean "allowcomment",               :default => false, :null => false
    t.integer "commentnum",    :limit => 3, :default => 0,     :null => false
  end

  add_index "pre_portal_topic", ["name"], :name => "name"

  create_table "pre_portal_topic_pic", :primary_key => "picid", :force => true do |t|
    t.integer "topicid",  :limit => 3,  :default => 0,     :null => false
    t.integer "uid",      :limit => 3,  :default => 0,     :null => false
    t.string  "username", :limit => 15, :default => "",    :null => false
    t.integer "dateline",               :default => 0,     :null => false
    t.string  "filename",               :default => "",    :null => false
    t.string  "title",                  :default => "",    :null => false
    t.integer "size",                   :default => 0,     :null => false
    t.string  "filepath",               :default => "",    :null => false
    t.boolean "thumb",                  :default => false, :null => false
    t.boolean "remote",                 :default => false, :null => false
  end

  add_index "pre_portal_topic_pic", ["topicid"], :name => "topicid"

  create_table "pre_security_evilpost", :primary_key => "pid", :force => true do |t|
    t.integer "tid",           :limit => 3, :default => 0,     :null => false
    t.boolean "type",                       :default => false, :null => false
    t.integer "evilcount",                  :default => 0,     :null => false
    t.integer "eviltype",      :limit => 3, :default => 0,     :null => false
    t.integer "createtime",                 :default => 0,     :null => false
    t.boolean "operateresult",              :default => false, :null => false
    t.boolean "isreported",                 :default => false, :null => false
  end

  add_index "pre_security_evilpost", ["operateresult", "createtime"], :name => "operateresult"
  add_index "pre_security_evilpost", ["tid", "type"], :name => "type"

  create_table "pre_security_eviluser", :primary_key => "uid", :force => true do |t|
    t.integer "evilcount",                  :default => 0,     :null => false
    t.integer "eviltype",      :limit => 3, :default => 0,     :null => false
    t.integer "createtime",                 :default => 0,     :null => false
    t.boolean "operateresult",              :default => false, :null => false
    t.boolean "isreported",                 :default => false, :null => false
  end

  add_index "pre_security_eviluser", ["operateresult", "createtime"], :name => "operateresult"

  create_table "pre_security_failedlog", :force => true do |t|
    t.string  "reporttype",   :limit => 20,                  :null => false
    t.integer "tid",                        :default => 0,   :null => false
    t.integer "pid",                        :default => 0,   :null => false
    t.integer "uid",                        :default => 0,   :null => false
    t.integer "failcount",                  :default => 0,   :null => false
    t.integer "createtime",                 :default => 0,   :null => false
    t.integer "posttime",                   :default => 0,   :null => false
    t.string  "delreason",                                   :null => false
    t.integer "scheduletime",               :default => 0,   :null => false
    t.integer "lastfailtime",               :default => 0,   :null => false
    t.integer "extra1",                                      :null => false
    t.string  "extra2",                     :default => "0", :null => false
  end

  add_index "pre_security_failedlog", ["pid"], :name => "pid"
  add_index "pre_security_failedlog", ["uid"], :name => "uid"

end
