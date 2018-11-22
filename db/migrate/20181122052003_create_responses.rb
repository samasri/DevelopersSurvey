class CreateResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :responses do |t|
      t.references :question
      t.string :user_id
      t.references :sentence
      t.string :response

      t.timestamps
    end
		
		add_foreign_key :responses, :questions
		add_foreign_key :responses, :sentences
		add_index :responses, [:question_id, :user_id, :sentence_id], :unique => true
  end
end
