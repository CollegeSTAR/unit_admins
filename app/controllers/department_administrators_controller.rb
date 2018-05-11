class DepartmentAdministratorsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_institution_institution_unit_department
  before_action :set_administrator, only: [:show, :edit, :update]

  def show
  end
  
  def new
    @administrator = DepartmentAdministrator.new
    @administrator.administrative_assistant = AdministrativeAssistant.new
  end

  def create
    @administrator = DepartmentAdministrator.new(administrator_params)
    @administrator.institution = @institution
    @administrator.institutional_unit = @institutional_unit
    @administrator.department = @department
    @administrator.save

    if @administrator.persisted?
      flash[:notice] = t('helpers.creation', display_name: @administrator.job_title)
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

  def edit
  end

  def update
    if @administrator.update(administrator_params)
      flash[:notice] = t('helpers.update', display_name: @administrator.job_title)
    else
      flash[:error] = @administrator.errors.full_messages
    end
    redirect_to institution_institutional_unit_department_department_administrator_path(
      institution_slug: @institution.slug,
      institutional_unit_slug: @institutional_unit.slug,
      department_slug: @department.slug,
      id: @administrator.id
    )
  end

  private 

  def set_institution_institution_unit_department
    @institution = Institution.find_by slug: params[:institution_slug]
    @institutional_unit = InstitutionalUnit.find_by slug: params[:institutional_unit_slug]
    @department = Department.find_by slug: params[:department_slug]
  end

  def set_administrator
    @administrator = DepartmentAdministrator.find(params[:id])
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
        :interim,
        administrative_assistant_attributes: [
          :first_name,
          :last_name,
          :email,
          :phone_number,
          :mail_stop,
          :address
        ],
        notes_attributes: [
          :id,
          :text
        ]
      )
  end
end
