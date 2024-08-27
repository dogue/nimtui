
type
  BoxKind* = enum
    bkNormal
    bkVSplit
    bkHSplit

  Box* = ref object
    x*, y*, width*, height*: int
    case kind*: BoxKind:
    of bkNormal:
      sibling: Box
    of bkVSplit:
      left*, right*: Box
    of bkHSplit:
      top*, bottom*: Box


proc splitV*(b: var Box, basis: float = 0.5): tuple[left: Box, right: Box] =
  b = Box(kind: bkVSplit, x: b.x, y: b.y, width: b.width, height: b.height)

  let
    leftW = int(float(b.width) * basis)
    rightW = b.width - leftW
    rightX = b.x + leftW

  b.left = Box(x: b.x, y: b.y, width: leftW, height: b.height)
  b.right = Box(x: rightX, y: b.y, width: rightW, height: b.height)

  result = (b.left, b.right)


proc splitH*(b: var Box, basis: float = 0.5): tuple[top: Box, bottom: Box] =
  b = Box(kind: bkHSplit, x: b.x, y: b.y, width: b.width, height: b.height)

  let
    topH = int(float(b.height) * basis)
    bottomH = if b.height mod 2 == 0: b.height - topH else: b.height - topH + 1
    bottomY = if b.height mod 2 == 0: b.y + topH else: b.y + topH - 1

  b.top = Box(x: b.x, y: b.y, width: b.width, height: topH)
  b.bottom = Box(x: b.x, y: bottomY, width: b.width, height: bottomH)

  result = (b.top, b.bottom)
