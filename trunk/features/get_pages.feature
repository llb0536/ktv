Feature: Get Pages
  In order to keep all pages of wendao being able to be opened
  I want to make sure that all the following scenarios pass
  
  Background:
    Given I login with user luda01@sina.com and password 123456
    
  Scenario: newbie page
    I go to url "/newbie"
    I should see "关注你感兴趣的内容，开始Kejian.TV吧！"
  
  Scenario: root page
    I go to url "/root"
    I should see "我关注的问题"

  Scenario: cpanel
    I go to url "/cpanel"
    I should see "查看所有"
    I follow "用户"
    I should see "查看所有"
    I follow "问题"
    I should see "查看所有"
    I follow "解答"
    I should see "查看所有"
    I follow "领域"
    I should see "查看所有"
    I follow "评论"
    I should see "查看所有"
    
  Scenario: cpanel edit
    I go to url "/cpanel"
    I should see "修改"
    I follow "修改"
    I should see "提交"
    I follow "问题"
    I should see "修改"
    I follow "修改"
    I should see "提交"
    I follow "解答"
    I should see "修改"
    I follow "修改"
    I should see "提交"
    I follow "领域"
    I should see "修改"
    I follow "修改"
    I should see "提交"
    I follow "评论"
    I should see "修改"
    I follow "修改"
    I should see "提交"
