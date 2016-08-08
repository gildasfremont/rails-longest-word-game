require 'open-uri'
require 'json'

class GameController < ApplicationController
  def play
    grid_size = 8
    @grid = []
    (1..grid_size).each { @grid << ('a'..'z').to_a.sample }
    session[:grid] = @grid
  end

  def score
    @time = ((Time.now.to_i - params[:start_time].to_i) / 600_000_000).to_f
    @answer = params[:answer]
    letters = session[:grid]
    @score = 0
    @translation = "No translation"
    wr = JSON.parse(open("http://api.wordreference.com/0.8/80143/json/enfr/#{@answer.downcase}").read)
    if wr["term0"].nil?
      @message = "Not an english word"
    elsif @answer.downcase.split("").all? { |letter| @answer.downcase.scan(letter.to_s).count <= letters.join.downcase.split("").join.scan(letter.to_s).count }
      @message = "Well done"
      @translation = wr["term0"]["PrincipalTranslations"]["0"]["FirstTranslation"]["term"]
      @score = (@answer.downcase.length * 100 - @time).to_i
    else
      @message = "Not in the grid"
    end
  end
end
