script_name = "Speaker check - 讲话人检查"
script_description = "人不可能有两张嘴，这个脚本就是检查这个的，顺带还检查一下有没有遗漏的 Default 样式。"
script_author = "Yesterday17"
script_version = "1.0"

function select_invalid_lines(subs, selection, active_line)
  local dialogues = {}
  local styles = {}

  for i = 1, #subs do
    local line = subs[i]
    if line.class == "dialogue" and i >= active_line and not line.comment then
      line.i = i
      table.insert(dialogues, line)
    elseif line.class == "style" then
      styles[line.name] = true
    end
  end

  table.sort(
    dialogues,
    function(a, b)
      return a.start_time < b.start_time
    end
  )

  local layers = {}
  for i = 1, #dialogues do
    local line = dialogues[i]

    local layer = layers[line.layer or "default"]
    if layer == nil then
      layer = {}
      layers[line.layer or "default"] = layer
    end

    if line.style == "Default" or styles[line.style] == nil then
      return {line.i}
    end

    local prev = layer[line.style]
    if prev ~= nil and line.start_time < prev.end_time then
      return {prev.i, line.i}
    else
      layer[line.style] = line
    end
  end
end

aegisub.register_macro(script_name, script_description, select_invalid_lines)
