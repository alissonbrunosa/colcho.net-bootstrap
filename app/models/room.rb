class Room < ActiveRecord::Base
  attr_accessible :description, :location, :title, :picture
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :reviewed_rooms, through: :reviews, source: :room
  mount_uploader :picture, PictureUploader
  
  scope :most_recent

  extend FriendlyId
  friendly_id :title do |config|
    config.use :slugged
    config.sequence_separator = "-"
  end
  
  # Validaões
  validates_presence_of :title, :location
  validates_length_of :description, minimum: 30, allow_blank: false
  validates_presence_of :slug
  # --
  
  # Escopos
  def self.most_recent
		order('created_at DESC')
  end
  # --
  
  def full_name
  	"#{title}, #{location}"
  end

  def self.search query
    if query.present?
      where(['location ILIKE :query OR title ILIKE :query OR description ILIKE :query', :query => "%#{query}%"]).most_recent
    else
      scoped.most_recent
    end
  end

  def should_generate_new_friendly_id?
    new_record?
  end
end
