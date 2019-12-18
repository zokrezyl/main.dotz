
if not gr.select_engine("de") then return end

de.reset()

de.defstyle("*", {
    shadow_colour = "#000000",
    highlight_colour = "#000000",
    background_colour = "#000000",
    foreground_colour = "#999999",
    padding_pixels = 1,
    highlight_pixels = 1,
    shadow_pixels = 1,
    border_style = "elevated",
    --font = "-*-helvetica-medium-r-normal-*-12-*-*-*-*-*-*-*",
    font = "-*-courier new-medium-r-normal-*-44-*-*-*-*-*-*-*",
    text_align = "center",
})

de.defstyle("frame", {
    based_on = "*",
    shadow_colour = "#000000",
    highlight_colour = "#000000",
    padding_colour = "#111111",
--    transparent_background = true,
--    background_colour = "#000000",
    foreground_colour = "#ffffff",
    padding_pixels = 1,
    highlight_pixels = 0,
    shadow_pixels = 0,
    de.substyle("active", {
        shadow_colour = "#FF0000",
        highlight_colour = "#00FF00",
        padding_colour = "#221111",
        foreground_colour = "#ff00ff",
    }),
})

de.defstyle("frame-ionframe", {
    based_on = "frame",
    border_style = "inlaid",
    padding_pixels = 1,
    spacing = 0,
})

de.defstyle("frame-floatframe", {
    based_on = "frame",
    border_style = "ridge",
})

de.defstyle("tab", {
    based_on = "*",
    font = "-*-monaco-medium-r-normal-*-14-*-*-*-*-*-*-*",
    de.substyle("active-selected", {
        shadow_colour = "#222222",
        highlight_colour = "#000000",
        background_colour = "#552222",
        foreground_colour = "#CCCCCC",
    }),
    de.substyle("active-unselected", {
        shadow_colour = "#444444",
        highlight_colour = "#000000",
        background_colour = "#000000",
        foreground_colour = "#999999",
    }),
    de.substyle("inactive-selected", {
        shadow_colour = "#444444",
        highlight_colour = "#222222",
        background_colour = "#111111",
        foreground_colour = "#AAAAAA",
    }),
    de.substyle("inactive-unselected", {
        shadow_colour = "#444444",
        highlight_colour = "#000000",
        background_colour = "#000000",
        foreground_colour = "#555555",
    }),
    text_align = "center",
})

de.defstyle("tab-frame", {
    based_on = "tab",
    de.substyle("*-*-*-*-activity", {
        shadow_colour = "#444444",
        highlight_colour = "#000000",
        background_colour = "#000000",
        foreground_colour = "#AAAAAA",
    }),
})

de.defstyle("tab-frame-ionframe", {
    based_on = "tab-frame",
    spacing = 1,
})

de.defstyle("tab-menuentry", {
    based_on = "tab",
    font = "-*-helvetica-medium-r-normal-*-44-*-*-*-*-*-*-*",
    text_align = "left",
    highlight_pixels = 0,
    shadow_pixels = 0,
    de.substyle("*-selected", {
        shadow_colour = "#333333",
        highlight_colour = "#333333",
        background_colour = "#444444",
        foreground_colour = "#ffffff",
    }),
    de.substyle("*-unselected", {
        shadow_colour = "#000000",
        highlight_colour = "#000000",
        background_colour = "#000000",
        foreground_colour = "#FFFFFF",
    }),
})

de.defstyle("tab-menuentry-big", {
    based_on = "tab-menuentry",
    font = "-*-helvetica-medium-r-normal-*-44-*-*-*-*-*-*-*",
    padding_pixels = 0,
})

de.defstyle("input", {
    based_on = "*",
    shadow_colour = "#000000",
    highlight_colour = "#000000",
    background_colour = "#000000",
    foreground_colour = "#BBBBBB",
    padding_pixels = 0,
    highlight_pixels = 0,
    shadow_pixels = 0,
    border_style = "elevated",
    de.substyle("*-cursor", {
        background_colour = "#FFFFFF",
        foreground_colour = "#000000",
    }),
    de.substyle("*-selection", {
        background_colour = "#111111",
        foreground_colour = "#ffffff",
    }),
})

de.defstyle("input-menu", {
    based_on = "*",
    font = "-*-courier-new-medium-r-normal-*-44-*-*-*-*-*-*-*",
    de.substyle("active", {
        shadow_colour = "#000000",
        highlight_colour = "#000000",
        background_colour = "#000000",
        foreground_colour = "#AACCAA",
    }),
})

de.defstyle("stdisp-statusbar", {
    based_on = "*",
    font = "-*-courier-new-medium-r-normal-*-24-*-*-*-*-*-*-*",
    highlight_colour = "#000000",
    background_colour = "#331111",
    foreground_colour = "#AAAAAA"
})

gr.refresh()

