module BannerHelper
  def banner_carousel_indicator(target, index)
    content_tag(:li, '', data: { target: "##{target}",
                                slide_to: index },
                         class: (index == 0 ? 'active' : ''))
  end

  def banner_page(page, index)
    content_tag(:div, class: "item #{index == 0 ? 'active' : ''}") do
      content = []
      content << content_tag(:div, '',
                             class: 'fill',
                             style: "background-image: url('#{page.cover_image}')")
      content << content_tag(:div, class: 'carousel-caption') do
        content_tag(:h3, link_to(page.title, page))
      end
      safe_join(content)
    end
  end

  def banner_url(url = image_url('cover.jpg'))
    content_tag(:div, class: "item active") do
      content_tag(:div, '',
                  class: 'fill',
                  style: "background-image: url('#{url}')")
    end
  end
end
