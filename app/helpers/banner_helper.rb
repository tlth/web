module BannerHelper
  def banner_url(url, index: 0)
    content_tag(:div, class: "item #{index == 0 ? 'active' : ''}") do
      content_tag(:div, '',
                  class: 'fill',
                  style: "background-image: url('#{url}')")
    end
  end
end
