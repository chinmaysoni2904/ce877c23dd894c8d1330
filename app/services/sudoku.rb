class Sudoku

  SIZE = 9
  NUMBERS = (1..9).to_a

  def initialize
    @board = Array.new(SIZE) { Array.new(SIZE, nil) }
  end

  def [](x, y)
    @board[y][x]
  end

  def []=(x, y, value)
    raise "#{value} is not allowed in the row #{y}" unless allowed_in_row(y).include?(value)
    raise "#{value} is not allowed in the Column #{x}" unless allowed_in_column(x).include?(value)
    raise "#{value} is not allowed in the Grid #{x} x #{y}" unless allowed_in_square(x,y).include?(value)
    @board[y][x] = value
  end
  def to_s
    @board.map{|row| row.map{|x| x.nil? ? '-' : x }.join(' ')}.join("\n")
  end
  def row(y)
    Array.new(@board[y])
  end
  def column(x)
    @board.map { |row| row[x] }
  end
  def allowed_in_row(y)
    (NUMBERS - row(y)).uniq << nil
  end
  def allowed_in_column(x)
    (NUMBERS - column(x)).uniq << nil
  end

  def allowed_in_square(x, y)
    sx = 3 * (x / 3)
    sy = 3 * (y / 3)
    square = []
    3.times do |i|
      3.times do |j|
        square << @board[sy + j][sx + i]
      end
    end
    (NUMBERS - square).uniq << nil
  end
  def allowed(x, y)
    allowed_in_row(y) && allowed_in_column(x) && allowed_in_square(x, y)
  end
  def empty
    result = []
    9.times do |y|
      9.times do |x|
        result << [x ,y] if self[x, y].nil?
      end
    end
    result
  end
  def solved?
    empty.empty?
  end

  def solve sudoku
    return sudoku  if sudoku.solved?
    x,y = sudoku.empty.first
    allowed = sudoku.allowed(x, y).compact
    while !allowed.empty?
      sudoku[x, y] = allowed.shift
      begin
        return sudoku if solve(sudoku)
      rescue Exception => e
      end
      sudoku[x,y] = nil
    end
    return sudoku
  end

end









