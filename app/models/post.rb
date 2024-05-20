class Post < ApplicationRecord
  
  has_one_attached :image
  belongs_to :user
  has_many :post_comments, class_name: "Comment", dependent: :destroy
  
  def self.search(search)
    if search != ""
      Post.where('post_commets LIKE(?)', "%#{search}%")
    else
      Post.all
    end
  end
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'dafault-image.jpg', content_type: 'image/jpeg')
    end
      image
  end
end
