class User < ApplicationRecord
  def self.from_omniauth(auth_info, token)
    user = find_or_create_by(uid: auth_info["id"])
    user.username = auth_info["login"]
    user.token = token
    user
  end
end
