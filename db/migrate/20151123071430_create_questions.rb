class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :name
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :subject, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
