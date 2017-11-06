class AddPagingTokenToMsgThread < ActiveRecord::Migration[5.1]
  def change
    add_column :msg_threads, :paging_token, :string
  end
end
