class ApplicationController < ActionController::API

	class TreeNotFoundError < StandardError; end
  class TreeNodeNotFoundError < StandardError; end

  rescue_from TreeNotFoundError, with: :render_tree_not_found
  rescue_from TreeNodeNotFoundError, with: :render_tree_node_not_found

  private

	def render_tree_not_found
		render status: :bad_request, json: { error:  "Tree with id #{params[:tree_id]} doesnt exist" }
	end

	def render_tree_node_not_found
		render status: :bad_request, 
					 json: { error:  "Node with id #{params[:id]} in Tree #{params[:tree_id]} doesnt exist" }
	end
end
