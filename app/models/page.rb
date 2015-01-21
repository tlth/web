class Page < ActiveRecord::Base
  include HtmlHelper

  validates :title_sv, presence: true, character: true
  validates :title_en, presence: true, character: true
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  validates :content, presence: true
  validate :slug_not_reserved_path

  translates :title
  translates :content

  has_one :nav_item, dependent: :destroy
  has_and_belongs_to_many :contacts, class_name: 'User'
  has_many :contact_forms

  belongs_to :image

  scope :orphans, -> { includes(:nav_item).where( :nav_items => { :page_id => nil } ) }

  before_validation do
    self.slug = self.title_en.parameterize
  end

  def slug_not_reserved_path
    if reserved_paths.include? slug
      errors.add(:slug, I18n.t('errors.slug_reserved'))
    end
  end

  def to_param
    slug
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
