# Channel de discussion
class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String
  field :from, type: String
  field :provider, type: String
  field :channels, type: Array, default: []

  validates :content, presence: true

  before_create :add_channels_from_content

  protected

  def add_channels_from_content
    channels = Channel.all
    channels.each do |channel|
      channel.keywords.each do |keyword|
        if self.content.upcase.include? keyword.upcase
          self.channels.push channel.name
        end
      end
    end

    if self.channels == []
      channels.each do |channel|
        self.channels.push channel.name
      end
    end
  end
end
