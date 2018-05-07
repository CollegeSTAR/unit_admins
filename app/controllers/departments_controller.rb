class DepartmentsController < ApplicationController

  before_action :set_institution_and_unit
  before_action :set_department, only: [:show, :edit, :update]

  def show
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(department_params)
    @department.slug = @department.name.parameterize
    @department.institution = @institution
    @department.institutional_unit = @institutional_unit
    @department.save
    if @department.persisted?
      flash[:notice] = t('helpers.creation', display_name: @department.name)
      redirect_to(
        institution_institutional_unit_department_path(
          institution_slug: @institution.slug,
          institutional_unit_slug: @institutional_unit.slug,
          slug: @department.slug
        )
      )
    else
      flash[:error] = @department.errors.full_message(:name, "can't be blank")
      render :new
    end
  end

  def edit
  end

  def update
    if @department.update(department_params)
      flash[:notice] = t('helpers.update', display_name: @department.name)
    else
      flash[:error] = @department.errors.full_messages
    end
    redirect_to institution_institutional_unit_department_path(
      institution_slug: @institution.slug,
      institutional_unit_slug: @institutional_unit.slug,
      slug: @department.slug
    )
  end

  private

  def set_institution_and_unit
    @institution = Institution.find_by slug: params[:institution_slug]
    @institutional_unit = InstitutionalUnit.find_by slug: params[:institutional_unit_slug]
  end

  def set_department
    @department = Department.find_by slug: params[:slug]
  end

  def department_params
    params.require(:department)
      .permit(
        :name,
        notes_attributes: [
          :id,
          :text
        ]
      )
  end
end
