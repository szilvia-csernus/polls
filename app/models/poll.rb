class Poll < ApplicationRecord
    validates :title, :author_id, presence: true
    
    belongs_to :author,
    class_name: :User,
    foreign_key: :author_id

    has_many :questions

end