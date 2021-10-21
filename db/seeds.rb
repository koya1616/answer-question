require 'faker'

Faker::Config.locale = :ja

# Category
subjects = %w[英語 プログラミング 就活 中学受験 高校受験 大学受験 恋愛 仕事]
subjects.each do |subject|
  Category.create(
    name: subject
    )
end


10.times do |n|
  name = Faker::Name.name
  email = "email-#{n + 1}@email.com"
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password
  )
end

