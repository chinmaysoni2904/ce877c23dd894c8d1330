class Api::SudokuController < ApplicationController
  def sudoku
    binding.pry
    input = params[:data]
    input = eval(params[:data]) if params[:data].class == String
    return render :json => {status: 500, message: "Input is not given"} if input.blank?
    response = Sudoku.new.solve(input)
    render :json => {solution: response}
  end

end
