class Post < ActiveRecord::Base
  include Filterable
  include Tagable
  include FuzzySearchTitles
  include LocaleContent

  belongs_to :image

  validates :title_sv, presence: true
  validates :title_en, presence: true
  validates :content, presence: true

  before_validation(on: [:create, :update]) do
    taggings.each do |t|
      t.taggable = self
    end
  end

  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings


  translates :title, :content
  fuzzily_searchable :title_en, :title_sv

  scope :tag, -> (tag_id) { joins(:tags).where( 'tags.id' => tag_id ) }

  def first_paragraph
    match = content.match(/<p>([^<]+)<\/p>/)
    match.present? ? match[1] : ActionController::Base.helpers.strip_tags(content).slice(0,140)
  end

  def to_param
    [id, '-' ,title_en.parameterize].join
  end

  def image_thumb
    image.thumb_url if image.present?
  end
end
