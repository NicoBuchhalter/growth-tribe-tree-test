class AddExternalIdToTreeNodes < ActiveRecord::Migration[6.0]
  def change
    add_column :tree_nodes, :external_id, :integer, unique: true
  end
end
