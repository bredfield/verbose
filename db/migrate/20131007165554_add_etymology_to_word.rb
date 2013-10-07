class AddEtymologyToWord < ActiveRecord::Migration
  def change
    add_column :words, :etymology, :string
  end
end
