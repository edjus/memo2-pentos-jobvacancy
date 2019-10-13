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
  click_button('Apply')
end
When('I apply with curriculum {string}') do |curriculum|
  click_link 'Apply'
  fill_in('job_application[applicant_email]', with: 'applicant@test.com')
  fill_in('job_application[applicant_curriculum]', with: curriculum)
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

When('I apply with remuneration between {int} and {int}') do |ini_range, end_range|
  click_link 'Apply'
  fill_in('job_application[applicant_email]', with: 'applicant@test.com')
  fill_in('job_application[expected_remuneration_min]', with: ini_range)
  fill_in('job_application[expected_remuneration_max]', with: end_range)
  click_button('Apply')
end

Then('the offeror receives an mail which includes {string}') do |text|
  mail_store = "#{Padrino.root}/tmp/emails"
  file = File.open("#{mail_store}/offerer@test.com", 'r')
  content = file.read
  content.include?(text).should be true
end
