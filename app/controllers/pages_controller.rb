class PagesController < ApplicationController
  before_action :load_resoures, only: [:new, :edit, :change_cover]
  load_resource find_by: :slug
  authorize_resource

  def index
    @orphan_pages = Page.orphans
    @nav_items = NavItem.orphans.order('position ASC').includes(:page, children: [:page])
  end

  def show
    @page = Page.find_by_slug(params[:id])
    @contact_forms = @page.contact_forms.includes(:pages, :users)

    if @page.try(:nav_item).try(:parent)
      @sidebar_nav_items = @page.nav_item.parent.children.includes(:page)
    end
  end

  def new
  end

  def create
    if @page.save
      redirect_to @page
    else
      load_resoures
      render 'new'
    end
  end

  def edit
  end

  def update
    if @page.update(page_params)
      redirect_to @page
    else
      load_resoures
      render 'edit'
    end
  end

  def destroy
    @page.destroy!
    redirect_to pages_path
  end

  def add_user
    @users = User.all
  end

  def add_user_update
    @user = User.find(params[:user_id])
    @page.contacts << @user

    if @page.save
      redirect_to @page
    else
      @users = User.all
      render 'add_user'
    end
  end

  def remove_user
    @user = User.find(params[:user_id])
    @page.contact_forms.where(user: @user).destroy_all
    @page.contacts.delete(@user)

    redirect_to @page
  end

  def change_cover
    @cover_image = @page.image
  end

  def delete_cover
    @page.update(image: nil)
    redirect_to @page
  end

  private

  def page_params
    params.require(:page).permit(:title_sv, :content_sv, :title_en, :content_en, :image_id, :slug)
  end

  def load_resoures
    @image = Image.new
    @images = Image.all
    @tags = Tag.all
  end
end
