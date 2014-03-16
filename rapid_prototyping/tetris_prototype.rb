module TetrisPrototype
  class Canvas
    SIZE = 10

    def initialize
      @data = SIZE.times.map {Array.new(SIZE)}
    end

    attr_reader :data

    def paint(point,marker)
      x,y = point
      @data[SIZE-y-1][x] = marker
    end

    def to_s
      [seperator, body, seperator].join("\n")
    end

    def seperator
      "="*SIZE
    end

    def body
      @data.map do |row|
        row.map { |e| e || " " }.join
      end.join("\n")
    end

    def paint_shape(shape,position=[5,5], symbol = '#')
      shape.translated_points(position).each do |point|
        paint(point,symbol)
      end
    end
  end

  class Piece

    SYMBOL = '#'

    def initialize(points)
      @points = points
      establish_anchor
    end

    attr_reader :points, :anchor

    def establish_anchor
      @anchor = @points.max_by {|x,y| [y,-x]}
    end

    def paint(canvas)
      points.each do |point|
        canvas.paint(point, SYMBOL)
      end
    end

    def translated_points(new_anchor)
      new_x, new_y = new_anchor
      old_x, old_y = anchor

      dx = new_x - old_x
      dy = new_y - old_y

      points.map {|x,y| [x+dx, y+dy] }
    end
  end

  class Game
    def initialize
      @junk = Canvas::SIZE.times.map {Array.new(Canvas::SIZE)}
      @piece = nil
      @piece_position = []
    end

    attr_accessor :piece, :piece_position

    def to_s
      canvas = Canvas.new

      @junk.each_with_index do |row,y|
        row.each_with_index do |col,x|
          canvas.paint([x,y], "|") if col
        end
      end

      if @piece
        canvas.paint_shape(piece,piece_position,'#')
      end

      canvas.to_s
    end

    def add_junk(points)
      points.each do |x,y|
        @junk[x][y] = true
      end
    end

    def update_junk
      convert_piece_to_junk

      @junk.delete_if {|row| row.all?}

      @junk << [] until @junk.length == Canvas::SIZE
    end

    def convert_piece_to_junk
      add_junk(piece.translated_points(piece_position))
      @piece = nil
      @piece_position = nil
    end
  end
end

#example 1 - working canvas

canvas = TetrisPrototype::Canvas.new

(0..2).map do |x|
  canvas.paint([x,0], "|")
end

canvas.paint([2,1], "|")

(0..3).map do |y|
  canvas.paint([3,y], "#")
end

(4..9).map do |x|
  canvas.paint([x,0], "|")
end

[4,5,8,9].map do |x|
  canvas.paint([x,1], '|')
end

canvas.paint([4,2], "|")
canvas.paint([9,2], "|")

puts canvas

#example2 - painting pieces

canvas = TetrisPrototype::Canvas.new

bent_shape = TetrisPrototype::Piece.new([[0,1],[0,2],[1,0],[1,1]])
canvas.paint_shape(bent_shape)

puts canvas

#example3 - painting pieces at specified points

canvas = TetrisPrototype::Canvas.new
bent_shape = TetrisPrototype::Piece.new([[0,1],[0,2],[1,0],[1,1]])

canvas.paint_shape(bent_shape, [2,3])

puts canvas

#example4

game = TetrisPrototype::Game.new
bent_shape = TetrisPrototype::Piece.new([[0,1],[0,2],[1,0],[1,1]])
game.piece = bent_shape
game.piece_position = [2,3]
game.add_junk([[0,0], [1,0], [2,0], [2,1], [4,0],
              [4,1], [4,2], [5,0], [5,1], [6,0],
              [7,0], [8,0], [8,1], [9,0], [9,1],
              [9,2]])

puts game

puts '###########################################'