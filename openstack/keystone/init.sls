keystone:
  pkg.latest:
    - require:
      - mysql_grants: {{ grains['id'] }}-keystone-account
  service.running:
    - watch:
      - pkg: keystone
      - ini: keystone
  file.managed:
    - name: /etc/keystone/keystone.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: keystone
  ini.options_present:
    - name: /etc/keystone/keystone.conf
    - sections:
      DEFAULT:
        - admin_token: {{ salt['pillar.get']('openstack:token:admin') }}
      sql:
        {% set db = pillar['openstack']['mysql']['keystone'] %}
        {% set controller = pillar['openstack']['controller'][0] %}
        - connection: mysql://{{ db['username'] }}:{{ db['password'] }}@{{ controller }}/keystone
    - require:
      - file: keystone

keystone_sync:
  cmd.run:
    - name: keystone-manage db_sync
    - user: keystone
    - require:
      - pkg: keystone
      - service: keystone

keystone_sqlite_delete:
  file.absent:
    - name: /var/lib/keystone/keystone.sqlite
    - require:
      - pkg: keystone
