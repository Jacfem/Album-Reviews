class Album < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_attached_file :album_image, styles: { album_index: "200x200>", album_show: "300x300>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :album_image, content_type: /\Aimage\/.*\Z/
end
