User.create!(name:  "Admin",
             email: "admin@framgia.com",
             password:              "12345678",
             password_confirmation: "12345678",
             role: 0)

5.times do |n|
  name  = Faker::Name.name
  email = "user-#{n+1}@framgia.com"
  password = "aaaaaaaa"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

2.times do
  name = Faker::Lorem.sentence(1)
  Subject.create!(name: name)
end

Subject.all.each do |subject|
  10.times do
    name = Faker::Lorem.sentences(1)
    User.find(1).questions.create!(name: name, subject_id: subject.id, status: 1)
  end
end

Question.all.each do |question|
    c1 = Faker::Lorem.sentences(1)
    question.answers.create!(content: c1)
    c2 = Faker::Lorem.sentences(1)
    question.answers.create!(content: c2, is_correct: true)
end
