def create_offer(title, location = 'a nice job', description = 'a nice job')
  job_offer = JobOffer.new
  job_offer.owner = UserRepository.new.first
  job_offer.title = title
  job_offer.location = location
  job_offer.description = description
  job_offer.is_active = true

  JobOfferRepository.new.save job_offer
end
