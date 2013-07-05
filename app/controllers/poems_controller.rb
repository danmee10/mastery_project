class PoemsController < ApplicationController

  def new
    @poem = Poem.new
  end

  def create
    @poem = Poem.new(params[:poem])

    if @poem.save
      redirect_to edit_poem_path(@poem)
    else
      flash[:error] = "Please try again."
      redirect_to new_poem_path
    end
  end

  def edit

  end

end
