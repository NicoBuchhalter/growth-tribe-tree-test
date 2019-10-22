class TreeNodeSerializer < ActiveModel::Serializer
	attributes :id, :child

	def id
		object.external_id
	end

	def child
		object.included_children.map do |node|
			TreeNodeSerializer.new(node)
		end
	end
end