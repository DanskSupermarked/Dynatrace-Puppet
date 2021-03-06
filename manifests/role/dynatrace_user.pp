#dynatrace_user
class dynatrace::role::dynatrace_user(
  $dynatrace_owner = $dynatrace::dynatrace_owner,
  $dynatrace_group = $dynatrace::dynatrace_group
) inherits dynatrace {

  validate_string($dynatrace_owner, $dynatrace_group)

  ensure_resource(user, "Create system user '${dynatrace_owner}'", {
    ensure => present,
    name   => $dynatrace_owner,
    system => true
  })

  ensure_resource(group, "Create group '${dynatrace_group}'", {
    ensure  => present,
    name    => $dynatrace_group,
    members => [$dynatrace_owner],
    require => User["Create system user '${dynatrace_owner}'"]
  })
}
