# == Schema Information
#
# Table name: enrollments
#
#  id         :bigint           not null, primary key
#  price      :integer
#  rating     :integer
#  review     :text
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_enrollments_on_course_id  (course_id)
#  index_enrollments_on_slug       (slug) UNIQUE
#  index_enrollments_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#  fk_rails_...  (user_id => users.id)
#
class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :user, :course, presence: true

  # 同じコースを2つ以上登録できない
  validates_uniqueness_of :user_id, scope: :course_id
  validates_uniqueness_of :course_id, scope: :user_id

  # 自分が作ったコースを登録できない
  validate :cant_subscribe_to_own_course


  # == friendly_id ==
  include FriendlyId
  friendly_id :course_url, use: :slugged

  def course_url
    course.course_url?
  end
  # == friendly_id ==


  def enrollment_course_title
    course.title
  end


  after_save do
    unless rating.nil? || rating.zero?
      course.update_rating
      
    end
  end

  after_destroy do
    course.update_rating
  end

  protected
  def cant_subscribe_to_own_course
    if self.new_record?
      if user_id == course.user_id
        errors.add(:base, "自分のコースは登録できません")
      end
    end
  end
end
