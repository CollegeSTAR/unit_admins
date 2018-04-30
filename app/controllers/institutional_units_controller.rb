class InstitutionalUnitsController < ApplicationController

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
    @institutional_unit.save
    
    if @institutional_unit.persisted?
      flash[:notice] = "Institutional Unit successfully created."
      redirect_to @institutional_unit
    else
      flash[:error] = @institutional_unit.errors.full_message(:name, "can't be blank")
      render :new
    end
  end

  private

  def institutional_unit_params
    params.require(:institutional_unit).permit(:name)
  end
end
