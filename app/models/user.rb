class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :loginable, polymorphic: true
  attr_accessible :email, :password, :password_confirmation, :loginable_type, :loginable_id
end
