window.changeColor = (obj) ->
  selection = window.getSelection()

  regexps = [/%.*$/g, /\\\w*/g, /\{[\w\.\/:一-龠ぁ-ン]+\}|\{|\}/g, /\[[\w,=\.]+\]/g]
  colors = ['steelblue', 'gold', 'magenta', 'tomato']

  for regexp, i in regexps
    nodes = obj.childNodes
    for item, itemCnt in nodes
      if item.nodeName != '#text'
        continue

      results = item.data.match(regexp)
      if results != null
        ranges = []
        for val in results
          sPos = item.data.indexOf(val)
          ePos = sPos + val.length

          range = document.createRange()
          range.setStart(item, sPos)
          range.setEnd(item, ePos)
          ranges.push(range)

        for range in ranges
          selection.removeAllRanges()
          selection.addRange(range)
          document.execCommand('ForeColor', false, colors[i])
