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
