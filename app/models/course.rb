# == Schema Information
#
# Table name: courses
#
#  id          :bigint           not null, primary key
#  description :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Course < ApplicationRecord
  validate :title, presence: true
  validate :description, presence: true, length: { :minimum => 5 }

  def to_s
    title
  end
end
