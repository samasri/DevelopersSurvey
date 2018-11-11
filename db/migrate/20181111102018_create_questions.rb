class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions, id: false, primary_key: :questionID do |t|
      t.integer :questionID
      t.string :questionText
      t.string :type

      t.timestamps
    end
  end
end
