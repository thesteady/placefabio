class IpsumFodderController < ApplicationController
  def new
  end

  def create
    @base_words = pull_text_words(params['input-text'])
    if @base_words
      session['words'] = @base_words
      redirect_to ipsum_fodder_assign_url
    else
      #TODO: handle else
    end
  end

  def assign
    @base_words = session['words']
    session['words'] = []
    @categories = pull_categories
    #TODO: Allow users to pull in proper names
  end

  private

  def pull_text_words(input_text)
    #TODO: should be tested and in service
    all_uniq_words = IpsumFodder.new(input_text).ipsum.take(200)
    #TODO: Limitiation for size should be more graceful
    Word.batch_return_new_words(all_uniq_words)
  end

  def pull_categories
    Word::CATEGORY_NAMES - ['ignore']
  end
end
