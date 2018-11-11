class CreateSentences < ActiveRecord::Migration[5.2]
  def change
    create_table :sentences, id: false, primary_key: :sentenceID do |t|
      t.integer :sentenceID
      t.integer :threadID
      t.string :answerID
      t.text :sentenceText
      t.string :technique

      t.timestamps
    end
  end
end
