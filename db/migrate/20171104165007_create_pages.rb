class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.string :page_name
      t.text :access_token

      t.timestamps
    end
  end
end
