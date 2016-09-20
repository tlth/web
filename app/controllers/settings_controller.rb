class SettingsController < ApplicationController
  load_and_authorize_resource class: "Settings"

  def edit
    @cover_images = Image.where(id: Settings.cover_image_ids)
    @images = Image.all
    @tags = Tag.all
  end

  def update
    @settings[:index_leads] = params[:settings][:index_leads] if params[:settings][:index_leads]

    if params[:settings][:cover_image_ids]
      @settings[:cover_image_ids] = params[:settings][:cover_image_ids]
                                  .reject(&:blank?)
                                  .map(&:to_i)
    end

    if params[:settings][:sidebar_links]
      @settings[:sidebar_links] = params[:settings][:sidebar_links].map { |key, value| value }
    end

    redirect_to(settings_path, notice: "Inställningar uppdaterades")
  end
end
