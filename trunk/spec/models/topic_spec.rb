# -*- encoding : utf-8 -*-
require 'spec_helper'
describe Topic do
  it "能取出A的孩子" do
    ta = Topic.locate('A')
    ta.children.sort.should eq ['ab','abA','abc'].sort
  end
  it "能取出A的祖先" do
    ta = Topic.locate('abcd')
    ta.ancestors.sort.should eq ['abcd','abc','A','B','C','root'].sort
  end
  it "不能创建环" do
    ta = Topic.locate('C')
    expect {
      ta.add_father(Topic.locate('dd'))
    }.to raise_error(Ktv::Shared::UserDataException)
    expect {
      ta.add_father(Topic.locate('c'))
    }.to raise_error(Ktv::Shared::UserDataException)
    tb = Topic.locate('B')
    ta = Topic.locate('A')
    ta.add_father(tb)
    true.should be true
  end
  # it "当create新的课件时，填写一个topic名字A，应该更新A的课件数，以及所有A的父亲的课件数" do
  #   cw = Courseware.create!(:title=>'课件标题',:topic=>'A')
  #   ta = Topic.locate('A')
  # end
end
