class AddAncestryToTreeNodes < ActiveRecord::Migration[6.0]
  def change
    add_column :tree_nodes, :ancestry, :string
    add_index :tree_nodes, :ancestry
  end
end
