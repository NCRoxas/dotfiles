local tc_status_ok, tc = pcall(require, "textcase")
local tr_status_ok, tr = pcall(require, "trouble")
if not (tc_status_ok and tr_status_ok) then
  return
end

tc.setup {}
tr.setup {}
