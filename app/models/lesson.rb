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
class Lesson < ApplicationRecord
  belongs_to :course
  has_rich_text :content

  validates :title, :content, :course, presence: true
  validates :title, uniqueness: { scope: :course_id }

  # == friendly_id ==
  include FriendlyId
  friendly_id :title, use: [:slugged, :history]

  def should_generate_new_friendly_id?
    title_changed?
  end
  # == friendly_id ==

  # == public_activity ==
  include PublicActivity::Model
  tracked owner: proc { |controller, model| controller.current_user }

  def to_s
    title
  end
  # == public_activity ==
end
