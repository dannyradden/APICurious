class SessionsController < ApplicationController
  def create
    @response =
    Faraday.post("https://github.com/login/oauth/access_token?client_id=#{ENV["github_client_id"]}&client_secret=#{ENV["github_client_secret"]}&code=#{params["code"]}")

    token = @response.body.split(/\W+/)[1]
    oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token}")
    auth = JSON.parse(oauth_response.body)

    user = User.from_omniauth(auth, token)

    session[:user_id] = user.id

    redirect_to dashboard_index_path
  end
end
