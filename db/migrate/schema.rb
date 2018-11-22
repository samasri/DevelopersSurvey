class Schema < ActiveRecord::Migration[5.2]
  def change
		create_table :tasks do |t|
      t.string :title
      t.text :note
      t.date :completed

      t.timestamps
    end
		
    create_table :responses do |t|
      t.integer :question_id
      t.string :user_id
      t.integer :sentence_id
      t.text :response
      t.timestamps
    end
		
		create_table :questions do |t|
      t.string :question_text
      t.string :qtype

      t.timestamps
    end
		
		create_table :sentences do |t|
      t.integer :thread_id
      t.string :answer_id
      t.text :sentence_text
      t.string :technique

      t.timestamps
    end
		
		add_foreign_key :responses, :questions
		# add_foreign_key :responses, :sentences
		add_index :responses, [:question_id, :user_id], :unique => true
  end
end
