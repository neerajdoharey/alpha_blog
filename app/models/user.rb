class User < ApplicationRecord

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  
  VALID_EMAIL =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: {case_sensetive: false},
  format: {with: VALID_EMAIL}

end
