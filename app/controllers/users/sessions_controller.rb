class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(_resource)
    posts_path
  end
end
