# coding: utf-8

class MineController < ApplicationController
  def index
    @seo[:title] = "我的课件"
  end
end