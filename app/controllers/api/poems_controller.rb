class Api::PoemsController < ApplicationController

  def update
    poem = Poem.find(params[:id])
    poem.replace(params[:oldWord].to_i, params[:newWord])
    poem.save

    respond_to do |format|
      format.json { render json: @payload }
      format.xml { render xml: @word }
    end
  end
end
