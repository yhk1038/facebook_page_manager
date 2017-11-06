class AddShareToMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :share, :text
  end
end
