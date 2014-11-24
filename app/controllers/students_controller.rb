class StudentsController < ApplicationController
  before_action :logged_in_user
  before_action :set_student, only: [:edit, :update, :destroy]

  def index
    @students = Student.paginate(page: params[:page])
  end

  def new
    @student = Student.new
  end

  def edit
  end

  def create
    @student = Student.new(student_params)

    if @student.save
      redirect_to students_url, notice: 'Student was successfully created.'
    else
      render :new
    end
  end

  def update
    if @student.update(student_params)
      redirect_to students_url, notice: 'Student was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @student.destroy
    redirect_to students_url, notice: 'Student was successfully destroyed.'
  end

  private
    def set_student
      @student = Student.find(params[:id])
    end

    def student_params
      params.require(:student).permit(:name, :email)
    end
end
