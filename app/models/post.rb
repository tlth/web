class Post < ActiveRecord::Base
  include HtmlHelper

  validates :title, presence: true
  validates :content, presence: true

  before_validation(on: [:create, :update]) do
    taggings.each do |t|
      t.taggable = self
    end
  end
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  belongs_to :image

  scope :with_tag, -> (tag) { joins(:tags).where( 'tags.id' => tag.id ) }
  scope :search, -> (search) {
    where([
    "lower(title_sv) LIKE ? OR
     lower(title_en) LIKE ? OR
     lower(content_sv) LIKE ? OR
     lower(content_sv) LIKE ?",
    "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"
    ])
  }

  translates :title, :content

  def content_html
    process_into_html self.content
  end
end
