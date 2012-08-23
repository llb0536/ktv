class UcApp
  include Mongoid::Document
  field :mysql_id
  field :item
=begin
"item"=>
 ["1",
  "DISCUZX",
  "Kejian.TV ç\u009B®å½\u0095æ£\u0080ç´¢",
  "http://kejian.lvh.me/simple",
  {"id"=>"ip", "__content__"=>""},
  {"id"=>"viewprourl", "__content__"=>""},
  "uc.php",
  "utf-8",
  "1",
  {"id"=>"extra",
   "item"=>
    [{"id"=>"apppath", "__content__"=>""},
     {"id"=>"extraurl", "__content__"=>"\t\t\t"}]},
  "1"]
=end
end