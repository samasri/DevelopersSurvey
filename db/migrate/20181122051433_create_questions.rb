class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.text :question_text
      t.string :qtype
			t.boolean :mandatory
			t.string :responseType

      t.timestamps
    end
  end
end
