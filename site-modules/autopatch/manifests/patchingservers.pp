class autopatch {
  # 1 Get filesystem utilization and free space from facts
  $boot_fs = $facts['filesystems']['/boot']
  $utilization = $boot_fs['capacity_bytes']['percent_used']
  $free_space = $boot_fs['available_bytes'] / 1024 / 1024 # Convert bytes to MB

  # Check conditions and generate message
  if $utilization >= 60 {
    if $free_space > 100 {
      $message = "Linux boot filesystem is ${utilization}% utilized and has more than 100MB free."
    } else {
      $message = "Linux boot filesystem is ${utilization}% utilized but has less than 100MB free."
    }
  } else {
    $message = 'Linux boot filesystem utilization is acceptable.'
  }

  # Report the message
  notify { 'boot_filesystem_status':
    message  => $message,
    # Ensure the message is always shown
    loglevel => 'notice',
  }
}
