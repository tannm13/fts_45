class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.belongs_to :subject, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.integer :status
      t.integer :duration
      t.integer :question_number
      t.integer :score

      t.timestamps null: false
    end
  end
end
