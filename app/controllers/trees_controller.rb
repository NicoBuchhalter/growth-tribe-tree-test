class TreesController < ApplicationController

	def show
		tree = TreeNode.find_by_external_id(params[:id])
		return render json: tree.serialize, status: :ok if tree.present?
		render status: :bad_request, json: { error:  "Tree with id #{params[:id]} doesnt exist" }
	end

end