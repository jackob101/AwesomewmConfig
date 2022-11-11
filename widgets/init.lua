--- @class Widgets
--- @field text fun(args:{}): TextWidget
return {
  text = require(... .. ".text"),
  button = require(... .. ".button"),
  overflow = require(... .. ".overflow"),
}
