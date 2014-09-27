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
        - admin_token: 
      sql:
        - connection: 
    - require:
      - file: keystone
