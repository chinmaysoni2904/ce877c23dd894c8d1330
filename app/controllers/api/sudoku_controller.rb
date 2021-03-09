class Api::SudokuController < ApplicationController
  def sudoku
    input = params[:data]
    return render :json => {status: 500, message: "Input is not given"} if input.blank?
    response = Sudoku.new.solve(input)
    render :json => {solution: response}
  end

end
