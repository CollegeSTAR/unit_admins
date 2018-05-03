class UnitAdministratorsController < ApplicationController
  
  before_action :set_institution_institution_unit

  def show
    @administrator = UnitAdministrator.find(params[:id])
  end
  
  def new
    @administrator = UnitAdministrator.new
    @administrator.administrative_assistant = AdministrativeAssistant.new
  end

  def create
    @administrator = UnitAdministrator.new(administrator_params)
    @administrator.institution = @institution
    @administrator.institutional_unit = @institutional_unit
    @administrator.save

    if @administrator.persisted?
      flash[:notice] = 'Successfully added administrator.'
      redirect_to institution_institutional_unit_unit_administrator_path(
        institution_slug: @institution.slug,
        institutional_unit_slug: @institutional_unit.slug,
        id: @administrator.id
      )
    else
      render :new
    end
  end

  private 

  def set_institution_institution_unit
    @institution = Institution.find_by slug: params[:institution_slug]
    @institutional_unit = InstitutionalUnit.find_by slug: params[:institutional_unit_slug]
  end

  def administrator_params
    params.require(:unit_administrator)
      .permit(
        :job_title,
        :title,
        :first_name,
        :last_name,
        :email,
        :phone_number,
        :mail_stop,
        :sec_loc,
        administrative_assistant_attributes: [
          :first_name,
          :last_name,
          :email,
          :phone_number,
          :mail_stop,
          :address
        ]
      )
  end
end
