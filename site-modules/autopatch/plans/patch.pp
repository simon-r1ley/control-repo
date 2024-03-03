# plan/patch.pp
plan autopatch::patch (
  TargetSpec $targets,
) {
  $rootstatus = run_task('autopatch::checkingroot', $targets)

  if $rootstatus != Integer('0') {
    fail_plan('Root partition is full')
  }

  $patchstatus = run_task('autopatch::patch', $targets)

  if $patchstatus != 0 {
    fail_plan('patching failed')
  }
}
