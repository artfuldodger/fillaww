namespace :images do
  desc "Import latest images"
  task import: :environment do
    Import.import!
  end
end
