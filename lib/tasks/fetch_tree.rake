namespace :fetch_tree do
  desc "This task fetchs an entire tree"

  task now: :environment do
    TreeFetcher.new.perform
  end


  task async: :environment do
  	TreeFetcher.perform_async
  end
end