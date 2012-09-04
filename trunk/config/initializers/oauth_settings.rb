# -*- encoding : utf-8 -*-
module Oauth
  def self.settings
    @settings ||= YAML.load_file("#{Rails.root}/config/oauth.yml")
  end
end
