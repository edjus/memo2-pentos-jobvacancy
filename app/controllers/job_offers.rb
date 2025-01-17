JobVacancy::App.controllers :job_offers do
  get :my do
    @offers = JobOfferRepository.new.find_by_owner(current_user)
    render 'job_offers/my_offers'
  end

  get :index do
    @offers = JobOfferRepository.new.all_active
    render 'job_offers/list'
  end

  get :new do
    @job_offer = JobOffer.new
    render 'job_offers/new'
  end

  get :latest do
    @offers = JobOfferRepository.new.all_active
    render 'job_offers/list'
  end

  get :edit, with: :offer_id do
    @job_offer = JobOfferRepository.new.find(params[:offer_id])
    # TODO: validate the current user is the owner of the offer
    render 'job_offers/edit'
  end

  get :apply, with: :offer_id do
    @job_offer = JobOfferRepository.new.find(params[:offer_id])
    @job_application = JobApplication.new
    # TODO: validate the current user is the owner of the offer
    render 'job_offers/apply'
  end

  post :search do
    @offers = JobOfferRepository.new.search_by_title(params['search-input'])
    render 'job_offers/list'
  end

  post :apply, with: :offer_id do
    @job_offer = JobOfferRepository.new.find(params[:offer_id])

    begin
      @job_application = build_job_application_from_params params[:job_application]

      if JobApplicationRepository.new.save(@job_application)
        @job_application.process

        flash[:success] = 'Contact information sent.'
        redirect '/job_offers'
      else
        flash.now[:error] = extract_first_error @job_application
        @job_application = JobApplication.new
        render 'job_offers/apply'
      end
    rescue ApplicationCreationExceptions => e
      @job_application = JobApplication.new
      flash.now[:error] = e.message
      render 'job_offers/apply'
    end
  end

  get :copy do
    @job_offer = JobOfferRepository.new.find(params[:offer_id])

    render 'job_offers/new'
  end

  get :view do
    @job_offer = JobOfferRepository.new.find(params[:offer_id])
    @applications = JobApplicationRepository.new.find_by_offer(params[:offer_id])

    render 'job_offers/view'
  end

  post :create do
    @job_offer = JobOffer.new(job_offer_params)
    @job_offer.deactivate
    @job_offer.owner = current_user
    if JobOfferRepository.new.save(@job_offer)
      TwitterClient.publish(@job_offer) if params['create_and_twit']
      flash[:success] = 'Offer created'
      redirect '/job_offers/my'
    else
      flash.now[:error] = 'Title is mandatory'
      render 'job_offers/new'
    end
  end

  post :update, with: :offer_id do
    @job_offer = JobOffer.new(job_offer_params.merge(id: params[:offer_id]))
    @job_offer.owner = current_user

    if JobOfferRepository.new.save(@job_offer)
      flash[:success] = 'Offer updated'
      redirect '/job_offers/my'
    else
      flash.now[:error] = 'Title is mandatory'
      render 'job_offers/edit'
    end
  end

  put :activate, with: :offer_id do
    @job_offer = JobOfferRepository.new.find(params[:offer_id])
    @job_offer.activate
    if JobOfferRepository.new.save(@job_offer)
      flash[:success] = 'Offer activated'
    else
      flash.now[:error] = 'Operation failed'
    end

    redirect '/job_offers/my'
  end

  delete :destroy do
    @job_offer = JobOfferRepository.new.find(params[:offer_id])
    if JobOfferRepository.new.destroy(@job_offer)
      flash[:success] = 'Offer deleted'
    else
      flash.now[:error] = 'Title is mandatory'
    end
    redirect 'job_offers/my'
  end

  put :satisfy, with: :offer_id do
    @job_offer = JobOfferRepository.new.find(params[:offer_id])
    @job_offer.deactivate
    if JobOfferRepository.new.save(@job_offer)
      flash[:success] = 'Offer satisfied'
    else
      flash.now[:error] = 'Operation failed'
    end

    redirect '/job_offers/my'
  end
end
