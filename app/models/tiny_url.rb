class TinyUrl < ApplicationRecord
  UNIQUE_SLUG_LENGTH = 7
  LETTERS = [*'0'..'9', *'a'..'z', *'A'..'Z']
  SHORT_URL = 'http://short.est'

  validates :long_url, :slug, presence: true
  validate :url_format

  before_validation :set_slug

  def find_duplicate
    TinyUrl.find_by long_url: long_url
  end

  def short_url
    "#{SHORT_URL}/#{slug}"
  end

  private

  def url_format
    errors.add(:long_url, 'is invalid') unless  UriService.valid?(long_url)
  end

  def set_slug(count = 0)
    count += 1
    return self.slug = nil if count == 5

    random_slug = LETTERS.sample(UNIQUE_SLUG_LENGTH).join
    set_slug(count) if TinyUrl.exists?(slug: random_slug)
    self.slug = random_slug
  end
end
