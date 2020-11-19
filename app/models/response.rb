class Response < ApplicationRecord
    validates :respondent_id, :answer_choice_id, presence: true
    validate :not_duplicate_response
    validate :does_not_respond_to_own_poll

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
    #BONUS
    def does_not_respond_to_own_poll
        record = Poll
        .joins(questions: :responses)
        .where(author_id: self.respondent_id)
        return true if record.exists?
        false
    end

    #less efficient, implemented before BONUS
    def poll_own? 
        poll_author = self.question.poll.author
        return true if poll_author.id == self.respondent_id
        false
    end

end
