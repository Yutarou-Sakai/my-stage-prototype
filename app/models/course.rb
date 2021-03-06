# == Schema Information
#
# Table name: courses
#
#  id                :bigint           not null, primary key
#  average_rating    :float            default(0.0), not null
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

  belongs_to :user
  has_many :lessons,  dependent: :destroy
  has_many :enrollments,  dependent: :destroy
  has_rich_text :description

  # == friendly_id ==
  include FriendlyId
  friendly_id :course_url, use: :slugged

  def course_url?
    course_url
  end
  # == friendly_id ==

  # == public_activity ==
  include PublicActivity::Model
  tracked owner: proc { |controller, model| controller.current_user }

  def to_s
    title
  end
  # == public_activity ==



  LEVELS = [:'Beginner', :'Standard', :'Pro']
  def self.levels
    LEVELS.map { |level| [level, level] }
  end

  def bought_course(user)
    self.enrollments.where(user_id: [user_id], course_id: [self.id]).empty?
  end

  def update_rating
    if enrollments.any? && enrollments.where.not(rating: nil).any?
      update_column :average_rating, (enrollments.average(:rating).round(2).to_f)
    else
      update_column :average_rating, (0)
    end
  end
end
