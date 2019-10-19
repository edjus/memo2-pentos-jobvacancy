Given(/^only a "(.*?)" offer exists in the offers list$/) do |job_title|
  JobOfferRepository.new.delete_all

  @job_offer = create_offer job_title
end

Given(/^I access the offers list page$/) do
  visit '/job_offers/latest'
end

When(/^I apply$/) do
  click_link 'Apply'
  fill_in('job_application[applicant_email]', with: 'applicant@test.com')
  fill_in('job_application[expected_remuneration_min]', with: 200)
  fill_in('job_application[expected_remuneration_max]', with: 300)
  click_button('Apply')
end

Then(/^I should receive a mail with offerer info$/) do
  mail_store = "#{Padrino.root}/tmp/emails"
  file = File.open("#{mail_store}/applicant@test.com", 'r')
  content = file.read
  content.include?(@job_offer.title).should be true
  content.include?(@job_offer.location).should be true
  content.include?(@job_offer.description).should be true
  content.include?(@job_offer.owner.email).should be true
  content.include?(@job_offer.owner.name).should be true
end

Given('job applicant named {string} applied for {string}') do |name, _job_title|
  visit '/job_offers/latest'
  click_link 'Apply'
  fill_in('job_application[applicant_email]', with: name + '@test.com')
  fill_in('job_application[expected_remuneration_min]', with: 200)
  fill_in('job_application[expected_remuneration_max]', with: 300)
  click_button('Apply')
end

When('I apply with curriculum {string}') do |curriculum|
  click_link 'Apply'
  fill_in('job_application[applicant_email]', with: 'applicant@test.com')
  fill_in('job_application[applicant_curriculum]', with: curriculum)
  fill_in('job_application[expected_remuneration_min]', with: 200)
  fill_in('job_application[expected_remuneration_max]', with: 300)
  click_button('Apply')
end

Then('It should include {string}') do |text|
  mail_store = "#{Padrino.root}/tmp/emails"
  file = File.open("#{mail_store}/applicant@test.com", 'r')
  content = file.read

  content.include?(text).should be true
end

When('I apply with no curriculum') do
  step 'I apply'
end

When('I apply with no bio') do
  step 'I apply'
end

When('I apply with remuneration between {int} and {int}') do |ini_range, end_range|
  click_link 'Apply'
  fill_in('job_application[applicant_email]', with: 'applicant@test.com')
  fill_in('job_application[expected_remuneration_min]', with: ini_range)
  fill_in('job_application[expected_remuneration_max]', with: end_range)
  click_button('Apply')
end

When('I apply with bio {string}') do |bio|
  click_link 'Apply'
  fill_in('job_application[applicant_email]', with: 'applicant@test.com')
  fill_in('job_application[expected_remuneration_min]', with: 1)
  fill_in('job_application[expected_remuneration_max]', with: 1)
  fill_in('job_application[bio]', with: bio)
  click_button('Apply')
end

When('I apply with email {string}, curriculum {string}, remuneration {int} and bio {string}') do |email, curriculum, remuneration, bio|
  click_link 'Apply'
  fill_in('job_application[applicant_email]', with: email)
  fill_in('job_application[applicant_curriculum]', with: curriculum)
  fill_in('job_application[expected_remuneration_min]', with: remuneration)
  fill_in('job_application[bio]', with: bio)
  click_button('Apply')
end

When('I apply with email {string}, curriculum {string}, remuneration between {int} and {int} and bio {string}') do |email, curriculum, remuneration_min, remuneration_max, bio|
  click_link 'Apply'
  fill_in('job_application[applicant_email]', with: email)
  fill_in('job_application[applicant_curriculum]', with: curriculum)
  fill_in('job_application[expected_remuneration_min]', with: remuneration_min)
  fill_in('job_application[expected_remuneration_max]', with: remuneration_max)
  fill_in('job_application[bio]', with: bio)
  click_button('Apply')
end

Then('the offeror receives an mail which includes {string}') do |text|
  mail_store = "#{Padrino.root}/tmp/emails"
  file = File.open("#{mail_store}/offerer@test.com", 'r')
  content = file.read
  content.include?(text).should be true
end

Then('I am still in the apply page') do
  expect(page.current_path).to include('job_offers/apply/')
end
