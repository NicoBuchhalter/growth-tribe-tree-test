require 'rails_helper'

describe TreeFetcher do

  it 'creates a new tree from URL', :vcr do
    # The number 76 of TreeNode count change is based on the casette
    expect { TreeFetcher.new.perform }.to change { TreeNode.count }.by(76)
  end
end