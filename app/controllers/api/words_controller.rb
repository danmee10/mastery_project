class Api::WordsController < ApplicationController

  def show
    @word = Word.locate(params[:id])
    @payload = {word: @word, synonyms: @word.synonym_lookup, rhymes: @word.rhyme_lookup }

    respond_to do |format|
      format.json { render json: @payload }
    end
  end
end
