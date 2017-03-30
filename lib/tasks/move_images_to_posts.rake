namespace :images do
  desc 'Will iterate through all posts, moving the file from the Image (and Lunicores S3) to a field in each post (and TLTHs S3).'
  task(move_to_post: :environment) do
    posts = Post.where.not(image_id: nil)
    failed = []
    posts.each do |p|
      begin
        if p.picture.file.present?
          failed << p.id
          next
        end
        p.remote_picture_url = p.image.image.remote_url
        p.save!
      rescue => error
        failed << p.id
        puts "#{p.id} : #{error}"
      end
    end

    if failed.any?
      puts "These id's failed: "
      puts failed
    end
  end
end
