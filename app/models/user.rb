# == Schema Information
#
# Table name: users
#
#  id                  :bigint           not null, primary key
#  current_sign_in_at  :datetime
#  current_sign_in_ip  :string
#  email               :string           default(""), not null
#  encrypted_password  :string           default(""), not null
#  first_name          :string           not null
#  last_name           :string           not null
#  last_sign_in_at     :datetime
#  last_sign_in_ip     :string
#  remember_created_at :datetime
#  sign_in_count       :integer          default(0), not null
#  username            :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email) UNIQUE
#  index_users_on_username  (username) UNIQUE
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  validates :first_name, :last_name, presence: true, length: { minimum: 1 }
  validates :username, presence: true, length: { minimum: 6, maximum: 25 }

  has_many :thoughts, dependent: :destroy
  has_many :recoveries, dependent: :destroy
  has_many :awards, dependent: :destroy
  has_many :routines, dependent: :destroy
  has_many :reminders, dependent: :destroy
end
