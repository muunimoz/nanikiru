class Post < ApplicationRecord
  
  has_one_attached :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :area
  belongs_to :temperature
  
  def self.search(keyword, area_name, temperature_name)
    if keyword.present?
      @posts = Post.where('text LIKE(?)', "%#{keyword}%")
    else
      @posts = Post.all
    end
    if area_name.present?
      @posts = @posts.left_joins(:areas).where(areas:{area_name: area_name})
    end
    if temperature_name.present?
      @posts = @posts.left_joins(:temperatures).where(temperatures:{temperature_name: temperature_name})
    end
    @posts
  end
  
  def area_name
     Area.find(self.area_id).area_name
  end
  
  def temperature_name
    Temperature.find(self.temperature_id).temperature_name
  end
  
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'dafault-image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [width, height]).processed
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
end
