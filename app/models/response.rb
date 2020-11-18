class Response < ApplicationRecord
    validates :respondent_id, :answer_choice_id, presence: true
    validate :not_duplicate_response
    validate :not_own_poll

    belongs_to :respondent,
    class_name: :User,
    foreign_key: :respondent_id

    belongs_to :answer_choice

    has_one :question, through: :answer_choice, source: :question

    def sibling_responses
        self_question_id = self.question.id
        Response
        .joins(:question)
        .where('questions.id': self_question_id)
    end

    def respondent_already_answered?
        return true if sibling_responses
                        .where(respondent_id: self.respondent_id).exists?
        false
    end

    def not_duplicate_response
        if respondent_already_answered?
            errors[:no_duplicate] << 'responses are allowed for the same question by one user.'
        end
    end

    def not_own_poll
        errors[:poll_owner] << 'should not respond.' if poll_own?
    end

    def poll_author_same
        Poll
        .joins(questions: :responses)
        .where(author_id: self.respondent_id)
    end

    def poll_own?
        return true if poll_author_same.exists?
        false
    end

end
