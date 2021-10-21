class Answer < ApplicationRecord
  include Liked
  include Commentable
  
  belongs_to :user
  belongs_to :question
  
  has_many :notifications             , dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes   , as: :likeable    , dependent: :destroy
  has_one  :q_and_a_relationship      , dependent: :destroy

  # バリデーション
  validates :user_id    , presence: true
  validates :question_id, presence: true
  validates :content    , presence: true, length: { maximum: 1000 }

end
