module CoursesHelper
  def enrollment_button(course)
    if current_user
      if course.user == current_user
        link_to "You created this course.", course_path(course), class: 'btn btn-outline-info m-3'
      elsif course.enrollments.where(user: current_user).any?
        "Now let's start learning!!"
      elsif course.price > 0
        link_to "Buy now", new_course_enrollment_path(course), class: 'btn btn-outline-danger'
      else
        link_to "Free! Start learning", new_course_enrollment_path(course), class: 'btn btn-outline-danger'
      end
    else
      link_to "Buy now", new_user_session_path, class: 'btn btn-outline-danger'
    end
  end

  def star_rating(rate)
    star = ''
    rate.times do
      star += '★'
    end
    return star
  end

  def my_course?
    if current_user && current_user.id == @course.user_id
      return true
    end
  end

  def admin_or_my_course?
    if current_user && current_user.has_role?(:admin) ||  current_user && current_user.id == @course.user_id
      return true
    end
  end

  def has_voice?(voice)
    if voice.rating.present? && voice.review.present?
      return true
    end
  end
end
