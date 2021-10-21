class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  mount_uploader :profile_image, ProfileImageUploader   
  
  enum role: {
    normal: 0,
    admin: 1,
  }


         
  scope :recent, -> { order(id: :desc).limit(10) }
         
  has_many :posts　　, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :comments , dependent: :destroy
  has_many :likes    , dependent: :destroy
  has_many :answers  , dependent: :destroy
  has_many :answered_questions, through: :answers, source: :question   
  
  # ストック周り
  has_many :stocks, dependent: :destroy
  has_many :stocked_questions, through: :stocks, source: :question

  # タグ、カテゴリー周り
  has_many :tag_relationships, as: :taggable,               dependent: :destroy
  has_many :categories,        through: :tag_relationships, source: :category

  # フォロー機能 参照：https://qiita.com/tanutanu/items/a4a33554cb0e873720e9
  has_many :active_relationships,  foreign_key: :follower_id,       class_name: 'Relationship', dependent: :destroy
  has_many :followees,             through: :active_relationships,  source: :followee
  has_many :passive_relationships, foreign_key: :followee_id,       class_name: 'Relationship', dependent: :destroy
  has_many :followers,             through: :passive_relationships, source: :follower
  
  # 通知周り
  has_many :active_notifications , class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  # バリデーション
  validates :name,    presence: true, length: { maximum: 20 }
  validates :profile                , length: { maximum: 400 }
  validates :email                  , length: { maximum: 256 }

  # フォロー周り
  def follow(other_user)
    return if self == other_user
    unless following?(other_user)
      followees << other_user
      create_notification_follow(other_user)
    end
  end

  def unfollow(other_user)
    active_relationships.find_by(followee_id: other_user.id).destroy! if following?(other_user)
  end

  def following?(other_user)
    followees.include?(other_user)
  end

  # タグ、カテゴリー周り
  def follow_category(category)
    categories << category unless following_category?(category)
  end

  def unfollow_category(category)
    tag_relationships.find_by(category_id: category.id).destroy if following_category?(category)
  end

  def following_category?(category)
    categories.include?(category)
  end

  # 通知周り
  def create_notification_follow(followee)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and action = ?', id, followee.id, 'follow'])
    if temp.blank?
      notification = active_notifications.new(
        visited: followee,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  def create_notification_answer(answer)
    notification = active_notifications.new(
      answer: answer,
      visited: answer.question.user,
      action: 'answer'
    )
    if notification.valid? && notification.visitor != notification.visited
      notification.save
    end
  end

  def create_notification_stock(question)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and action = ?', id, question.user.id, 'stock'])
    if temp.blank?
      notification = active_notifications.new(
        question: question,
        visited: question.user,
        action: 'stock'
      )
      if notification.valid? && notification.visitor != notification.visited
        notification.save
      end
    end
  end

  def has_new_notifications?
    passive_notifications.where(checked: false).present?
  end

  def save_notification_comment(comment, visited_id)
    notification = active_notifications.new(
      comment: comment,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.valid? && notification.visitor != notification.visited
      notification.save
    end
  end

  # ランキング周り
  def self.create_ranking(klass)
    User.find(klass.group(:user_id).order('count(user_id) desc').limit(10).pluck(:user_id))
  end

  # フィード
  def followee_items(klass)
    klass.recent.where("user_id IN (?)", followee_ids)
  end

  def mycategory_items(klass)
    # Question, Postのidを取得するためのサブクエリ
    myitems_ids = "SELECT taggable_id
                   FROM tag_relationships
                   WHERE taggable_type = :klass_class AND category_id IN (:mycategories_ids)"
    klass.where("id IN (#{myitems_ids})", klass_class: klass.name, mycategories_ids: category_ids).recent
  end
  
end
