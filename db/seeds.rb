PublicActivity.enabled = false

User.create!(email: 'admin@adimn.com', password: '123456', password_confirmation: '123456')
User.create!(email: 'test@test.com', password: '123456', password_confirmation: '123456')

10.times do
  Course.create!([{
    title: Faker::Educator.course_name,
    description: Faker::TvShows::GameOfThrones.quote,
    short_descriotion: Faker::Quote.famous_last_words,
    language: Faker::ProgrammingLanguage.name,
    course_url: Faker::Name.unique.name,
    user_id: User.first.id
  }])
end

PublicActivity.enabled = true
