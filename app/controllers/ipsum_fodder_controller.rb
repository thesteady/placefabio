class IpsumFodderController < ApplicationController
  def index
    @base_words = pull_text_words
    @categories = pull_categories
  end

  private

  def pull_text_words
    #TODO: hard-coded for testing. Should be changeable.
    text = %q(
            Silently they continued walking until they walked out of the dark valley
            into a luminescent expanse. Ahead of them there was an unlimited abyss.
            It stretched further than they could see, from right to left and ahead.
            It seemed even greater than standing on a beach and looking across to the
            horizon because here there seemed to be no horizon.
    )
    IpsumFodder.new(text).ipsum
  end

  def pull_categories
    #TODO: hard-coded for testing
    Struct.new("Category", :name, :id)
    [Struct::Category.new('General', 1),
     Struct::Category.new('Fantasy', 2),
     Struct::Category.new('Pirate', 3),
     Struct::Category.new('Vampire', 4)]
  end
end
