When(/^I browse the default page$/) do
  visit '/'
end

Given(/^I am logged in as job offerer$/) do
  visit '/login'
  fill_in('user[email]', with: 'offerer@test.com')
  fill_in('user[password]', with: 'Passw0rd!')
  click_button('Login')
  page.should have_content('offerer@test.com')
end

Given(/^I access the new offer page$/) do
  visit '/job_offers/new'
  page.should have_content('Title')
end

When(/^I fill the title with "(.*?)"$/) do |offer_title|
  fill_in('job_offer[title]', with: offer_title)
end

When(/^confirm the new offer$/) do
  click_button('Create')
end

Then(/^I should see "(.*?)" in My Offers$/) do |content|
  visit '/job_offers/my'
  page.should have_content(content)
end

Then(/^I should not see "(.*?)" in My Offers$/) do |content|
  visit '/job_offers/my'
  page.should_not have_content(content)
end

Given(/^I have "(.*?)" offer in My Offers$/) do |offer_title|
  JobOfferRepository.new.delete_all

  visit '/job_offers/new'
  fill_in('job_offer[title]', with: offer_title)
  click_button('Create')
end

Given(/^I edit it$/) do
  click_link('Edit')
end

And(/^I delete it$/) do
  click_button('Delete')
end

Given(/^I set title to "(.*?)"$/) do |new_title|
  fill_in('job_offer[title]', with: new_title)
end

Given(/^I save the modification$/) do
  click_button('Save')
end

Given(/^I have an job offer titled "(.*?)", on "(.*?)" with description "(.*?)"$/) do |title, _location, _description|
  visit '/job_offers/new'
  fill_in('job_offer[title]', with: title)
  click_button('Create')
  click_button('Activate')
end

When('I access "My Offers"') do
  visit '/job_offers/my'
end

Then('the offer {string} has {int} applications') do |title, q_applicants|
  within('tr', text: title) do
    page.should have_content(q_applicants)
  end
end

Given('I access the my offers page') do
  visit '/job_offers/my'
  page.should have_content('My Job Offers')
end

Given('an offer with title {string}, location {string} and description {string} exists') do |title, location, description|
  create_offer title, location, description
end

When('I click copy for {string}') do |title|
  within('tr', text: title) do
    click_link('Copy')
  end
end

Then('the title field value should be {string}') do |title|
  value = find_field('job_offer[title]').value
  expect(title).to eq(value)
end

Then('the location field value should be {string}') do |location|
  value = find_field('job_offer[location]').value
  expect(location).to eq(value)
end

Then('the description field value should be {string}') do |description|
  value = find_field('job_offer[description]').value
  expect(description).to eq(value)
end

When('the offer {string} should have {string}') do |title, value|
  within('tr', text: title) do
    page.should have_content(value)
  end
end

When('I click on view the offer applications') do
  click_link('View')
end

Then('the table should be empty') do
  table_body = find('tbody')

  expect(table_body).to have_no_content('*')
end

# rubocop:disable Metrics/LineLength, Metrics/ParameterLists
Given('the user {string} has applied to the offer {string} with curriculum {string}, remuneration {int} and bio {string}') do |user, _offer_title, curriculum, remuneration, bio|
  step 'I access the offers list page'
  step "I apply with email \"#{user}\", curriculum \"#{curriculum}\", remuneration #{remuneration} and bio \"#{bio}\""
end

Given('the user {string} has applied to the offer {string} with curriculum {string}, remuneration between {int} and {int} and bio {string}') do |user, _offer_title, curriculum, remuneration_min, remuneration_max, bio|
  step 'I access the offers list page'
  step "I apply with email \"#{user}\", curriculum \"#{curriculum}\", remuneration between #{remuneration_min} and #{remuneration_max} and bio \"#{bio}\""
end

Then('I should see a record with email {string}, curriculum {string}, remuneration {string} and bio {string}') do |email, curriculum, remuneration, bio|
  within('tr', text: email) do
    page.should have_content(email)
    page.should have_content(curriculum)
    page.should have_content(remuneration)
    page.should have_content(bio)
  end
end
# rubocop:enable Metrics/LineLength, Metrics/ParameterLists
Then('the {string} button should be disabled') do |button_name|
  visit '/job_offers/my'
  expect(page).to have_button(button_name, disabled: true)
end
