class AnswerChoice < ApplicationRecord
    validates :text, :question_id, presence: true
    belongs_to :question

    has_many :responses, dependent: :destroy

end