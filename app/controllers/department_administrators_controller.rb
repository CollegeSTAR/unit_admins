class DepartmentAdministratorsController < ApplicationController
  
  before_action :set_institution_institution_unit_department

  def show
    @administrator = DepartmentAdministrator.find(params[:id])
  end
  
  def new
    @administrator = DepartmentAdministrator.new
    @administrator.administrative_assistant = AdministrativeAssistant.new
  end

  def create
    @administrator = DepartmentAdministrator.new(administrator_params)
    @administrator.department = @department
    @administrator.save

    if @administrator.persisted?
      flash[:notice] = 'Successfully added administrator.'
      redirect_to institution_institutional_unit_department_department_administrator_path(
        institution_slug: @institution.slug,
        institutional_unit_slug: @institutional_unit.slug,
        department_slug: @department.slug,
        id: @administrator.id
      )
    else
      render :new
    end
  end

  private 

  def set_institution_institution_unit_department
    @institution = Institution.find_by slug: params[:institution_slug]
    @institutional_unit = InstitutionalUnit.find_by slug: params[:institutional_unit_slug]
    @department = Department.find_by slug: params[:department_slug]
  end

  def administrator_params
    params.require(:department_administrator)
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
