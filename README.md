<p align="right">
    <a href="https://travis-ci.org/epiloque/ansible-ntp">
        <img src="https://travis-ci.org/epiloque/ansible-ntp.svg?branch=master"
             alt="build status">
    </a>
        <a href="https://galaxy.ansible.com/epiloque/ntp">
        <img src="https://img.shields.io/badge/ansible--galaxy-ntp-blue.svg"
             alt="ansible galaxy">
    </a>
</p>

ntp role

## Role Variables

Available variables are listed below, along with default values:

```yaml
ntp_servers:
  - "0.pool.ntp.org"
  - "1.pool.ntp.org"
  - "2.pool.ntp.org"
  - "3.pool.ntp.org"

ntp_server_options: iburst
ntp_stratumweight: 0.001
```


## Example Playbook

```yaml
- hosts: servers
  roles:
    - epiloque.ntp
```

## License

BSD
