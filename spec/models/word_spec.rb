require 'spec_helper'

describe Word do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_presence_of :category }
    it 'validates category inclusion' do
      expect(subject).to validate_inclusion_of(:category).in_array(Word::CATEGORY_NAMES)
    end
  end

  describe 'callbacks' do
    describe 'downcase_name' do
      it 'downcases a name before save' do
        word = create(:word, name: 'HeLLo')
        expect(word.name).to eq('hello')
      end

      it 'handles nil names' do
        word = build(:word, name: nil)
        expect(word.save).to eq(false)
      end
    end
  end

  describe 'batch_return_new_words' do
    let(:service){ Word }

    before do
      create(:word, name: 'cat')
    end

    it 'returns words not already in the database' do
      word_array = ['cat', 'dog', 'fish']
      expect(service.batch_return_new_words(word_array)).to match(['dog', 'fish'])
    end

    it 'is case insensitive' do
      word_array = ['Cat', 'cat', 'CAT', 'dog', 'fish']
      expect(service.batch_return_new_words(word_array)).to match(['dog', 'fish'])
    end
  end
end
