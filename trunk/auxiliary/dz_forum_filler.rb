data=%w{
  公务员/事业单位
  科研管理人员
  农/林/牧/渔
  饲料业务
  养殖人员
  农艺师
  畜牧师
}.uniq.sort

data.each_with_index{|item,index| PreForumForum.insert_sub(71,item,index+1)}

PreForumForum.insert_sub(76,'高等教育自学考试',131)
PreForumForum.insert_sub(76,'日语能力等级考试',132)
PreForumForum.insert_sub(76,'高考',41)


PreForumForum.insert_sub(75,'注册咨询工程师考试',1)
PreForumForum.insert_sub(75,'投资建设项目管理师考试',2)
PreForumForum.insert_sub(75,'初级会计职称考试',3)
PreForumForum.insert_sub(75,'中级会计职称考试',4)
PreForumForum.insert_sub(75,'计算机软件考试',5)
PreForumForum.insert_sub(75,'监理工程师考试',6)
PreForumForum.insert_sub(75,'环境影响评价工程师考试',7)
PreForumForum.insert_sub(75,'剑桥商务英语考试',8)
PreForumForum.insert_sub(75,'管理咨询师考试',9)
PreForumForum.insert_sub(75,'土地登记代理人考试',10)
PreForumForum.insert_sub(75,'质量工程师考试',11)
PreForumForum.insert_sub(75,'注册税务师考试',12)
PreForumForum.insert_sub(75,'注册资产评估师考试',13)
PreForumForum.insert_sub(75,'注册设备监理师考试',14)
PreForumForum.insert_sub(75,'注册安全工程师考试',15)
PreForumForum.insert_sub(75,'注册会计师考试',16)
PreForumForum.insert_sub(75,'土地估价师考试',17)
PreForumForum.insert_sub(75,'物业管理师考试',18)
PreForumForum.insert_sub(75,'注册岩土工程师考试',19)
PreForumForum.insert_sub(75,'注册电气工程师考试',20)
PreForumForum.insert_sub(75,'注册环保工程师考试',21)
PreForumForum.insert_sub(75,'注册结构工程师考试',22)
PreForumForum.insert_sub(75,'国际商务师考试',23)
PreForumForum.insert_sub(75,'外销员考试',24)
PreForumForum.insert_sub(75,'房地产估价师考试',25)
PreForumForum.insert_sub(75,'房地产经纪人考试',26)
PreForumForum.insert_sub(75,'执业药师资格考试',27)
PreForumForum.insert_sub(75,'审计师考试',28)
PreForumForum.insert_sub(75,'造价工程师考试',29)
PreForumForum.insert_sub(75,'注册城市规划师考试',30)
PreForumForum.insert_sub(75,'报关员考试',31)
PreForumForum.insert_sub(75,'土地估价师考试',32)
PreForumForum.insert_sub(75,'心理咨询师考试',33)
PreForumForum.insert_sub(75,'物流师考试',34)
PreForumForum.insert_sub(75,'公共营养师考试',35)
PreForumForum.insert_sub(75,'全国计算机等级考试',36)
PreForumForum.insert_sub(75,'职称俄语考试',371)

PreForumForum.insert2(43,'校外机构与其他',100)
