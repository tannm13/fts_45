desc "Task description"
task delete_faker_exam: :environment do
  Exam.fake.start.destroy_all
end
