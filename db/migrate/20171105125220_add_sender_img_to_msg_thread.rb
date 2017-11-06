class AddSenderImgToMsgThread < ActiveRecord::Migration[5.1]
  def change
    add_column :msg_threads, :sender_img, :string
  end
end
