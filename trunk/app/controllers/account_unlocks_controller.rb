# -*- encoding : utf-8 -*-
class AccountUnlocksController < Devise::UnlocksController
  def new
    super
    render "new#{@subsite}"
  end
  def create
    self.resource = resource_class.send_unlock_instructions(resource_params)

    if successfully_sent?(resource)
      respond_with({}, :location => after_sending_unlock_instructions_path_for(resource))
    else
      respond_with(resource) do |format|
        format.html{render "new#{@subsite}"}
      end
    end
  end
  def show
    super
  end
end
