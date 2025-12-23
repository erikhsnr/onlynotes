class Bildungseinrichtung < ApplicationRecord
  validates_presence_of:name, message: "Der Name der Bildungseinrichtung fehlt!"
  validates_presence_of:ort, message: "Der Ort der Bildungseinrichtung fehlt!"
  has_many :fachbereiches, dependent: :destroy
end
