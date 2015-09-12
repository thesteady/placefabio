class IpsumFodderController < ApplicationController
  def new
  end

  def create
    @base_words = IpsumFodder.pull_new_ipsum_words(params['input_text'])
    if @base_words
      session['words'] = @base_words
      redirect_to ipsum_fodder_assign_url
    end
  end

  def assign
    @base_words = session['words']
    session['words'] = []
    @categories = pull_categories
  end

  private

  def pull_categories
    Word::CATEGORY_NAMES - ['ignore']
  end
end
