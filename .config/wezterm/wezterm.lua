local wezterm = require 'wezterm';

return {
    font = wezterm.font_with_fallback {
        {family = 'Menlo', weight = 'DemiBold' },
        {family = 'HackGen35 Console NF', weight = 'DemiBold' },
        'Menlo',
        'HackGen35 Console NF',
    },
    -- freetype_load_target = "Light",
    -- freetype_render_target = "HorizontalLcd",
    font_size = 16,
    color_scheme = "iceberg-dark",
    use_ime = true,
    hide_tab_bar_if_only_one_tab = true,
    adjust_window_size_when_changing_font_size = false,
    hyperlink_rules = {
        {
            regex = '\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b',
            format = '$0',
        },
    },
    window_decorations = 'RESIZE',
}

