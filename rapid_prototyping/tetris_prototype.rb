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
  end
end


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