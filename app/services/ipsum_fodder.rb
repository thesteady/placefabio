class IpsumFodder
  attr_reader :ipsum

  def initialize(text)
    text ||= text
    all_words = self.class.pull_words(text)
    proper_nouns = self.class.snag_proper_nouns(text)
    stripped_words = self.class.strip_words(all_words, proper_nouns)
    normalized_uniq_words = self.class.normalize_uniq_words(stripped_words)
    @ipsum = normalized_uniq_words
  end

  def self.pull_words(text)
    text.gsub(/[^0-9a-z' ]/i, ' ').split(' ')
  end

  def self.snag_proper_nouns(text)
    proper_noun_regex = /(?<!^|\. |\.  |\"|\? |\" |\! )[A-Z][a-z]+/
    text.scan(proper_noun_regex).uniq
  end

  def self.strip_words(text_array, blacklisted_words)
    text_array.reject{|word| blacklisted_words.include? word }
  end

  def self.normalize_uniq_words(text_array)
    downcase_text(text_array).uniq
  end

  def self.downcase_text(text_array)
    text_array.map{|w| w.downcase}
  end
end
