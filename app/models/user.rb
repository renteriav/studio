# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  loginable_type         :string(255)
#  loginable_id           :integer
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :loginable, polymorphic: true
  attr_accessible :email, :password, :password_confirmation, :loginable_type, :loginable_id, :remember_me
  
  def to_public_json(options = {})
    to_public_hash.to_json
  end
  
  def to_public_hash(options = {})
    user_hash = self.attributes
    user_hash.delete('encrypted_password')
    user_hash.delete('last_sign_in_ip')
    user_hash.delete('current_sign_in_ip')
    user_hash.delete('reset_password_token')
    user_hash.delete('created_at')
    user_hash.delete('current_sign_in_at')
    user_hash.delete('remember_created_at')
    user_hash.delete('reset_password_sent_at')
    user_hash.delete('sign_in_count')
    user_hash.delete('admin')
    user_hash.delete('github_access_token')
    user_hash
  end
end
