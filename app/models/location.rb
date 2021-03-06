class Location < ApplicationRecord
  belongs_to :owner, class_name: :User, foreign_key: :user_id
  has_many :spaces
  has_many :active_spaces, -> { where(space_active: 1) }, class_name: :Space
  has_many :reservations, through: :spaces
  has_many :ratings, through: :reservations
  has_one :chat_room

  STATES = %w(AL AK AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY
              LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND
              OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY)

  validates :owner, :street_address, :city, :state, :zip, presence: true
  validates :state, inclusion: { in: STATES, message: "%{value} is not a valid state" }
  validate :valid_zip

  def valid_zip
    unless self.zip =~ /^\d{5}$/
      errors.add :zip, "code is not valid"
    end
  end

  # GeoCoder
  geocoded_by :full_street_address
  after_validation :geocode

  def full_street_address
    "#{self.street_address}, #{self.city}, #{self.state} #{self.zip}"
  end

  def average_rating
    ratings = self.ratings.pluck(:score)
    ratings.reduce(:+) ? (ratings.reduce(:+)/ratings.size.to_f).round(1) : 0
  end

end
