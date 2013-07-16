class Api::WordsController < ApplicationController

  def show
    @word = Word.locate(params[:id])
    @payload = {word: @word, synonyms: @word.synonym_lookup }
    # , rhymes: @word.rhymes   ["what", "the", "heck"]
    respond_to do |format|
      format.json { render json: @payload }
      format.xml { render xml: @word }
    end
  end
end