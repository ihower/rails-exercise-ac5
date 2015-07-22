class ApiController < ActionController::Base


  before_action :authenticate_user_from_token!

  def authenticate_user_from_token!

    a = { :a => 1, :b => 2 }
    b = { a:1 , b: 2 }

    if params[:auth_token].present?
      user = User.find_by_authentication_token( params[:auth_token] )
      sign_in(user, store: false) if user
    end

  end

end

