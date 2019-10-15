class TreeNodeSerializer < ActiveModel::Serializer
	attributes :id, :children

	def id
		object.external_id
	end

	def children
		scope[:children]
	end
end