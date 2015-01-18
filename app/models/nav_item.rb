class NavItem < ActiveRecord::Base
  belongs_to :page
  belongs_to :parent, class_name: "NavItem"
  has_many :children, -> { order("position ASC") }, class_name: "NavItem", foreign_key: "parent_id"

  scope :orphans, -> { where(parent: nil) }
  scope :no_page, -> { where(page: nil) }

  validate :has_title_or_page
  before_destroy :set_childrens_parent

  translates :title
  acts_as_list scope: :parent, class_name: "NavItem"

  enum nav_item_type: [:menu, :page, :link]


  def self.update_order!(nav_items)
    update_order(nav_items)
  end

  def item_title
    nav_item_type == 'page' ? page.title : title
  end

  def link
    nav_item_type == 'page' ? page.slug : self[:link]
  end

  def children?
    children.any?
  end

  def has_title_or_page
    if nav_item_type != 'page' && title.blank?
      errors.add(:title, I18n.t('.should_have_page_or_title'))
    end
  end

  private

  def self.update_order(nav_items, parent_id = nil)
    nav_items.each_with_index do |child_element, index|
      NavItem.update(child_element['id'], parent_id: parent_id, position: index + 1)
      if child_element['children']
        update_order(child_element['children'], child_element['id'])
      end
    end
  end

  def set_childrens_parent
    children.update_all(parent_id: nil)
  end
end
