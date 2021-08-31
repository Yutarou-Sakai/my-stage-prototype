class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]

  def index
    @courses = Course.joins(:enrollments).where(enrollments: {user: current_user}).order(created_at: :desc).limit(3)
    @top_rated_courses = Course.all.order(average_rating: :desc).limit(3)
    @popular_courses = Course.select('courses.*', 'count(enrollments.id) AS enro')
                        .left_joins(:enrollments)
                        .group('courses.id')
                        .order('enro desc')
                        .limit(3)
  end
end
