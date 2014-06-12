class User < ActiveRecord::Base
  authenticates_with_sorcery!
  authenticates_with_sorcery! do |config|
  	config.authentications_class = Authentication
  end

  has_many :wallpapers

  has_many :authentications, :dependent=>:destroy
  # validates :email, uniqueness: true
end
