require 'spec_helper'

describe IpsumFodder do
  let(:service){ IpsumFodder }

  describe 'pull_new_ipsum_words' do
    let(:input_text){ 'She sells seashells by the seashore' }
    let(:expected_result){ ["she", "sells", "seashells", "by", "the", "seashore"] }

    it 'checks new words against the database' do
      expect(service.pull_new_ipsum_words(input_text)).to match(expected_result)
      create(:word, name: 'she')
      expect(service.pull_new_ipsum_words(input_text)).to match(expected_result - ['she'])
    end
  end
end
