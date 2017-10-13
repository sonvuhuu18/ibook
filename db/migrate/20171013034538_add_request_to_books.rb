class AddRequestToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :pending, :boolean, default: true
  end
end
