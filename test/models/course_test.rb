# == Schema Information
#
# Table name: courses
#
#  id                :bigint           not null, primary key
#  course_url        :string
#  description       :text
#  language          :string           default("Ruby"), not null
#  level             :string           default("Beginner"), not null
#  price             :integer          default(0), not null
#  short_descriotion :text
#  slug              :string
#  title             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_courses_on_slug     (slug) UNIQUE
#  index_courses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
