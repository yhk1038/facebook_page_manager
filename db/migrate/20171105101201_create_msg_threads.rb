class CreateMsgThreads < ActiveRecord::Migration[5.1]
  def change
    create_table :msg_threads do |t|
      t.references :page, foreign_key: true
      t.string :uid
      t.string :sender_name
      t.string :sender_uid
      t.string :link
      t.string :msg_count
      t.string :unread_count
      t.string :updated_time
      t.text :other_info

      t.timestamps
    end
  end
end
