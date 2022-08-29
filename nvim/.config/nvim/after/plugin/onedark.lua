local status, onedark = pcall(require, "onedark")
if (not status) then return end

onedark.setup {
    style = 'warmer',
    transparent = false,
    code_style = {
      comments = 'italic',
      keywords = 'none',
    },
}
onedark.load()
