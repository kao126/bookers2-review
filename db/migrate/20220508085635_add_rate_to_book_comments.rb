class AddRateToBookComments < ActiveRecord::Migration[6.1]
  def change
    add_column :book_comments, :rate, :float
  end
end
