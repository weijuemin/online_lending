class Borrower < ApplicationRecord
  has_secure_password
  has_many :histories
  has_many :lenders, through: :histories

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :money, :purpose, :description, presence: true
  validates :email, presence: true, format: {with: EMAIL_REGEX}, uniqueness: {case_sensitive: false}
end
