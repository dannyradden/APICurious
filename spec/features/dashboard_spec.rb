require 'rails_helper'

feature 'User Dashboard' do
  scenario 'User can see profile info' do
    visit dashboard_index_path
  end
end
