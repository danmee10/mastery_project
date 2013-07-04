class PoemsController < ApplicationController

  def new
    @poem = Poem.new
  end

end
