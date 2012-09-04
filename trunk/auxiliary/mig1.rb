# -*- encoding : utf-8 -*-
# # coding: utf-8
# father = Topic.math_and_sciences
# # t=Topic.find_or_create_by(name:'生物学');t.add_father(father)
# # t=Topic.find_or_create_by(name:'脑与认知科学');t.add_father(father)
# # t=Topic.find_or_create_by(name:'化学');t.add_father(father)
# # t=Topic.find_or_create_by(name:'地球、大气与行星科学');t.add_father(father)
# # t=Topic.find_or_create_by(name:'数学');t.add_father(father)
# # t=Topic.find_or_create_by(name:'物理');t.add_father(father)
# t=Topic.find_or_create_by(name:'卫生科学与技术');t.add_father(father)
# 
# father = Topic.engineering
# %w{
#   软件工程
#   计算机科学
#   航空航天
#   生物工程
#   化学工程
#   土木与环境工程
#   电气工程
#   工程系统
#   材料科学与工程
#   机械工程
#   核科学与工程
#   建筑学
#   城市研究与规划
# }.each do |name|
#   t=Topic.find_or_create_by(name:name);t.add_father(father)
# end
# 
# 
# father = Topic.humanities
# %w{
#   人类学
#   比较媒体学
#   经济学
#   语言与文学
#   历史
#   语言学
#   哲学
#   音乐与戏剧艺术
#   政治学
#   妇女与性别研究
#   其他人文研究
#   教育学
#   管理学
#   媒体艺术与科学
# }.each do |name|
#   t=Topic.find_or_create_by(name:name);t.add_father(father)
# end
# 
# father = Topic.interdisciplinaries
# %w{
#   能源
#   创业
#   环境
#   生命科学
#   交通
#   教育技术
# }.each do |name|
#   t=Topic.find_or_create_by(name:name);t.add_father(father)
# end
# 
# father = Topic.others
# %w{
#   竞技体育、体育与娱乐
#   军事科学
# }.each do |name|
#   t=Topic.find_or_create_by(name:name);t.add_father(father)
# end

item=Courseware.first.user
ec = UserCache.create!(id:item.id,hot_rank:1,followers_count:item.followers_count)

u=User.last
u.auto_slug
u.update_consultant!

User.all.each{|u| u.update_attribute(:coursewares_count,u.coursewares.count)}
