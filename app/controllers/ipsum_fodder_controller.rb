class IpsumFodderController < ApplicationController
  def index
    @base_words = pull_text_words
    @categories = pull_categories
    #TODO: Allow users to pull in proper names
  end

  private

  def pull_text_words
    #TODO: hard-coded for testing. Should be changeable.
    text = %q(
             He stood there staring at her for a moment. She sat with her back against the wall. The sun shone down on her, making her hair shine.
             Her knees were pulled up to her chest and her book was propped up against her legs. She was engrossed in her story and did not notice the gentle breeze playing with her hair.
             After she opened the door, she stepped up into her house, and then she felt his hand on her arm. She looked up to see him gazing down at her, his expression was unreadable.
             Then his arms were around her, holding her close.
             She hesitated. His warmth was soaking into her and his hands were spread across her back. Then she wrapped her arms around him, absorbing his strength. Tears pricked her eyes, her throat tightened and his comfort washed over her.
           )
    #TODO: should live in a separate service
    all_uniq_words = IpsumFodder.new(text).ipsum.take(200)
    Word.batch_return_new_words(all_uniq_words)
  end

  def pull_categories
    Word::CATEGORY_NAMES - ['ignore']
  end
end
