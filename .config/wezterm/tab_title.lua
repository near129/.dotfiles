local wezterm = require('wezterm')

local PROGRAM_ICONS = {
  claude = '✳',
  codex = wezterm.nerdfonts.cod_terminal,
  opencode = wezterm.nerdfonts.md_square_medium_outline,
  zsh = wezterm.nerdfonts.dev_terminal,
  fish = wezterm.nerdfonts.md_fish,
  bash = wezterm.nerdfonts.cod_terminal_bash,
  nvim = wezterm.nerdfonts.custom_vim,
  vim = wezterm.nerdfonts.dev_vim,
  cargo = wezterm.nerdfonts.dev_rust,
  rustc = wezterm.nerdfonts.dev_rust,
  docker = wezterm.nerdfonts.dev_docker,
  ['docker-compose'] = wezterm.nerdfonts.dev_docker,
  git = wezterm.nerdfonts.dev_git,
  gh = wezterm.nerdfonts.dev_github_badge,
  go = wezterm.nerdfonts.seti_go,
  nix = wezterm.nerdfonts.linux_nixos,
  nh = wezterm.nerdfonts.linux_nixos,
  node = wezterm.nerdfonts.md_nodejs,
  npm = wezterm.nerdfonts.md_npm,
  pnpm = wezterm.nerdfonts.md_npm,
  ssh = wezterm.nerdfonts.md_ssh,
  python = wezterm.nerdfonts.dev_python,
  python3 = wezterm.nerdfonts.dev_python,
  uv = wezterm.nerdfonts.dev_python,
}

local DEFAULT_ICON = wezterm.nerdfonts.md_application
local SEPARATOR = '|'

local PCT_GLYPHS = {
  wezterm.nerdfonts.md_circle_slice_1,
  wezterm.nerdfonts.md_circle_slice_2,
  wezterm.nerdfonts.md_circle_slice_3,
  wezterm.nerdfonts.md_circle_slice_4,
  wezterm.nerdfonts.md_circle_slice_5,
  wezterm.nerdfonts.md_circle_slice_6,
  wezterm.nerdfonts.md_circle_slice_7,
  wezterm.nerdfonts.md_circle_slice_8,
}

local function pct_glyph(pct)
  local slot = math.floor(pct / 12)
  return PCT_GLYPHS[slot + 1]
end

local function extract_program_name(process_path)
  if not process_path then
    return nil
  end
  return process_path:match('([^/\\]+)$')
end

local function get_program_icon(program_name)
  if not program_name then
    return DEFAULT_ICON
  end
  local normalized = program_name:lower()
  return PROGRAM_ICONS[normalized] or DEFAULT_ICON
end

local function format_progress(progress)
  if progress == nil or progress == 'None' then
    return nil
  end

  local icon, color
  if progress.Percentage ~= nil then
    icon = pct_glyph(progress.Percentage)
    color = 'green'
  elseif progress.Error ~= nil then
    icon = pct_glyph(progress.Error)
    color = 'red'
  elseif progress == 'Indeterminate' then
    icon = wezterm.nerdfonts.md_cog
    color = 'green'
  else
    icon = wezterm.nerdfonts.md_cog
    color = 'yellow'
  end

  return { icon = icon, color = color }
end

local function get_pane_status(pane)
  return format_progress(pane.progress)
end

local function format_pane(pane, is_active)
  local elements = {}
  local program = extract_program_name(pane.foreground_process_name)
  local status = get_pane_status(pane)

  if status then
    table.insert(elements, { Foreground = { Color = status.color } })
    table.insert(elements, { Text = status.icon .. ' ' })
    table.insert(elements, { Foreground = 'Default' })
  end

  if is_active then
    table.insert(elements, { Text = pane.title })
  else
    local icon = get_program_icon(program)
    table.insert(elements, { Text = icon })
  end

  return elements
end

local function setup()
  wezterm.on('format-tab-title', function(tab)
    local tab_panes = tab.panes or { tab.active_pane }
    local elements = {
      { Text = string.format(' %d: ', tab.tab_index + 1) },
    }

    for i, pane in ipairs(tab_panes) do
      if i > 1 then
        table.insert(elements, { Text = SEPARATOR })
      end

      local pane_elements = format_pane(pane, pane.is_active)
      for _, elem in ipairs(pane_elements) do
        table.insert(elements, elem)
      end
    end

    table.insert(elements, { Text = ' ' })
    return elements
  end)
end

return {
  setup = setup,
}
