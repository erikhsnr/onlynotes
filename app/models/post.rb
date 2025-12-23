class Post < ApplicationRecord
  validates_presence_of:title, message: "Ein Titel fehlt"
  validate :valid_fileSize
  validate :validDescription

  #has_rich_text:content
  has_many_attached :files
  belongs_to :fach
  belongs_to :user
  has_many :likes, dependent: :destroy
  def username
    user.username
  end
  def valid_fileSize
    return unless files.attached?

    files.each do |file|
      unless file.blob.byte_size <= 100.megabyte
          @errors.add(:file, "Die Datei ist größer als 100 Megabytes")
      end
    end
  end

  def validDescription
    if content.present? && content.length >= 250
      @errors.add(:content, "Die Beschreibung muss unter 250 Zeichen sein")
    end
  end
end
