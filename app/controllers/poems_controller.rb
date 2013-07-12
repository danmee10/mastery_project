class PoemsController < ApplicationController

  def new
    @poem = Poem.new
  end

  def create
    @poem = Poem.new(params[:poem])
    @poem.poem_text ||= @poem.original_text

    if @poem.save
      redirect_to edit_poem_path(@poem)
    else
      flash[:error] = "Please try again."
      redirect_to new_poem_path
    end
  end

  def edit
    @poem = Poem.find(params[:id])
  end

  def update
    @poem = Poem.find(params[:id])
    @poem.update_attributes(params[:poem])

    respond_to do |format|
      format.html { redirect_to edit_poem_path(@poem) }
      format.js
    end
  end
end
