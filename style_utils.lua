-- Utility function to initialize styles for widgets. Must be used before widget is initialized. So before wibox.widget() is called.
--- @param tab table
--- @param styles? table|string
function Apply_styles(tab, styles)
  -- If passed argument is not a table then simply return because there is nothing to  do
  if type(tab) ~= "table" then
    return
  end

  -- Iterate over nested tables initializing them. Ignoring 'widget' fields because there is nothing to do for them
  -- tab.prevent_recursive_styles -> for some cases when you need to prevent appling nested styles. For example some part of widget already had applied styles
  for k, v in pairs(tab) do
    if k ~= "widget" and k ~= "layout" and type(v) == "table" and not tab.prevent_recursive_styles then
      Apply_styles(v, styles)
    end
  end

  local class = tab["class"]

  -- If class is not specified then return
  if tab.styles_applied or class == nil then
    return tab
  end

  local found_styles = nil

  -- Styles can be either as string or as table.
  if styles ~= nil and type(class) == "string" then
    found_styles = styles[class]
  elseif type(class) == "table" then
    found_styles = class
  end

  if found_styles == nil then
    return tab
  end

  -- Iterate over 'styles' table and insert fields into widget
  for key, value in pairs(found_styles) do
    tab[key] = value
  end

  tab.styles_applied = true

  -- Return tab so the root widget can be returned from function
  return tab
end
