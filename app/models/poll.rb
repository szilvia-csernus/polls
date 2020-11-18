class Poll < ApplicationRecord
    validates :title, :author_id, presence: true
    validates :title, uniqueness: { 
        scope: :author_id,
        message: 'a user can create a poll title once'}

    belongs_to :author,
    class_name: :User,
    foreign_key: :author_id

    has_many :questions

end