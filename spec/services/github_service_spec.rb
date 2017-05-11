require 'rails_helper'

describe GithubService do
  attr_reader :service

  before(:each) do
    user = User.from_omniauth({ 'id' => '23153035', 'login' => 'dannyradden' },
                              ENV["token"])
    @service = GithubService.new(user)
  end

  describe 'repos' do
    it 'returns all repos' do
      VCR.use_cassette("services/repos") do
        repos = @service.repos

        expect(repos.first).to have_key(:id)
        expect(repos.first).to have_key(:name)
      end
    end
  end

  describe 'starred repos' do
    it 'returns starred repositories' do
      VCR.use_cassette("services/starred") do
        stars = @service.starred_repos
        star  = stars.first

        expect(stars.count).to eq(6)
        expect(star[:name]).to eq("ReduxCasts")
      end
    end
  end
end
