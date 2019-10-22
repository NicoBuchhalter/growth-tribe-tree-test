class TreeNode < ApplicationRecord

	validates :external_id, uniqueness: true

	scope :roots, -> { where(parent_id: nil) }

	belongs_to :parent, class_name: 'TreeNode', optional: true

	has_many :children, -> { includes(:children) }, class_name: 'TreeNode', foreign_key: :parent_id

	before_create :generate_ancestry

	before_destroy :orphan_children

	def ancestor_ids
		return [] if ancestry.nil?
		ancestry.split('/').map(&:to_i)
	end

	def descendants
		querying_ancestry = ancestry.present? ? ancestry : id
		self.class.where('ancestry LIKE :query OR ancestry = :id', id: id.to_s, query: "#{querying_ancestry}/%")
	end

	private

	def generate_ancestry
		return self.ancestry = nil if parent_id.nil?
		return self.ancestry = parent_id.to_s if parent.ancestry.nil?
		self.ancestry = "#{parent.ancestry}/#{parent_id}"
	end

	def orphan_children
		children.update_all ancestry: nil, parent_id: nil
	end
end
