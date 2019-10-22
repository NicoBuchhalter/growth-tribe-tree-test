require 'rails_helper'

describe TreeNode, type: :model do
	it { is_expected.to validate_uniqueness_of :external_id }

	describe '#generate_ancestry' do 

		context 'when no parent' do 
			it 'sets ancestry to nil' do 
				root_node = TreeNode.create(external_id: 1)
				expect(root_node.ancestry).to be_nil
			end
		end

		context 'when parent is root' do 
			it 'sets ancestry to parent id' do 
				root_node = TreeNode.create(external_id: 1)
				child_node = TreeNode.create(external_id: 2, parent: root_node)
				expect(child_node.ancestry).to eq root_node.id.to_s
			end
		end

		context 'when parent is not root' do 
			it 'sets ancestry to ancestry formula' do 
				root_node = TreeNode.create(external_id: 1)
				child_node = TreeNode.create(external_id: 2, parent: root_node)
				grand_child_node = TreeNode.create(external_id: 3, parent: child_node)
				expect(grand_child_node.ancestry).to eq "#{root_node.id}/#{child_node.id}"
			end
		end
	end

	describe '#orphan_children' do 
		context 'when destroying a tree node' do 
			it 'sets childrens parent_id and ancestry to nil' do
				root_node = TreeNode.create(external_id: 1)
				child_node = TreeNode.create(external_id: 2, parent: root_node)
				root_node.destroy!
				expect(child_node.reload.parent_id).to be_nil
				expect(child_node.reload.ancestry).to be_nil
			end
		end
	end

	describe '#update_children_ancestry' do 
		context 'when updating ancestry' do 
			it 'updates every descendant ancestry too' do
				root_node = TreeNode.create(external_id: 1)
				child_node = TreeNode.create(external_id: 2, parent: root_node)
				grand_child_node = TreeNode.create(external_id: 3, parent: child_node)
				grand_grand_child_node = TreeNode.create(external_id: 5, parent: grand_child_node)
				root_node_2 = TreeNode.create(external_id: 4)
				child_node.reload.update! parent_id: root_node_2.id
				expect(grand_grand_child_node.reload.ancestry).to eq "#{root_node_2.id}/#{child_node.id}/#{grand_child_node.id}"
			end
		end
	end

	describe '#ancestor_ids' do 
		context 'when no ancestry' do 
			it 'returns empty array' do 
				root_node = TreeNode.create(external_id: 1)
				expect(root_node.ancestor_ids).to eq []
			end
		end

		context 'when ancestry' do 
			it 'returns array of ancestors' do 
				root_node = TreeNode.create(external_id: 1)
				child_node = TreeNode.create(external_id: 2, parent: root_node)
				grand_child_node = TreeNode.create(external_id: 3, parent: child_node)
				expect(grand_child_node.ancestor_ids).to eq [root_node.id, child_node.id]
			end
		end
	end

	describe '#descendants' do 
		context 'when no ancestry' do 
			it 'returns all of the descendants' do 
				root_node = TreeNode.create(external_id: 1)
				child_node = TreeNode.create(external_id: 2, parent: root_node)
				child_node_2 = TreeNode.create(external_id: 3, parent: root_node)
				grand_child_node = TreeNode.create(external_id: 4, parent: child_node)
				grand_child_node_2 = TreeNode.create(external_id: 5, parent: child_node)
				TreeNode.create(external_id: 6)
				expect(root_node.descendants).to contain_exactly(child_node, child_node_2, grand_child_node, grand_child_node_2)
			end
		end

		context 'when ancestry' do 
			it 'returns all of descendants' do 
				root_node = TreeNode.create(external_id: 1)
				child_node = TreeNode.create(external_id: 2, parent: root_node)
				TreeNode.create(external_id: 3, parent: root_node)
				grand_child_node = TreeNode.create(external_id: 4, parent: child_node)
				grand_child_node_2 = TreeNode.create(external_id: 5, parent: child_node)
				TreeNode.create(external_id: 6)
				expect(child_node.descendants).to contain_exactly(grand_child_node, grand_child_node_2)
			end
		end
	end
end	