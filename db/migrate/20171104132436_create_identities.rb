class CreateIdentities < ActiveRecord::Migration[5.1]
    def change
        create_table :identities do |t|
            t.references :user, foreign_key: true
            t.string :email
            t.string :name
            t.string :uid
            t.string :provider
            t.string :img
            t.string :img_big
            t.string :token
            t.text :other_info
            t.integer :sign_in_count, null: false, default: 0

            t.timestamps
        end
    end
end
