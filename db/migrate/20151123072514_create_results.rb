class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.belongs_to :exam, index: true, foreign_key: true
      t.belongs_to :question, index: true, foreign_key: true
      t.boolean :is_correct
      t.string :answer_content

      t.timestamps null: false
    end
  end
end
