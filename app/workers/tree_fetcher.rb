class TreeFetcher
  include Sidekiq::Worker
  include HTTParty

  sidekiq_options retry: false

  base_uri Rails.application.credentials.tree_fetcher_url

  # Every requested tree comes with ID 1.
  # So the only way to fetch other tree without repeated IDs is to delete them all.
  def perform
    TreeNode.delete_all
  	random_tree = JSON.parse(self.class.get('/').body)
  	root = TreeNode.create!(external_id: random_tree['id'])
  	create_children(root, random_tree['child'])
    
  rescue ActiveRecord::RecordInvalid
    puts 'This tree has already been loaded'
  end

  private 

  def create_children parent, children
  	children.each do |child|
  		tree_node = TreeNode.create(external_id: child['id'], parent: parent)
  		create_children tree_node, child['child']
  	end
  end
end