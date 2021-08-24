# == Schema Information
#
# Table name: lessons
#
#  id         :bigint           not null, primary key
#  content    :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :bigint           not null
#
# Indexes
#
#  index_lessons_on_course_id  (course_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#
class Lesson < ApplicationRecord
  belongs_to :course

  validates :title, :content, :course, presence: true


  # == friendly_id ==
  include FriendlyId
  friendly_id :title, use: [:slugged, :history]
  
  def should_generate_new_friendly_id?
    title_changed?
  end
  # == friendly_id ==
end
