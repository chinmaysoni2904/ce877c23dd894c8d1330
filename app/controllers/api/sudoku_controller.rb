class Api::SudokuController < ApplicationController
  def sudoku
    input = params[:data]
    input = JSON.parse(params[:data]) if params[:data].class == String
    return render :json => {status: 500, message: "Input is not given"} if input.blank?
    sudoku = Sudoku.new
    input.each_with_index do |row, y|
      row.each_with_index do |value, x|
        sudoku[x, y] = value.to_i unless value.blank?
      end
    end
    response = sudoku.solve(sudoku)
    render :json => {solution: response}
  end

end
