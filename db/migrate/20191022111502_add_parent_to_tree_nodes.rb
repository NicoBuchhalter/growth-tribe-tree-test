class AddParentToTreeNodes < ActiveRecord::Migration[6.0]
  def change
    add_reference :tree_nodes, :parent, foreign_key: { to_table: :tree_nodes }
  end
end
