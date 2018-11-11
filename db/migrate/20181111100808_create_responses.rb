class CreateResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :responses, id: false, primary_key: [:questionID,:userID] do |t|
      t.integer :questionID
      t.string :userID
      t.integer :sentenceID
      t.text :response
			add_foreign_key :responses, :user_statuses, column: :userID, primary_key: :sessionNb
			add_foreign_key :responses, :questions, column: :questionID, primary_key: :questionID
			add_foreign_key :responses, :sentences, column: :sentenceID, primary_key: :sentenceID

      t.timestamps
    end
  end
end
