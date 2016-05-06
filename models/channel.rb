# Channel de discussion
class Channel
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :keywords, type: Array, default: []

  validates :name, uniqueness: true

  validates :name, presence: true

  before_create :add_default_keyword

  protected

  def add_default_keyword
    self.keywords.push self.name
  end
end
