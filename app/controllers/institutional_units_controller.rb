class InstitutionalUnitsController < ApplicationController
  before_action :set_institution

  def index
    @institutional_units = InstitutionalUnit.all
  end

  def show
    @institutional_unit = InstitutionalUnit.find_by slug: params[:slug]
  end
  
  def new
    @institutional_unit = InstitutionalUnit.new
  end

  def create
    @institutional_unit = InstitutionalUnit.new(institutional_unit_params)
    @institutional_unit.slug = @institutional_unit.name.parameterize
    @institutional_unit.institution = @institution
    
    @institutional_unit.save
    
    if @institutional_unit.persisted?
      flash[:notice] = "Institutional Unit successfully created."
      redirect_to institution_institutional_unit_path(institution_slug: @institution.slug, slug: @institutional_unit.slug)
    else
      flash[:error] = @institutional_unit.errors.full_message(:name, "can't be blank")
      render :new
    end
  end

  private

  def set_institution
    @institution = Institution.find_by slug: params[:institution_slug]
  end

  def institutional_unit_params
    params.require(:institutional_unit).permit(:name)
  end
end
