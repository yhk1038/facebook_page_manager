class AddSenderImgToMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :sender_img, :string
  end
end
