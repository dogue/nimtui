import std/[terminal, strutils, strformat]
import std/exitprocs
import std/sugar

import box, drawing

proc enableAltBuffer() =
  stdout.write("\e[?1049h")

proc disableAltBuffer() =
  stdout.write("\e[?1049l")

proc drawBorder(b: Box) =
  drawBorder(b.x, b.y, b.width, b.height)

proc drawText(x, y: int, text: string) =
  stdout.setCursorPos(x, y)
  stdout.write(text)

addExitProc(disableAltBuffer) # restore terminal state
addExitProc(() => stdout.resetAttributes())
addExitProc(() => stdout.showCursor())

hideCursor()
enableAltBuffer()
stdout.eraseScreen()

let (width, height) = terminalSize()
drawText(1, 1, &"w: {width}, h: {height}")
var root = Box(x: 0, y: 0, width: width, height: height)
root.drawBorder()
stdout.flushFile()

while true:
  case getch():
  of 'q':
    break
  of 'v':
    # stdout.eraseScreen()
    let (left, right) = root.splitV(0.3)
    left.drawBorder()
    right.drawBorder()
    stdout.flushFile()
  of 'h':
    # stdout.eraseScreen()
    let (top, bottom) = root.left.splitH(0.8)
    top.drawBorder()
    bottom.drawBorder()
    stdout.flushFile()
    discard
  else:
    discard
