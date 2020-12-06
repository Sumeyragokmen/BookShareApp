class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
#  validates_length_of :username,
#    :within => 5..50,
#    :too_short => 'too short username, min 5 characters',
#    :too_long => 'too long username, max 50 characters',
#    :presence => true

before_create :set_username

has_many :books
has_many :comments
has_many :trades

	def login
     @login || self.email || self.username
    end

  private
    def set_username
      self.username = self.email.split("@").first
    end

    def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup

    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
    end

end
