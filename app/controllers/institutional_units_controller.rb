class InstitutionalUnitsController < ApplicationController
  before_action :set_institution
  before_action :set_institutional_unit, only: [:show, :update]

  def index
    @institutional_units = InstitutionalUnit.all
  end

  def show
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

  def update
    if @institutional_unit.update(institutional_unit_params)
      flash[:notice] = "Successfully updated #{@institutional_unit.name}."
    else
      flash[:error] = @institutional_unit.errors.full_messages
    end
    redirect_to institution_institutional_unit_path(institution_slug: @institution.slug, slug: @institutional_unit.slug)
  end

  private

  def set_institution
    @institution = Institution.find_by slug: params[:institution_slug]
  end

  def set_institutional_unit
    @institutional_unit = InstitutionalUnit.includes(:departments, :unit_administrators, :notes).find_by slug: params[:slug]
  end

  def institutional_unit_params
    params.require(:institutional_unit).permit(:name, notes_attributes: [:id, :text])
  end
end
