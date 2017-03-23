namespace :images do
  desc 'Will iterate through all images, moving the file from the file from Dragonfly (and Lunicores S3) to a Carrierwave field in each post (and TLTHs S3).'
  task(move_to_carrierwave: :environment) do
    images = Image.all
    failed = []
    images.each do |i|
      begin
        if i.file.present?
          failed << i.id
          next
        end
        i.remote_file_url = i.image.remote_url
        i.save!
      rescue => error
        failed << i.id
        puts "#{i.id} : #{error}"
      end
    end

    if failed.any?
      puts "These id's failed: "
      puts failed
    end
  end
end
