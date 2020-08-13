class RemoveDefaultFalseFromUserHistories < ActiveRecord::Migration[6.0]
  def change
    remove_reference :histories, :user
    add_reference :histories, :user, foreign_key:true
  end
end
