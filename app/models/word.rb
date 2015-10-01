class Word < ActiveRecord::Base
  CATEGORY_NAMES = ['general', 'racy', 'fantasy', 'pirate', 'vampire', 'ignore']

  validates :name, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORY_NAMES,
    message: "%{value} is not a valid category" }
  validates :name, uniqueness: { case_sensitive: false }
  before_save :downcase_name

  def self.batch_return_new_words(word_array)
    # Other option is using something like
    # word_array - Word.pluck(:name)
    word_array.select do |w|
      !Word.exists?(name: w.downcase)
    end
  end

  private

  def downcase_name
    self.name = self.name.downcase if attribute_present?("name")
  end
end
