# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([{ username: 'szilvi'}, {username: 'akos'}, {username: 'lilla'}, {username: 'dalma'}])
polls = Poll.create([{ title: 'parent_evening', author_id: 1}, { title: 'parent_morning', author_id: 2}])
questions = Question.create([{ text: 'Will you attend the parent_evening 19th November?', poll_id: 1}, 
            { text: 'How many seats do you need?', poll_id: 1},
            { text: 'Are you planning on coming to the parents morning 20th November?', poll_id: 2}  ])
answer_choices = AnswerChoice.create([{ text: 'Yes', question_id: 1}, { text: 'No', question_id: 1},
            { text: 'One', question_id: 2}, { text: 'Two', question_id: 2},
            { text: 'Yes', question_id: 3}, { text: 'No', question_id: 3}])
responses = Response.create([{ responder_id: 3, answer_choice_id: 1}, { responder_id: 3, answer_choice_id: 4},
            { responder_id: 3, answer_choice_id: 6}, { responder_id: 4, answer_choice_id: 2},
            { responder_id: 4, answer_choice_id: 5}])