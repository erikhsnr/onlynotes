class Fach < ApplicationRecord
  validates_presence_of:name, message: "Der Name des Fachbereichs fehlt!"
  belongs_to :studiengang
  has_many :posts, dependent: :destroy
  has_many :follows
  has_many :followers, through: :follows, source: :user
  belongs_to :user
end
