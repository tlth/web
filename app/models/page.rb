class Page < ActiveRecord::Base
  include LocaleContent

  validates(:title_sv, :title_en, presence: true, character: true)
  validates(:slug, presence: true,
                   uniqueness: { case_sensitive: false },
                   format: { with: /\A[a-z0-9-]+\z/ })
  validates :content, presence: true
  validate :slug_not_reserved_path

  translates :title
  translates :content

  has_one :nav_item, dependent: :destroy

  after_save { nav_item && nav_item.touch }

  has_and_belongs_to_many :contacts, class_name: 'User', touch: true
  has_many :contact_forms

  belongs_to :image

  scope :orphans, -> { includes(:nav_item).where( :nav_items => { :page_id => nil } ) }
  scope :with_image, -> { where.not(image: nil) }

  before_validation do
    if self.slug.blank?
      self.slug = self.title_en.parameterize
    end
  end

  def slug_not_reserved_path
    if reserved_paths.include? slug
      errors.add(:slug, I18n.t('errors.slug_reserved'))
    end
  end

  def to_param
    slug
  end

  def cover_image
    if image.present?
      image.cover_image
    end
  end

  private

  def reserved_paths
    match_initial_path_segment = Proc.new do |path|
      if match = %r{^\/([^\/\(:]+)}.match(path)
        match[1]
      end
    end

    routes = Rails.application.routes.routes
    paths = routes.collect {|r| r.path.spec.to_s }
    paths.collect {|path| match_initial_path_segment.call(path)}.compact.uniq
  end
end
