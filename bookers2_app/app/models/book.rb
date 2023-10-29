class Book < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }  #introductionの文字数は、200文字まで
end
