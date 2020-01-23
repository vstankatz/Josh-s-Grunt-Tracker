class EmployeesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def new
    @division= Division.find(params[:division_id])
    @employee = @division.employees.new
    render :new
  end

  def create
    @division = Division.find(params[:division_id])
    @employee = @division.employees.new(employee_params)
    if @employee.save
      redirect_to division_path(@division)
    else
      render :new
    end
  end

  def edit
    @division = Division.find(params[:division_id])
    @employee = Employee.find(params[:id])
    render :edit
  end

  def show
    @division = Division.find(params[:division_id])
    @employee = Employee.find(params[:id])
    @projects = []
      Project.all.each do |project|
        @projects.push(project.name)
      end
    render :show
  end

  def update
    @employee= Employee.find(params[:id])
    if @employee.update(employee_params)
      redirect_to division_path(@employee.division)
    else
      render :edit
    end
  end

  def add
    @employee = Employee.find(params[:id])
    project = Project.where(name: params[:project].fetch("project")).first
    project.employees << @employee
    flash[:notice] = "project added!"
    # @employee.projects << project
    render :show
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    redirect_to division_path(@employee.division)
  end

  private
  def employee_params
    params.require(:employee).permit(:name)
  end

end
