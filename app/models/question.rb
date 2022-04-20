class Question < ApplicationRecord
  belongs_to :survey 
  has_many :answers, dependent: :destroy
  validates :question, presence: true, length: { minimum: 3 }
end
