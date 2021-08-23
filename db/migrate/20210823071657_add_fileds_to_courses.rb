class AddFiledsToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :short_descriotion, :text
    add_column :courses, :language, :string, default: 'Ruby', null: false
    add_column :courses, :level, :string, default: 'Beginner', null: false
    add_column :courses, :price, :integer, default: '0', null: false
    add_column :courses, :course_url, :string
  end
end
