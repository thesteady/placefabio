class WordsController < ApplicationController
  before_action :set_word, only: [:show]

  def show
  end

  def create
    @word = Word.new(word_params)
    respond_to do |format|
      if @word.save
        format.json { render :show, status: :created, location: @word }
      else
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_word
    @word = Word.find(params[:id])
  end

  def word_params
    params.require(:word).permit(:name, :category, :ignore)
  end
end
