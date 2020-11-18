class Question < ApplicationRecord
    validates :text, :poll_id, presence: true

    belongs_to :poll

    has_many :answer_choices

end