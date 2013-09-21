class User < ActiveRecord::Base
  attr_accessible :bio, :email, :full_name, :location, :password, :password_confirmation, :photo
  has_many :rooms, dependent: :destroy
  has_many :reviews, dependent: :destroy
  mount_uploader :photo, PictureUploader
  
  has_secure_password
  
  # Scopos
  scope :confirmed, where('confirmed_at IS NOT NULL')
  # --
  
  def self.authenticate(email, password)
  	confirmed.find_by_email(email).try(:authenticate, password)
  end

  # -- Validações
  validates_presence_of :bio, :email, :full_name, :location
  validates_length_of :bio, minimum: 30 ,allow_blank: false
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates_uniqueness_of :email
  # -- 
  
  
  # Callbacks
  before_create :generate_token
  #--
  
  
  
  def generate_token
  	self.confirmation_token =  SecureRandom.urlsafe_base64 
  end
  
  
  def confirm!
  	return if confirmed?
  	
  	self.confirmed_at = Time.now
  	self.confirmation_token = ''
  	save!
  end
  
  def confirmed?
  	self.confirmed_at.present?
  end
end
