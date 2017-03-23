require 'rails_helper'

RSpec.describe ImagesController, type: :controller do
  allow_user_to(:manage, Image)

  describe 'GET #new' do
    it 'sets new upload and renders' do
      get(:new)

      expect(response).to have_http_status(200)
      expect(assigns(:image)).to be_a_new(Image)
    end
  end

  describe 'GET #index' do
    it 'renders properly' do
      first = create(:image)
      second = create(:image)
      third = create(:image)

      get(:index)
      expect(response).to have_http_status(200)
      expect(assigns(:images).to_a).to eq([first, second, third])
    end
  end

  describe 'POST #create' do
    it 'valid parameters' do
      attributes = { image: test_file, tags: [] }

      expect do
        post(:create, image: attributes)
      end.to change(Image, :count).by(1)

      expect(response).to redirect_to(images_path)
      expect(flash[:notice]).to eq(I18n.t('images.create.success'))
    end

    it 'invalid parameters' do
      attributes = { image: nil, tags: [] }

      expect do
        post(:create, image: attributes)
      end.to change(Image, :count).by(0)

      expect(response).to render_template(:new)
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys upload' do
      image = create(:image)

      expect do
        delete(:destroy, id: image.to_param)
      end.to change(Image, :count).by(-1)

      expect(response).to redirect_to(images_path)
    end
  end

  def test_file
    Rack::Test::UploadedFile.new(File.open('spec/support/image.png'))
  end
end
