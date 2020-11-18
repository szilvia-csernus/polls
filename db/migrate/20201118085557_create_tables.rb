class CreateTables < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username, null: false, unique: true

      t.timestamps
    end
  end

  def change
    create_table :polls do |t|
      t.string :title, null: false
      t.integer :author_id

      t.timestamps
    end
  end

  def change
    create_table :questions do |t|
      t.text :text, null: false
      t.integer :poll_id, null: false

      t.timestamps
    end
  end

  def change
    create_table :answer_choices do |t|
      t.text :text, null: false
      t.integer :question_id, null: false

      t.timestamps
    end
  end

  def change
    create_table :responses do |t|
      t.integer :responder_id, null: false
      t.integer :answer_choice_id, null: false

      t.timestamps
    end
    add_index :responses, [:responder_id, :answer_choice_id], unique: true
  end
end
