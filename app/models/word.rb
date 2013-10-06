class Word < ActiveRecord::Base
  attr_accessible :date_learned, :definition, :hyphenation, :learned, :name, :part_of_speech, :phrases, :synonyms, :user_id

  belongs_to :user
end
