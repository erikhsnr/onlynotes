class Studiengang < ApplicationRecord
  validates_presence_of:name, message: "Der Name des Studiengangs fehlt!"
  belongs_to :fachbereich
  has_many :faches, dependent: :destroy
end
