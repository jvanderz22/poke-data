class AddColumnsToBattle < ActiveRecord::Migration
  def change
    add_column :battles, :showdown, :boolean
    add_column :battles, :opponent_rating, :integer
  end
end
