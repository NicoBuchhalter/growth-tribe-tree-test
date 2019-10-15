class TreesController < ApplicationController

	def show
		render status: :ok, json: tree.serialize
	end

	def parent
		render status: :ok, json: { parent_ids: node.ancestor_ids }
	end

	def child
		render status: :ok, json: node.serialize
	end

	private

	def tree
		@_tree ||= TreeNode.roots.find_by_external_id(params[:tree_id])
		raise TreeNotFoundError if @_tree.nil?
		@_tree
	end

	def node
		@_node ||= tree.descendants.find_by_external_id(params[:id])
		raise TreeNodeNotFoundError if @_node.nil?
		@_node
	end
end