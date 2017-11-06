class AddColumsToMsgThreads < ActiveRecord::Migration[5.1]
  def change
    add_column :msg_threads, :next_token, :string
    add_column :msg_threads, :prev_token, :string
  end
end
