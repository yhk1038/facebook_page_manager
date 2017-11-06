class AddColumsToPage < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :next_token, :string
    add_column :pages, :prev_token, :string
    add_column :pages, :paging_token, :string
  end
end
