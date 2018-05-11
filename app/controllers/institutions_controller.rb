class InstitutionsController < ApplicationController
  
  before_action :authenticate_user! 
  before_action :set_institution, only: [:show, :edit, :update]
  def index
    @institutions = Institution.all
  end

  def show
  end

  def new
    @institution = Institution.new
  end

  def create
    @institution = Institution.new(institution_params)
    @institution.slug = @institution.name.parameterize
    @institution.save
    if @institution.persisted?
      flash[:notice] = t('helpers.creation', display_name: @institution.name)
      redirect_to @institution
    else
      flash[:error] = @institution.errors.full_message(:name, "can't be blank.")
      render :new
    end
  end

    def edit
    end

    def update
      if @institution.update(institution_params)
        flash[:notice] = t('helpers.update', display_name: @institution.name)
      else
        flash[:error] = @institution.errors.full_messages
      end
      redirect_to institution_path @institution
  end

  private

  def set_institution
    @institution = Institution.includes(:institutional_units).find_by slug: params[:slug]
  end

  def institution_params
    params.require(:institution).permit(:name)
  end
end
