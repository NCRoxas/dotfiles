local status_ok, tc = pcall(require, "textcase")
if not status_ok then
    return
end

tc.setup {}
