require 'spec_helper'

describe IpsumFodder::PullIpsumWords do
  let(:service) { IpsumFodder::PullIpsumWords }
  let(:sample_file) { pull_romance_text('guardian_angel')}
  let(:protagonist) { 'Daimhin' }

  describe 'ipsum' do
    let(:new_service){ service.new(sample_file) }

    it 'returns an array of potential ipsum words' do
      expect(new_service.ipsum.class).to eq(Array)
    end
  end

  describe 'pull_words' do
    it 'handles poorly formatted new lines' do
      text = '"not escorted?""Sometimes people '
      result = ["not", "escorted", "Sometimes", "people"]
      expect(service.pull_words(text)).to eq(result)
    end

    it 'handles apostrophes' do
      text = "don\'t you forget about me"
      result = ["don't", "you", "forget", "about", "me"]
      expect(service.pull_words(text)).to eq(result)
    end
  end

  describe 'snag_proper_nouns' do
    it 'pulls out names' do
      result = service.snag_proper_nouns(sample_file)
      expect(result).to include(protagonist)
    end

    it 'does not pull first word in sentance' do
      text = "Are you sure, it's better? Better than what?"
      expect(service.snag_proper_nouns(text)).to eq([])
    end

    it 'does not pull after quotes' do
      text = 'She sighed "To be honest, I am not really sure.'
      expect(service.snag_proper_nouns(text)).to eq([])
    end
  end

   describe 'strip_words' do
     let(:base_text) { %w'they started walking across the road' }

     it 'returns unmatching words' do
       matcher = 'across'
       expect(service.strip_words(base_text, [matcher])).to_not include(matcher)
     end

     it 'returns matches only full words' do
       matcher = 'the'
       response = service.strip_words(base_text, [matcher])
       expect(response).to_not include('the')
       expect(response).to include('they')
     end
   end

   describe 'normalize_uniq_words' do

     it 'downcases all words' do
       matcher = %w'Hello how ARE you'
       expected_result = %w'hello how are you'
       expect(service.normalize_uniq_words(matcher)).to eq(expected_result)
     end

     it 'returns only unique words' do
       matcher = %w"The cat is named Cat Some cats are named Cat"
       expected_result = ["the", "cat", "is", "named", "some", "cats", "are"]
       expect(service.normalize_uniq_words(matcher)).to eq(expected_result)
     end
   end
end
