class Response < ApplicationRecord
    validates :responder_id, :answer_choice_id, presence: true
    validates :responder_id, uniqueness: {
        scope: :answer_choice_id,
        message: 'one answer per user per question'
    }
    
    belongs_to :respondent,
    class_name: :User,
    foreign_key: :responder_id

    belongs_to :answer_choice

end
