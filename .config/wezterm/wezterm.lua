local wezterm = require("wezterm")
local act = wezterm.action

wezterm.on("update-right-status", function(window, _)
    -- todo copy mode
	local key_table = window:active_key_table()
	window:set_right_status(
		wezterm.format({
			{ Foreground = { Color = "#434C5E" } },
			{ Background = { Color = "#8FBCBB" } },
			{ Text = key_table or "" },
		})
	)
end)

return {
	-- font
	font = wezterm.font_with_fallback({
		"Monaco",
		-- 'HackGen35 Console NF',
	}),
	freetype_load_flags = "NO_BITMAP",
	font_size = 12,
	-- appearance
	color_scheme = "iceberg-dark",
	hide_tab_bar_if_only_one_tab = true,
	adjust_window_size_when_changing_font_size = false,
	window_decorations = "RESIZE",
	window_padding = { left = 5, right = 5, top = 0, bottom = 0 },
	-- key binding
	-- leader = { key = "a", mods = "SUPER", timeout_milliseconds = 1000 },
	keys = {
		-- split pane
		-- { key = "|", mods = "LEADER", action = act.SplitHorizontal },
		-- { key = "-", mods = "LEADER", action = act.SplitVertical },
		-- { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
		-- { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
		-- { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
		-- { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
		-- { key = "p", mods = "LEADER", action = act.PaneSelect },
		{
			key = "p",
			mods = "SUPER",
			action = act.ActivateKeyTable({ name = "manage_panes", one_shot = true}),
		},
		{
			key = "P",
			mods = "SUPER",
			action = act.ActivateKeyTable({ name = "manage_panes", one_shot = false}),
		},
		-- other
		{ key = "C", mods = "SUPER", action = act.ActivateCopyMode },
		{ key = "s", mods = "SUPER", action = act.QuickSelect },
		{ key = "w", mods = "SUPER", action = act.CloseCurrentPane({ confirm = true }) },
	},
	key_tables = {
		manage_panes = {
			-- Split Pane
			{ key = "|", action = act.SplitHorizontal },
			{ key = "-", action = act.SplitVertical },
			-- Move Pane
			{ key = "h", action = act({ ActivatePaneDirection = "Left" }) },
			{ key = "l", action = act({ ActivatePaneDirection = "Right" }) },
			{ key = "k", action = act({ ActivatePaneDirection = "Up" }) },
			{ key = "j", action = act({ ActivatePaneDirection = "Down" }) },
			-- Toggle Pane Zoom
			{ key = "z", action = act.TogglePaneZoomState },
			-- Pane Selection
			-- { key = "s", action = act.PaneSelect({ mode = "Activate" }) },
			-- Swap Panes
			{ key = "s", action = act.PaneSelect({ mode = "SwapWithActive" }) },
			-- Resize Pane
			{ key = "H", action = act.AdjustPaneSize({ "Left", 5 }) },
			{ key = "J", action = act.AdjustPaneSize({ "Down", 5 }) },
			{ key = "K", action = act.AdjustPaneSize({ "Up", 5 }) },
			{ key = "L", action = act.AdjustPaneSize({ "Right", 5 }) },
            -- Close Pane 
            { key = "w", mods = "SUPER", action = act.CloseCurrentPane({ confirm = true }) },
            -- TODO: want to wezterm cli move-pane-to-new-tab but I don't know how
			-- Cancel the mode by pressing escape
			{ key = "Escape", action = "PopKeyTable" },
			{ key = "Enter", action = "PopKeyTable" },
		},
	},
	-- mouse binding
	mouse_bindings = {
		-- Allow Cmd or CTRL click to open links like in iterm2
		{ event = { Up = { streak = 1, button = "Left" } }, mods = "SUPER", action = "OpenLinkAtMouseCursor" },
		{ event = { Up = { streak = 1, button = "Left" } }, mods = "CTRL", action = "OpenLinkAtMouseCursor" },
		-- Change the default click behavior so that it only selects
		-- text and doesn't open hyperlinks
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "NONE",
			action = act({ CompleteSelection = "PrimarySelection" }),
		},
	},
	--other
	use_ime = true,
	hyperlink_rules = { { regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b", format = "$0" } },
}
