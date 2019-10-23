require 'rails_helper'

describe TreeNode, type: :model do
	it { is_expected.to validate_uniqueness_of :external_id }

	let!(:root_node) { create(:tree_node, external_id: 1) }
	let!(:child_node) { create(:tree_node, external_id: 2, parent: root_node) }
	let!(:grand_child_node) {create(:tree_node, external_id: 3, parent: child_node) }

	describe '#generate_ancestry' do 
		context 'when no parent' do 
			it 'sets ancestry to nil' do 
				expect(root_node.ancestry).to be_nil
			end
		end

		context 'when parent is root' do 
			it 'sets ancestry to parent id' do 
				expect(child_node.ancestry).to eq root_node.id.to_s
			end
		end

		context 'when parent is not root' do 
			it 'sets ancestry to ancestry formula' do
				expect(grand_child_node.ancestry).to eq "#{root_node.id}/#{child_node.id}"
			end
		end
	end

	describe '#orphan_children' do 
		context 'when destroying a tree node' do 
			before do 
				root_node.destroy!
			end

			it 'sets childrens parent_id to nil' do
				expect(child_node.reload.parent_id).to be_nil
			end

			it 'sets childrens ancestry to nil' do
				expect(child_node.reload.ancestry).to be_nil
			end

			it 'updates descendants ancestry value' do 
				expect(grand_child_node.reload.ancestry).to eq child_node.id.to_s
			end
		end
	end

	describe '#update_children_ancestry' do
		let!(:root_node_2) { create(:tree_node, external_id: 4) }
		let!(:grand_grand_child_node) { create(:tree_node, external_id: 5, parent: grand_child_node) }

		context 'when updating ancestry' do 
			before do 
				child_node.reload.update!(parent_id: root_node_2.id)
			end

			it 'updates every descendant ancestry too' do
				expect(grand_grand_child_node.reload.ancestry).to eq(
					"#{root_node_2.id}/#{child_node.id}/#{grand_child_node.id}"
				)
			end
		end

		context 'when current node is root' do 
			before do 
				child_node.reload.update!(parent_id: nil)
			end

			it 'updates ancestry without initial /' do 
				expect(grand_child_node.reload.ancestry).to eq child_node.id.to_s
			end
		end
	end

	describe '#ancestor_ids' do 
		context 'when no ancestry' do 
			it 'returns empty array' do 
				expect(root_node.ancestor_ids).to eq []
			end
		end

		context 'when ancestry' do 
			it 'returns array of ancestors' do 
				expect(grand_child_node.ancestor_ids).to eq [root_node.id, child_node.id]
			end
		end
	end

	describe '#descendants' do
		let!(:grand_child_node_2) { create(:tree_node, external_id: 4, parent: child_node) }
		let!(:root_node_2) { create(:tree_node, external_id: 5) }
		let!(:child_node_2) { create(:tree_node, external_id: 6, parent: root_node) }

		context 'when no ancestry' do 
			it 'returns all of the descendants' do 
				expect(root_node.descendants).to contain_exactly(child_node, child_node_2, grand_child_node, grand_child_node_2)
			end
		end

		context 'when ancestry' do 
			it 'returns all of descendants' do 
				expect(child_node.descendants).to contain_exactly(grand_child_node, grand_child_node_2)
			end
		end
	end
end	