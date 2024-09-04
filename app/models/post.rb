class Post < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  belongs_to :area, optional: true
  belongs_to :temperature, optional: true
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags,dependent: :destroy
  has_many :tags,through: :post_tags

  def self.search(keyword, area_name, temperature_name)
    @posts = Post.all
    if keyword.present?
      @posts = @post.where('text LIKE(?)', "%#{keyword}%")
    end
    if area_name.present?
      @posts = @posts.left_joins(:area).where(area:{area_name: area_name})
    end
    if temperature_name.present?
      @posts = @posts.left_joins(:temperature).where(temperature:{temperature_name: temperature_name})
    end
    @posts
  end
  
  def area_name
    if self.area_id.present?
      Area.find(self.area_id).area_name
    else
      "未選択"
    end
  end

  def temperature_name
    if self.temperature_id.present?
      Temperature.find(self.temperature_id).temperature_name
    else
      "未選択"
    end
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'dafault-imagZZe.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [width, height]).processed
  end
  
  def get_cut_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'dafault-imagZZe.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_fill: [256, 170]).processed
  end


  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def save_post_tags(tags)
    # 現在のタグを取得し、nilの場合は空の配列を代入する
    current_tags = self.tags.pluck(:name)
    current_tags ||= []

    # 新しいタグの作成・更新
    tags.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name.strip)
      self.tags << tag unless self.tags.include?(tag)
    end

    # 削除されたタグの削除
    tags_to_delete = current_tags - tags
    self.tags.where(name: tags_to_delete).destroy_all
  end

  with_options presence: true, on: :publicize do
    validates :image
    validates :area
    validates :temperature
    validates :text
  end

end