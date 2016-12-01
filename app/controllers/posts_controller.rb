class PostsController < ApplicationController
  before_action :load_tags,   only: [:new, :edit, :archive]
  before_action :load_images, only: [:new, :edit]
  before_action :load_events, only: :index
  load_and_authorize_resource

  def index
    @posts.includes(:image)
      .order(created_at: :desc)
      .filter(filtering_params)
    @images = Image.where(id: Settings.cover_image_ids)

    respond_to do |format|
      format.html { @posts = @posts.order(updated_at: :desc).limit(10) }
      format.rss  { render layout: false } # index.rss.builder
    end
  end

  def show
    @post = Post.find(params[:id])
    if @post.image.present?
      img = @post.image.image.thumb('160x160#').url
      prepare_meta_tags(image: img,
                        twitter: { image: img },
                        og: { image: img })
    end

    @archive = params[:archive].present? || false
    # Used to determine if we should redirect back to archive or index from post
  end

  def new
  end

  def create
    @post = Post.create_with_tags(post_params, params[:post][:tags])

    if @post.new_record?
      load_tags
      load_images
      render 'new'
    else
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if @post.update_with_tags(post_params, params[:post][:tags])
      redirect_to @post
    else
      load_tags
      load_images
      render 'edit'
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path
  end

  def archive
    @archive = true # Used to determine where to redirect back from post
    @posts = @posts.includes(:image)
      .order(created_at: :desc)
      .filter(filtering_params)
      .page(params[:page]).per(6)
  end

  private

  def post_params
    params.require(:post).permit(
      :title,
      :content,
      :title_sv,
      :content_sv,
      :title_en,
      :content_en,
      :image_id,
      tag_ids: []
    )
  end

  def filtering_params
    params.slice(:search, :tag)
  end

  def load_tags
    @tags = Tag.all
  end

  def load_events
    @events = Event.upcoming.take(3)
  end

  def load_images
    @image = Image.new
    @images = Image.all
  end
end
