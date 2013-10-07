class Word < ActiveRecord::Base
  attr_accessible :date_learned, :definition, :hyphenation, :learned, :name, :part_of_speech, :phrases, :synonyms, :user_id
  after_create :set_supplemental
  belongs_to :user

  def get_phrases
    self.phrases = Wordnik.word.get_phrases(self.name.downcase).map {|p| "#{p['gram1']} #{p['gram2']}"}
  end

  def get_etymologies
    self.etymologies = Wordnik.word.get_etymologies(self.name.downcase)
  end

  def get_synonyms
    self.synonyms = Wordnik.word.get_related_words(self.name.downcase, relationship_types:"synonym")
  end

  def get_hyphenation
    hyphenation = ""
    
    Wordnik.word.get_hyphenation(self.name.downcase).each do |h|
      text = h['text']
      if h['type'] == 'stress' 
        text = "<strong>#{h['text']}</strong>"
      end
      if h['seq'] != 0
        text = " - #{h['text']}"
      end
      hyphenation += text
    end

    self.hyphenation = hyphenation
  end

  def set_supplemental
    self.get_phrases
    self.get_etymologies
    self.get_synonyms
    self.get_hyphenation
    self.save
  end

end
