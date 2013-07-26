class Api::PoemsController < ApplicationController

  def update
    poem = Poem.find(params[:id])
    poem.replace(params[:oldWord].to_i, params[:newWord])
    poem.save

    respond_to do |format|
      format.json { render json: @payload }
    end
  end
end

  # def index
  #   @poems = Poem.where(public_poem: true).where("title like ?", "%#{params[:search]}%")
  #   @search = params[:search]
  #   @payload = {}
  #   @payload[:poems] = []
  #   @poems.each do |poem|

  #     @payload[:poems] << {   id: poem.id,
  #                            pic: poem.pic,
  #                          title: poem.title   }
  #   end
  #   @payload[:search] = @search

  #   respond_to do |format|
  #     format.json { render json: @payload }
  #   end
  # end

# makes new request for poems matching each search instead of just 'hiding' those that don't
