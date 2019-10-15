class CreateTreeNodes < ActiveRecord::Migration[6.0]
  def change
    create_table :tree_nodes do |t|

      t.timestamps
    end
  end
end
