import std/[terminal, strutils]

const
  HLINE = "\u2500"
  VLINE = "\u2502"
  TLCORNER = "\u250c"
  TRCORNER = "\u2510"
  BLCORNER = "\u2514"
  BRCORNER = "\u2518"
  LEFTTEE = "\u251c"
  RIGHTTEE = "\u2524"
  TOPTEE = "\u252C"
  BOTTOMTEE = "\u2534"


type
  Pos* = object
    x*, y*: int

  BoxCorner* = enum
    bcTopLeft
    bcTopRight
    bcBottomLeft
    bcBottomRight


proc drawLineV*(start: Pos, length: int) =
  for i in 0..<length:
    stdout.setCursorPos(start.x, start.y + i)
    stdout.write(VLINE)

proc drawLineH*(start: Pos, length: int) =
  stdout.setCursorPos(start.x, start.y)
  stdout.write(HLINE.repeat(length))

proc drawCorner*(x, y: int, corner: BoxCorner) =
  stdout.setCursorPos(x, y)
  case corner:
  of bcTopLeft: stdout.write(TLCORNER)
  of bcTopRight: stdout.write(TRCORNER)
  of bcBottomLeft: stdout.write(BLCORNER)
  of bcBottomRight: stdout.write(BRCORNER)

proc drawBorder*(x, y, w, h: int) =
  drawLineH(Pos(x: x, y: y), w)          # top
  drawLineV(Pos(x: x, y: y), h)          # left
  drawLineV(Pos(x: x + w - 1, y: y), h)  # right
  drawLineH(Pos(x: x, y: y + h - 1), w)  # bottom

  drawCorner(x, y, bcTopLeft)
  drawCorner(x + w - 1, y, bcTopRight)
  drawCorner(x, y + h - 1, bcBottomLeft)
  drawCorner(x + w - 1, y + h - 1, bcBottomRight)
