# == Schema Information
#
# Table name: enrollments
#
#  id         :bigint           not null, primary key
#  price      :integer
#  rating     :integer
#  review     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_enrollments_on_course_id  (course_id)
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
  protected
  def cant_subscribe_to_own_course
    if self.new_record?
      if user_id == course.user_id
        errors.add(:base, "自分のコースは登録できません")
      end
    end
  end
end
