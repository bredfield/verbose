class WordsController < ApplicationController
  respond_to :json, :html
  before_filter :authenticate_user!

  def index
    @words = Word.all

    respond_with @words
  end

 
  def show
    @word = Word.find(params[:id])

    respond_with @word
  end

  def search
    @words = Wordnik.word.get_definitions(params[:word],use_canonical:true, case_sensitive:false)
    respond_with @words
  end

  def new
    @word = Word.new

    respond_with @word
  end

  def edit
    @word = Word.find(params[:id])
  end

 
  def create
    @word = Word.new(params[:word])

    respond_to do |format|
      if @word.save
        format.html { redirect_to @word, notice: 'Word was successfully created.' }
        format.json { render json: @word, status: :created, location: @word }
      else
        format.html { render action: "new" }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def update
    @word = Word.find(params[:id])

    respond_to do |format|
      if @word.update_attributes(params[:word])
        format.html { redirect_to @word, notice: 'Word was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def destroy
    @word = Word.find(params[:id])
    @word.destroy

    respond_with "word successfully destroyed"
  end
end