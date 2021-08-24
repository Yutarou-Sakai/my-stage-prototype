# == Schema Information
#
# Table name: lessons
#
#  id         :bigint           not null, primary key
#  content    :text
#  slug       :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :bigint           not null
#
# Indexes
#
#  index_lessons_on_course_id  (course_id)
#  index_lessons_on_slug       (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#
require 'test_helper'

class LessonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
