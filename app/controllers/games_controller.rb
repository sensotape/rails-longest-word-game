require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { |_i| @letters << ('A'..'Z').to_a.sample }
  end

  def parse_answer_json(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    answer_serialized = open(url).read
    return JSON.parse(answer_serialized)
  end

  def check_in_grid(grid, answer)
    answer_array = answer.upcase.split(//)
    grid_array = grid.split
    return answer_array.all? { |letter| answer_array.count(letter) <= grid_array.count(letter) }
  end

  def score
    end_time = Time.now
    answer_json = parse_answer_json(params[:answer])
    check_grid = check_in_grid(params[:grid], params[:answer])
    @result = {
      word: params[:answer],
      time: end_time - Time.parse(params[:start_time]),
      grid: params[:grid].split(' '),
      check_grid: check_grid,
      word_json: answer_json
    }
    return @result
  end
end
