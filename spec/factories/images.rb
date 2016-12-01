FactoryGirl.define do
  factory :image do
    image Rack::Test::UploadedFile.new(File.open('spec/support/cover.jpg'))
  end
end
