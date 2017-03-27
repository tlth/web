require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  allow_user_to :manage, Post

  describe "GET show" do
    it "render show " do
      post = create(:post)
      get :show, id: post.to_param
      expect(response).to render_template :show
    end
  end
end
