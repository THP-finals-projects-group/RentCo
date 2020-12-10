class AddCalculConfirmedToCases < ActiveRecord::Migration[5.2]
  def change
    add_column :cases, :calcul_confirmed, :boolean
  end
end
