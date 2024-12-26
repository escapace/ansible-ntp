ntp = policy.todnames(filter_strings({
  {% for server in ntp_servers %}
  '{{ server.hostname }}.',
  {% endfor %}
}))

policy.add(policy.suffix(policy.FLAGS({ 'NO_CACHE', 'NO_EDNS', 'NO_0X20' }), ntp))
policy.add(policy.suffix(policy.STUB({
  {% for dns in ntp_dns_forward %}
  '{{ dns }}',
  {% endfor %}
 }), ntp))
