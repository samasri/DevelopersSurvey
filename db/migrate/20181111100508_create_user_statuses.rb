class CreateUserStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :user_statuses, id: false, primary_key: :sessionNb do |t|
      t.string :sessionNb
      t.integer :pageNb
      t.integer :thread1
      t.integer :thread2
      t.integer :thread3

      t.timestamps
    end
  end
end
