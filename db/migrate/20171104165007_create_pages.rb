class CreatePages < ActiveRecord::Migration[5.1]
    def change
        create_table :pages do |t|
            t.references :user, foreign_key: true

            t.string :uid
            t.string :title
            t.string :page_name
            t.text :access_token
            t.string :img
            t.integer :unread_msg_count
            t.integer :unseen_msg_count

            t.timestamps
        end
    end
end
