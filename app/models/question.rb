class Question < ApplicationRecord
    validates :text, :poll_id, presence: true

    belongs_to :poll

    has_many :answer_choices

    has_many :responses, through: :answer_choices, source: :responses

end