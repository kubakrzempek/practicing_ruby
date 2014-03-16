module TetrisPrototype
  class Canvas
    SIZE = 10

    def initialize
      @data = SIZE.times.map {Array.new(SIZE)}
    end

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

    def paint_shape(shape,position)
      shape.translated_points(position).each do |point|
        paint(point,Piece::SYMBOL)
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

#example2 - working painting pieces

canvas = TetrisPrototype::Canvas.new

bent_shape = TetrisPrototype::Piece.new([[0,1],[0,2],[1,0],[1,1]])
bent_shape.paint(canvas)

puts canvas

#example3 - working painting pieces at specified points

canvas = TetrisPrototype::Canvas.new
bent_shape = TetrisPrototype::Piece.new([[0,1],[0,2],[1,0],[1,1]])

canvas.paint_shape(bent_shape, [2,3])

puts canvas