class Creator < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_attached_file :creator_img, styles: { medium: "450x450>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :creator_img, content_type: /\Aimage\/.*\z/
end
