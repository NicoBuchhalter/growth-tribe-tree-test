require 'rails_helper'

describe TreeNode, type: :model do
	it { is_expected.to validate_uniqueness_of :external_id }

	describe 'when serializing' do 
		let!(:root_tree_node) { create(:tree_node, external_id: 4) }
		let!(:tree_node_child_1) { create(:tree_node, parent: root_tree_node, external_id: 1) }
		let!(:tree_node_child_2) { create(:tree_node, parent: root_tree_node, external_id: 2) }
		let!(:tree_node_child_3) { create(:tree_node, parent: tree_node_child_2, external_id: 3) }

		it 'generates an object with the external_ids as ids' do 
			expected_serialization = {
				id: root_tree_node.external_id, child: [
					{ id: tree_node_child_1.external_id, child: [] },
					{ id:  tree_node_child_2.external_id, child: [
						{ id: tree_node_child_3.external_id, child: [] }
					]} 
				]
			}
			expect(root_tree_node.serialize).to eq expected_serialization
		end
	end
end	