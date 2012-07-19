class AccountSessionsController < Devise::SessionsController 
  def new
    resource = build_resource(nil, :unsafe => true)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource)) do |format|
      format.html{render "new#{@subsite}"}
    end
  end
  def create
    super
  end
  def destroy
    super
  end
end