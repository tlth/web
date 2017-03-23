class ImagesController < ApplicationController
  before_action :load_tags, only: [:index, :new, :edit]
  load_and_authorize_resource

  def index
    @images = @images.filter(filtering_params)
                     .page(params[:page]).per(20)
  end

  def new; end

  def create
    @image = Image.create_with_tags(image_params, params[:image][:tags])

    respond_to do |format|
      if @image.new_record?
        load_tags
        format.html { render :new }
        format.js { render json: @image.errors, status: :unprocessable_entity }
      else
        format.html { redirect_to images_path, notice: t('.success') }
        format.js { render action: 'upload_success' }
      end
    end
  end

  def edit; end

  def update
    if @image.update_with_tags(image_params, image_tag_params)
      redirect_to images_path
    else
      load_tags
      render 'edit'
    end
  end

  def destroy
    @image.destroy!

    redirect_to images_path
  end

  # Used by image modal
  def search
    @images = @images.filter(filtering_params)
  end

  private

  def image_params
    params.require(:image).permit(:image, :title)
  end

  def image_tag_params
    params.require(:image).permit(:tags)
  end

  def filtering_params
    params.slice(:search, :tag)
  end

  def load_tags
    @tags = Tag.all
  end
end
