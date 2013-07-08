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
    redirect_to edit_poem_path(@poem)
  end
end
