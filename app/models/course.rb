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
class Course < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true, length: { :minimum => 5 }
  validates :course_url, uniqueness: true

  has_rich_text :description

  include FriendlyId
  friendly_id :course_url, use: [:slugged, :history]

  belongs_to :user

  def to_s
    title
  end

  def should_generate_new_friendly_id?
    title_changed?
  end
end
