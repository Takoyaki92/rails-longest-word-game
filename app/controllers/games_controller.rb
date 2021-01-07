require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    #generate game settings
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
    @letters
  end
  def score
    @word = params[:word].upcase
    @letters = params[:letters]

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    results_serialized = open(url).read
    results = JSON.parse(results_serialized)

    # @result = @word.split('') - @letters.split('')
    if (@word.split('') - @letters.split('')).empty? == false
      @result = "no you can't use that word dummy"
    elsif results["found"] == false
      @result = "haiyaaah that is not a word"
    else
      @result = "Good job. Your score is #{results["length"]}"
    end
  end
end
