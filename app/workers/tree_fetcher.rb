class TreeFetcher
  include Sidekiq::Worker
  include HTTParty

  sidekiq_options retry: false

  base_uri 'https://random-tree.herokuapp.com'

  def perform
  	random_tree = JSON.parse(self.class.get('/').body)

  	puts random_tree
  	root = TreeNode.create!(external_id: random_tree['id'])
  	create_children(root, random_tree['child'])
  end

  private 

  def create_children parent, children
  	children.each do |child|
  		tree_node = TreeNode.create!(external_id: child['id'], parent: parent)
  		create_children tree_node, child['child']
  	end
  end
end