# frozen_string_literal: true

Given('I am on the create account page') do
  visit '/users/new'
end

Then('I should see {string}') do |string|
  expect(page).to have_content string
end

Then('I should see {string} button') do |string|
  expect(page).to have_button string
end

When('I fill in {string} with {string}') do |string, string2|
  fill_in string, with: string2
end

When('I click Create user') do
  click_button('Create User')
end
Then('I shoud be redirect to show page') do
  user = User.find_by(email: 'janedoe@email.com')
  user_id = user.id
  visit "/users/#{user_id}"
end

Given('a registered user with the email {string}  exists') do |string|
  FactoryBot.create(:user, email: string)
end
