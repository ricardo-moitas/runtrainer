class SessionsController < Devise::SessionsController
  def new
    self.resource = resource_class.new(sign_in_params)
    super
  end
end
