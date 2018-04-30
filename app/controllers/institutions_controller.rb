class InstitutionsController < ApplicationController
  
  def index
    @institutions = Institution.all
  end

  def show
    @institution = Institution.includes(:institutional_units).find_by slug: params[:slug]
  end

  def new
    @institution = Institution.new
  end

  def create
    @institution = Institution.new(institution_params)
    @institution.slug = @institution.name.parameterize
    @institution.save
    if @institution.persisted?
      flash[:notice] = 'Successfully created institution.'
      redirect_to @institution
    else
      flash[:error] = @institution.errors.full_message(:name, "can't be blank.")
      render :new
    end
  end

  private

  def institution_params
    params.require(:institution).permit(:name)
  end
end
