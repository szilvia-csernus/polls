class ChangeResponseColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :responses, :responder_id, :respondent_id
  end
end
