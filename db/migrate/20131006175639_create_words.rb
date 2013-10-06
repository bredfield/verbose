class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :name
      t.text :definition
      t.boolean :learned
      t.string :part_of_speech
      t.string :phrases
      t.string :hyphenation
      t.string :synonyms
      t.datetime :date_learned
      t.integer :user_id

      t.timestamps
    end
  end
end
