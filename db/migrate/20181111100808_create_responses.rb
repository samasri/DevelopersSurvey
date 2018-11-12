class CreateResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :responses do |t|
      t.integer :question_id
      t.string :user_id
      t.integer :sentence_id
      t.text :response
			add_foreign_key :responses, :questions
			add_foreign_key :responses, :sentences

      t.timestamps
    end
  end
end
