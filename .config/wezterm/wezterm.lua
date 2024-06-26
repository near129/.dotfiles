local wezterm = require('wezterm')
local act = wezterm.action

local is_mac = wezterm.target_triple:find('darwin')
local is_windows = wezterm.target_triple:find('windows')
local is_linux = wezterm.target_triple:find('linux')

wezterm.on('update-right-status', function(window, pane)
  local key_table = window:active_key_table()
  local domain = pane:get_domain_name()
  if domain == 'local' then
    domain = nil
  else
    domain = 'In 🌐' .. domain .. '  '
  end

  window:set_right_status(wezterm.format({
    { Attribute = { Underline = 'Single' } },
    { Text = domain or '' },
    { Text = (key_table or '') .. '  ' },
  }))
end)

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
  config.freetype_load_flags = "NO_BITMAP" -- for monaco. ref: https://github.com/wez/wezterm/issues/2523
else
  config.font = wezterm.font_with_fallback({
    'HackGen35 Console NF',
  })
end
config.font_size = 14

--appearance
config.color_scheme = 'iceberg-dark'
config.adjust_window_size_when_changing_font_size = false
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
config.window_padding = { left = 5, right = 5, top = 0, bottom = 0 }

--key binding
local super = is_mac and 'CMD' or 'ALT'
config.keys = {
  { key = 'l', mods = super, action = act.ShowLauncher },
  {
    key = '\\',
    mods = 'CTRL',
    action = act.ActivateKeyTable({ name = 'manage_panes', one_shot = true }),
  },
  {
    key = '|',
    mods = 'CTRL|SHIFT',
    action = act.ActivateKeyTable({ name = 'manage_panes', one_shot = false }),
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
  manage_panes = {
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

-- other
config.use_ime = true
config.hyperlink_rules = { { regex = '\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b', format = '$0' } }
config.quick_select_patterns = {
  '-(?:-\\w{2,20})+', -- example: --dry-run, --path
}

return config
