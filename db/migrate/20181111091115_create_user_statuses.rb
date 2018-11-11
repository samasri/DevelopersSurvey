class CreateUserStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :user_statuses do |t|
      t.string :SessionNb
      t.integer :PageNb
      t.integer :Thread1
      t.integer :Thread2
      t.integer :Thread3

      t.timestamps
    end
  end
end
