class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true
    
    has_many :authored_polls,
    class_name: :Poll,
    foreign_key: :author_id

    has_many :responses,
    foreign_key: :responder_id
end