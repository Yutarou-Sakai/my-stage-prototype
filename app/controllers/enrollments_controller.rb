class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: %i[ show edit update destroy ]
  before_action :set_course, only: %i[ new create ]

  def index
    user = current_user

    @ransack_enrollments = Enrollment.ransack(params[:q])

    # @my_enrollments = Enrollment.friendly.where(user_id: user.id)
    @pagy, @enrollments = pagy(@ransack_enrollments.result(distinct: true).where(user_id: user.id).order(updated_at: :DESC))
  end

  def show
  end

  def new
    @enrollment = Enrollment.new
  end

  def edit
  end

  def create
    if @course.price > 0
      flash[:arert] = 'You can not access paid courses yet.'
      redirect_to new_course_enrollment_path(@course)
    else
      @enrollment = current_user.buy_course(@course)
      redirect_to course_path(@course), notice: 'Enrollment was successfully created.'
    end
  end

  def update
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to enrollments_path, notice: 'Enrollment was successfully updated.' }
        format.json { render :show, status: :ok, location: @enrollment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @enrollment.destroy
    respond_to do |format|
      format.html { redirect_to enrollments_path, notice: 'Enrollment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_enrollment
      @enrollment = Enrollment.friendly.find(params[:id])
    end

    def set_course
      @course = Course.friendly.find(params[:course_id])
    end

    def enrollment_params
      params.require(:enrollment).permit(:rating, :review)
    end
end
