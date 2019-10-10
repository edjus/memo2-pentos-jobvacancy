Given('{string} offer exists') do |title|
  job_offer = JobOffer.new
  job_offer.owner = UserRepository.new.first
  job_offer.title = title
  job_offer.location = 'a nice job'
  job_offer.description = 'a nice job'
  job_offer.is_active = true

  JobOfferRepository.new.save job_offer
end

Given('I fill the search bar with {string}') do |search|
  fill_in('search-input', with: search)
end

When('I click search') do
  click_button('search')
end
