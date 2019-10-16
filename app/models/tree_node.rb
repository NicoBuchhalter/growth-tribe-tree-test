class TreeNode < ApplicationRecord
	has_ancestry

	validates :external_id, uniqueness: true

	def serialize
		subtree.arrange_serializable do |parent, children|
			{ id: parent.external_id, child: children }			
		end.first		
	end
end
