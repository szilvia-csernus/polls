class Question < ApplicationRecord
    validates :text, :poll_id, presence: true

    belongs_to :poll
    has_many :answer_choices, dependent: :destroy
    has_many :responses, through: :answer_choices, source: :responses

    def n_plus_one_results
        answer_choices = self.answer_choices

        resp_counts = {}
        answer_choices.each do |ans|
            resp_counts[ans.text] = ans.responses.length
        end
        resp_counts
    end

    def better_results
        answer_choices = self.answer_choices.includes(:responses)

        resp_counts = {}
        answer_choices.each do |ans|
            resp_counts[ans.text] = ans.responses.length
        end
        resp_counts
    end

    def results 
        ans_choices = self.answer_choices
        .select('answer_choices.*, COUNT(responses.answer_choice_id) AS count')
        .left_outer_joins(:responses)
        .group('answer_choices.id')
        
        hash = {}
        ans_choices.each do |ans|
            hash[ans.text] = ans.count
        end
        hash
    end
end