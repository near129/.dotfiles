local wezterm = require('wezterm')
local act = wezterm.action

local is_mac = wezterm.target_triple:find('darwin')
local is_windows = wezterm.target_triple:find('windows')
local is_linux = wezterm.target_triple:find('linux')

-- wezterm.on('update-right-status', function(window, pane)
--   local key_table = window:active_key_table()
--   local domain = pane:get_domain_name()
--   if domain == 'local' then
--     domain = nil
--   else
--     domain = 'In 🌐' .. domain .. '  '
--   end
--
--   window:set_right_status(wezterm.format({
--     { Attribute = { Underline = 'Single' } },
--     { Text = domain or '' },
--     { Text = (key_table or '') .. '  ' },
--   }))
-- end)

local config = wezterm.config_builder()

if is_windows then
  config.default_domain = 'WSL:Ubuntu'
end

-- font
if is_mac then
  config.font = wezterm.font_with_fallback({
    'Monaco',
    'HackGen35 Console NF',
  })
  config.freetype_load_flags = 'NO_BITMAP' -- for monaco. ref: https://github.com/wez/wezterm/issues/2523
else
  config.font = wezterm.font_with_fallback({
    'HackGen35 Console NF',
  })
end
config.font_size = 14

--appearance
local color_scheme_name = 'iceberg-dark'
-- local color_scheme_name = 'nord'
config.color_scheme = color_scheme_name
local color = wezterm.color.get_builtin_schemes()[color_scheme_name]
config.colors = color
config.colors.tab_bar = {
  background = color.background,
}
config.adjust_window_size_when_changing_font_size = false
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
config.window_padding = { left = 0, right = 0, top = 10, bottom = 0 }
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 32
local tabline = wezterm.plugin.require('https://github.com/michaelbrusegard/tabline.wez')
tabline.setup({
  options = {
    theme = color_scheme_name,
    theme_overrides = {
      manage_panes_mode = {
        a = { fg = color.background, bg = color.ansi[6] },
        b = { fg = color.ansi[6], bg = color.ansi[1] },
        c = { fg = color.foreground, bg = color.ansi[1] },
      },
    },
  },
  sections = {
    tabline_a = {
      { 'mode', fmt = string.lower },
    },
    tabline_b = {},
    tab_active = {
      { Attribute = { Intensity = 'Bold' } },
      { Foreground = { Color = config.colors.ansi[6] } },
      'index',
      'ResetAttributes',
      { Foreground = { Color = config.colors.foreground } },
      { 'parent', padding = 0 },
      '/',
      { Attribute = { Intensity = 'Bold' } },
      { 'cwd', padding = { left = 0, right = 1 } },
      { 'zoomed', padding = 0 },
    },
    tab_inactive = { 'index', { 'process', icons_only = true, padding = 0 } },
    tabline_x = {},
    tabline_y = {},
  },
})

-- other
config.window_close_confirmation = 'NeverPrompt'
config.use_ime = true
config.hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(config.hyperlink_rules, {
  regex = [[[[:alnum:].]+:\d{1,5}]],
  format = 'http://$0'
})
table.insert(config.hyperlink_rules, {
  regex = [[:(\d{1,5})]],
  format = 'http://localhost:$1'
})
config.quick_select_patterns = {
  '-(?:-\\w{5,20})+', -- example: --dry-run --force-with-lease
}

--key binding
local super = is_mac and 'CMD' or 'ALT'
config.keys = {
  { key = 'l', mods = super, action = act.ShowLauncher },
  {
    key = '\\',
    mods = 'CTRL',
    action = act.ActivateKeyTable({ name = 'manage_panes_mode', one_shot = true }),
  },
  {
    key = '|',
    mods = 'CTRL|SHIFT',
    action = act.ActivateKeyTable({ name = 'manage_panes_mode', one_shot = false }),
  },
  { key = 'p', mods = super, action = act.ActivateCommandPalette },
  { key = 'P', mods = super, action = act.ActivateCommandPalette },
  -- other
  { key = 'C', mods = super, action = act.ActivateCopyMode },
  { key = 's', mods = super, action = act.QuickSelect },
  { key = 'w', mods = super, action = act.CloseCurrentPane({ confirm = true }) },
  { key = 't', mods = super, action = act.SpawnTab('CurrentPaneDomain') },
  { key = 'c', mods = super, action = act.CopyTo('Clipboard') },
  { key = 'v', mods = super, action = act.PasteFrom('Clipboard') },
}
config.key_tables = {
  manage_panes_mode = {
    -- Split Pane
    { key = '|', action = act.SplitHorizontal },
    { key = '\\', action = act.SplitHorizontal },
    { key = '-', action = act.SplitVertical },
    -- Move Pane
    { key = 'h', action = act({ ActivatePaneDirection = 'Left' }) },
    { key = 'l', action = act({ ActivatePaneDirection = 'Right' }) },
    { key = 'k', action = act({ ActivatePaneDirection = 'Up' }) },
    { key = 'j', action = act({ ActivatePaneDirection = 'Down' }) },
    -- Toggle Pane Zoom
    { key = 'z', action = act.TogglePaneZoomState },
    -- Pane Selection
    -- { key = "s", action = act.PaneSelect({ mode = "Activate" }) },
    -- Swap Panes
    { key = 's', action = act.PaneSelect({ mode = 'SwapWithActive' }) },
    -- Resize Pane
    { key = 'H', action = act.AdjustPaneSize({ 'Left', 5 }) },
    { key = 'J', action = act.AdjustPaneSize({ 'Down', 5 }) },
    { key = 'K', action = act.AdjustPaneSize({ 'Up', 5 }) },
    { key = 'L', action = act.AdjustPaneSize({ 'Right', 5 }) },
    -- Close Pane
    { key = 'w', action = act.CloseCurrentPane({ confirm = true }) },
    -- TODO: want to wezterm cli move-pane-to-new-tab but I don't know how
    -- Cancel the mode by pressing escape
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'Enter', action = 'PopKeyTable' },
  },
}

-- mouse binding
config.mouse_bindings = {
  -- Allow Cmd or CTRL click to open links like in iterm2
  { event = { Up = { streak = 1, button = 'Left' } }, mods = 'SUPER', action = 'OpenLinkAtMouseCursor' },
  { event = { Up = { streak = 1, button = 'Left' } }, mods = 'CTRL', action = 'OpenLinkAtMouseCursor' },
  -- Change the default click behavior so that it only selects
  -- text and doesn't open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = act({ CompleteSelection = 'PrimarySelection' }),
  },
}

return config
