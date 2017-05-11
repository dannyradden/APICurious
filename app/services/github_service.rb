class GithubService
  attr_reader :connection, :user

  def initialize(user)
    @user = user
    @connection = Faraday.new("https://api.github.com/user?access_token=#{user.token}")
  end

  def repos
    parse(connection.get('/user/repos'))
  end

  def starred_repos
    parse(connection.get('/user/starred'))
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
