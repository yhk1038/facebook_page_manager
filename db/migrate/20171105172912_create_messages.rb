class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :msg_thread, foreign_key: true
      t.string :uid
      t.string :created_time
      t.string :sender_name
      t.string :sender_uid
      t.text :content
      t.text :attachment

      t.timestamps
    end
  end
end
