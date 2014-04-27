# This migration comes from noteboard (originally 20140427185537)
class CreateNoteboardNotes < ActiveRecord::Migration
  def change
    create_table :noteboard_notes do |t|
      t.integer :noteboard_id
      t.integer :poster_id
      t.text :message

      t.timestamps
    end
  end
end
