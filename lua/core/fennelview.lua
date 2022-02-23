local _2afile_2a = "fnl/core/fennelview.fnl"
local function view_quote(str)
  return ("\"" .. str:gsub("\"", "\\\"") .. "\"")
end
local short_control_char_escapes = {["\7"] = "\\a", ["\8"] = "\\b", ["\12"] = "\\f", ["\n"] = "\\n", ["\13"] = "\\r", ["\9"] = "\\t", ["\11"] = "\\v"}
local long_control_char_escapes
do
  local long = {}
  for i = 0, 31 do
    local ch = string.char(i)
    if not short_control_char_escapes[ch] then
      short_control_char_escapes[ch] = ("\\" .. i)
      do end (long)[ch] = ("\\%03d"):format(i)
    else
    end
  end
  long_control_char_escapes = long
end
local function escape(str)
  return str:gsub("\\", "\\\\"):gsub("(%c)%f[0-9]", long_control_char_escapes):gsub("%c", short_control_char_escapes)
end
local function sequence_key_3f(k, len)
  return ((type(k) == "number") and (1 <= k) and (k <= len) and (math.floor(k) == k))
end
local type_order = {number = 1, boolean = 2, string = 3, table = 4, ["function"] = 5, userdata = 6, thread = 7}
local function sort_keys(_2_, _4_)
  local _arg_3_ = _2_
  local a = _arg_3_[1]
  local _arg_5_ = _4_
  local b = _arg_5_[1]
  local ta = type(a)
  local tb = type(b)
  if ((ta == tb) and ((ta == "string") or (ta == "number"))) then
    return (a < b)
  else
    local dta = type_order[ta]
    local dtb = type_order[tb]
    if (dta and dtb) then
      return (dta < dtb)
    elseif dta then
      return true
    elseif dtb then
      return false
    elseif "else" then
      return (ta < tb)
    else
      return nil
    end
  end
end
local function get_sequence_length(t)
  local len = 0
  for i in ipairs(t) do
    len = i
  end
  return len
end
local function get_nonsequential_keys(t)
  local keys = {}
  local sequence_length = get_sequence_length(t)
  for k, v in pairs(t) do
    if not sequence_key_3f(k, sequence_length) then
      table.insert(keys, {k, v})
    else
    end
  end
  table.sort(keys, sort_keys)
  return keys, sequence_length
end
local function count_table_appearances(t, appearances)
  if (type(t) == "table") then
    if not appearances[t] then
      appearances[t] = 1
      for k, v in pairs(t) do
        count_table_appearances(k, appearances)
        count_table_appearances(v, appearances)
      end
    else
      appearances[t] = ((appearances[t] or 0) + 1)
    end
  else
  end
  return appearances
end
local put_value = nil
local function puts(self, ...)
  for _, v in ipairs({...}) do
    table.insert(self.buffer, v)
  end
  return nil
end
local function tabify(self)
  return puts(self, "\n", (self.indent):rep(self.level))
end
local function already_visited_3f(self, v)
  return (self.ids[v] ~= nil)
end
local function get_id(self, v)
  local id = self.ids[v]
  if not id then
    local tv = type(v)
    id = (((self["max-ids"])[tv] or 0) + 1)
    do end (self["max-ids"])[tv] = id
    self.ids[v] = id
  else
  end
  return tostring(id)
end
local function put_sequential_table(self, t, len)
  puts(self, "[")
  self.level = (self.level + 1)
  for k, v in ipairs(t) do
    if (function(_12_,_13_,_14_) return (_12_ < _13_) and (_13_ < _14_) end)(1,k,(1 + len)) then
      puts(self, " ")
    else
    end
    put_value(self, v)
  end
  self.level = (self.level - 1)
  return puts(self, "]")
end
local function put_key(self, k)
  if ((type(k) == "string") and k:find("^[-%w?\\^_!$%&*+./@:|<=>]+$")) then
    return puts(self, ":", k)
  else
    return put_value(self, k)
  end
end
local function put_kv_table(self, t, ordered_keys)
  puts(self, "{")
  self.level = (self.level + 1)
  for i, _17_ in ipairs(ordered_keys) do
    local _each_18_ = _17_
    local k = _each_18_[1]
    local v = _each_18_[2]
    if (self["table-edges"] or (i ~= 1)) then
      tabify(self)
    else
    end
    put_key(self, k)
    puts(self, " ")
    put_value(self, v)
  end
  for i, v in ipairs(t) do
    tabify(self)
    put_key(self, i)
    puts(self, " ")
    put_value(self, v)
  end
  self.level = (self.level - 1)
  if self["table-edges"] then
    tabify(self)
  else
  end
  return puts(self, "}")
end
local function put_table(self, t)
  local metamethod
  local function _22_()
    local _21_ = t
    if (nil ~= _21_) then
      local _23_ = getmetatable(_21_)
      if (nil ~= _23_) then
        return (_23_).__fennelview
      else
        return _23_
      end
    else
      return _21_
    end
  end
  metamethod = (self["metamethod?"] and _22_())
  if (already_visited_3f(self, t) and self["detect-cycles?"]) then
    return puts(self, "#<table @", get_id(self, t), ">")
  elseif (self.level >= self.depth) then
    return puts(self, "{...}")
  elseif metamethod then
    return puts(self, metamethod(t, self.fennelview))
  elseif "else" then
    local non_seq_keys, len = get_nonsequential_keys(t)
    local id = get_id(self, t)
    if ((1 < (self.appearances[t] or 0)) and self["detect-cycles?"]) then
      puts(self, "@", id)
    else
    end
    if ((#non_seq_keys == 0) and (#t == 0)) then
      local function _27_()
        if self["empty-as-square"] then
          return "[]"
        else
          return "{}"
        end
      end
      return puts(self, _27_())
    elseif (#non_seq_keys == 0) then
      return put_sequential_table(self, t, len)
    elseif "else" then
      return put_kv_table(self, t, non_seq_keys)
    else
      return nil
    end
  else
    return nil
  end
end
local function put_number(self, n)
  local function _32_()
    local _30_, _31_ = math.modf(n)
    if ((nil ~= _30_) and (_31_ == 0)) then
      local int = _30_
      return tostring(int)
    else
      local function _33_()
        local frac = _31_
        return (frac < 0)
      end
      if (((_30_ == 0) and (nil ~= _31_)) and _33_()) then
        local frac = _31_
        return ("-0." .. tostring(frac):gsub("^-?0.", ""))
      elseif ((nil ~= _30_) and (nil ~= _31_)) then
        local int = _30_
        local frac = _31_
        return (int .. "." .. tostring(frac):gsub("^-?0.", ""))
      else
        return nil
      end
    end
  end
  return puts(self, _32_())
end
local function _35_(self, v)
  local tv = type(v)
  if (tv == "string") then
    return puts(self, view_quote(escape(v)))
  elseif (tv == "number") then
    return put_number(self, v)
  elseif ((tv == "boolean") or (tv == "nil")) then
    return puts(self, tostring(v))
  else
    local _37_
    do
      local _36_ = getmetatable(v)
      if (nil ~= _36_) then
        _37_ = (_36_).__fennelview
      else
        _37_ = _36_
      end
    end
    if ((tv == "table") or ((tv == "userdata") and (nil ~= _37_))) then
      return put_table(self, v)
    else
      return puts(self, "#<", tostring(v), ">")
    end
  end
end
put_value = _35_
local function one_line(str)
  local ret = str:gsub("\n", " "):gsub("%[ ", "["):gsub(" %]", "]"):gsub("%{ ", "{"):gsub(" %}", "}"):gsub("%( ", "("):gsub(" %)", ")")
  return ret
end
local function fennelview(x, options)
  local options0 = (options or {})
  local inspector
  local function _40_()
    if options0["one-line"] then
      return ""
    else
      return "  "
    end
  end
  local function _41_(_241)
    return fennelview(_241, options0)
  end
  inspector = {appearances = count_table_appearances(x, {}), depth = (options0.depth or 128), level = 0, buffer = {}, ids = {}, ["max-ids"] = {}, indent = (options0.indent or _40_()), ["detect-cycles?"] = not (false == options0["detect-cycles?"]), ["metamethod?"] = not (false == options0["metamethod?"]), fennelview = _41_, ["table-edges"] = (options0["table-edges"] ~= false), ["empty-as-square"] = options0["empty-as-square"]}
  put_value(inspector, x)
  local str = table.concat(inspector.buffer)
  if options0["one-line"] then
    return one_line(str)
  else
    return str
  end
end
return fennelview