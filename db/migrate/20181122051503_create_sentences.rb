class CreateSentences < ActiveRecord::Migration[5.2]
  def change
    create_table :sentences do |t|
      t.integer :thread_id
      t.string :answer_id
      t.text :sentence_text
      t.string :technique

      t.timestamps
    end
  end
end
