class IpsumFodder

  attr_reader :input_text

  def initialize(input_text)
    @input_text = input_text
  end

  def self.pull_new_ipsum_words(input_text)
    new(input_text).pull_new_ipsum_words
  end

  def pull_new_ipsum_words
    Word.batch_return_new_words(all_uniq_words)
  end

  private

  def all_uniq_words
    service = PullIpsumWords.new(input_text)
    service.ipsum
  end
end
