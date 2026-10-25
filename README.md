# ansible-ntp

Configures chrony on Red Hat-family systems, removes the legacy `ntp` package,
and sets the timezone to UTC. Requires root privileges, gathered facts, and
systemd. Enables chronyd at boot without starting it during image construction;
configuration changes restart only already-running services. Other OS families
are left unchanged.

## Variables

- `ntp_servers`: list of server mappings. Defaults to `0.pool.ntp.org` through
  `3.pool.ntp.org`, each with `pool: true` and `iburst: true`. Each mapping requires
  `hostname`; optional chrony settings are `pool`, `iburst`, `nts`, `prefer`,
  `trust`, `xleave` (booleans), and `minpoll`, `maxpoll`, `maxsources`, `filter`
  (integers). Poll intervals are powers of two in seconds. `maxsources` applies
  only to pools; `filter` is emitted only above `1`.
- `ntp_step_threshold`: clock-step threshold in seconds. Defaults to `-1`, which
  uses `1.0` seconds for the first three updates. `0` disables stepping; positive
  values set the threshold for those updates.
- `ntp_min_sources`: minimum selectable sources required to adjust the clock.
  Defaults to `1`; values above `1` emit `minsources`.
- `ntp_max_distance`: maximum root distance in seconds. Defaults to `0`, which
  leaves chrony's default unchanged.
- `ntp_daemon_options`: chronyd command-line options. Defaults to `-F 2`.
- `ntp_dns_forward`: DNS forwarder mappings with an IP `address` and optional
  integer `port` (default `53`, range `1`–`65535`). Defaults to Cloudflare, Google,
  and Quad9 public DNS addresses over IPv4 and IPv6. Used only by the optional
  Knot Resolver integration.

## Optional DNS integration

The role has no role dependencies and does not install EPEL. Chrony and tzdata
must be available from the host's configured repositories; both are in BaseOS
on CentOS Stream 10, the tested platform.

When `/etc/knot-resolver/config.d` exists, the role writes an NTP DNS policy and
restarts Knot Resolver only if it is already running. Install and configure the
resolver first. Its `config.yaml` must explicitly set `network.do-ipv4` and
`network.do-ipv6` to booleans, enable at least one family, and load Lua drop-ins
from `config.d`. The `knot-resolver` group must exist. An incomplete installation
fails rather than silently skipping the integration.

The policy uses the installed resolver's address-family settings, not variables
from another role. Supply at least one `ntp_dns_forward` address in an enabled
family. If the directory is absent, the role skips the integration and does not
create it. The `kresd-conf` tag selects integration tasks within this role.
