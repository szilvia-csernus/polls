class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true

    has_many :authored_polls,
    class_name: :Poll,
    foreign_key: :author_id,
    dependent: :destroy

    has_many :responses,
    foreign_key: :respondent_id,
    dependent: :destroy

    #BONUS
    def completed_polls
        polls = Poll
        .left_outer_joins(:responses)
        .select('polls.title, COUNT(questions.*), COUNT(responses.*)')
        .where('responses.respondent_id': self.id)
        .group('polls.id')
        .having('COUNT(questions.*) = COUNT(responses.*)')
        
        arr = []
        polls.each do |poll|
            arr << poll.title
        end
        arr
    end
    #BONUS
    def completed_polls_with_raw_sql
        polls = Poll.find_by_sql([
           'SELECT polls.title, COUNT(questions.*), COUNT(responses.*)
            FROM 
                polls 
            LEFT OUTER JOIN 
                questions
                ON questions.poll_id = polls.id 
            LEFT OUTER JOIN 
                answer_choices 
                ON answer_choices.question_id = questions.id 
            LEFT OUTER JOIN 
                responses 
                ON responses.answer_choice_id = answer_choices.id
            WHERE 
                responses.respondent_id = ? 
            GROUP BY 
                polls.id 
            HAVING 
                COUNT(questions.*) = COUNT(responses.*)',
            self.id ]
            )
        
        arr = []
        polls.each do |poll|
            arr << poll.title
        end
        arr
    end
end