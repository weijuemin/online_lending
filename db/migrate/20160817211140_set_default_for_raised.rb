class SetDefaultForRaised < ActiveRecord::Migration[5.0]
  def change
    change_column :borrowers, :raised, :integer, :default => 0
  end
end
