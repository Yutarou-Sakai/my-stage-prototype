class CoursesController < ApplicationController
  before_action :set_course, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :has_admin_or_teacher?, only: [:new, :create, :edit, :update, :destroy]

  def index
    @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search)
    @pagy, @courses = pagy(@ransack_courses.result.includes(:user).order(updated_at: :DESC))
  end

  def show
    @lessons = @course.lessons.all
    @voices = @course.enrollments.all
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    @course = Course.new(course_params)
    @course.user = current_user

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_course
      @course = Course.friendly.find(params[:id])
    end

    def course_params
      params.require(:course).permit(
        :title,
        :description,
        :short_descriotion,
        :language,
        :language,
        :price,
        :course_url
      )
    end

    def has_admin_or_teacher?
      unless current_user.has_role?(:admin) || current_user.has_role?(:teacher)
        redirect_to root_path
      end
    end
end
