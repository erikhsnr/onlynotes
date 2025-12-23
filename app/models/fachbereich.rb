class Fachbereich < ApplicationRecord
  validates_presence_of:name, message: "Der Name des Fachbereichs fehlt!"
  belongs_to :bildungseinrichtung
  has_many :studiengangs, dependent: :destroy
end
