class CreateUserStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :user_statuses do |t|
      t.string :UserID
      t.integer :Status

      t.timestamps
    end
  end
end
