class Image < ActiveRecord::Base
  include Filterable
  include Tagable

  before_validation(on: [:create, :update]) do
    taggings.each do |t|
      t.taggable = self
    end
  end
  validates :image, presence: true
  validates_property :format, of: :image, in: [:jpeg, :jpg, :png, :bmp, :gif], case_sensitive: false,
                   message: I18n.t('errors.messages.image_format'), if: :image_changed?

  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  has_many :posts
  has_many :pages

  scope :tag,    -> (tag_id) { joins(:tags).where( 'tags.id' => tag_id ) }
  scope :search, -> (search) {
    image_ids =  find_by_fuzzy_image_name(search).map(&:id)
    image_ids << find_by_fuzzy_title(search).map(&:id)
    image_ids << joins(:tags).where( "lower(tags.title) LIKE :search_param", search_param: search.downcase).map(&:id)
    where(id: image_ids.flatten)
  }

  fuzzily_searchable :image_name, :title

  dragonfly_accessor :image
  delegate :url, to: :image

  def title
    if self[:title].present?
      self[:title]
    elsif image_uid.present?
      image_uid.split('/').last
    end
  end

  def thumb_url
    image.thumb('160x160#').url
  end

  def cover_image
    image.thumb('1200x315#').url
  end
end
