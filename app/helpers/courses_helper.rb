module CoursesHelper
  def enrollment_button(course)
    if current_user
      if course.user == current_user
        link_to "You created this course.", course_path(course), class: 'btn btn-outline-info m-3'
      elsif course.enrollments.where(user: current_user).any?
        link_to "Now let's start learning!!", course_path(course)
      elsif course.price > 0
        link_to "Buy now", new_course_enrollment_path(course), class: 'btn btn-outline-danger'
      else
        link_to "Free! Start learning", new_course_enrollment_path(course), class: 'btn btn-outline-danger'
      end
    else
      link_to "Buy now", new_user_session_path, class: 'btn btn-outline-danger'
    end
  end
end
