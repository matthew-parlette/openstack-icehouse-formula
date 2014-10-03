glance:
  pkg:
    - installed
  service.running:
    - names:
      - glance-registry
      - glance-api
    - watch:
      - pkg: glance
      - ini: glance-api-conf
      - ini: glance-registry-conf

glance-api-conf:
  file.managed:
    - name: /etc/glance/glance-api.conf
    - mode: 644
    - user: glance
    - group: glance
    - require:
      - pkg: glance
  ini.options_present:
    {% set controller = pillar['openstack']['controller'][0] %}
    - name: /etc/glance/glance-api.conf
    - sections:
        DEFAULT:
          rpc_backend: rabbit
          rabbit_host: {{ controller }}
        database:
          {% set db = pillar['openstack']['mysql']['glance'] %}
          connection: mysql://{{ db['username'] }}:{{ db['password'] }}@{{ controller }}/glance
        keystone_authtoken:
          auth_uri: "http://{{ controller }}:5000"
          auth_port: 35357
          auth_protocol: http
          admin_tenant_name: service
          admin_user: glance
          admin_password: {{ pillar['openstack']['keystone']['tenants']['service']['users']['glance']['password'] }}
          auth_host: {{ controller }}
        paste_deploy:
          flavor: keystone
    - require:
      - file: glance-api-conf

glance-registry-conf:
  file.managed:
    - name: /etc/glance/glance-api.conf
    - mode: 644
    - user: glance
    - group: glance
    - require:
      - pkg: glance
  ini.options_present:
    {% set controller = pillar['openstack']['controller'][0] %}
    - name: /etc/glance/glance-registry.conf
    - sections:
        DEFAULT:
          rpc_backend: rabbit
          rabbit_host: {{ controller }}
        database:
          {% set db = pillar['openstack']['mysql']['glance'] %}
          connection: mysql://{{ db['username'] }}:{{ db['password'] }}@{{ controller }}/glance
        keystone_authtoken:
          auth_uri: "http://{{ controller }}:5000"
          auth_port: 35357
          auth_protocol: http
          admin_tenant_name: service
          admin_user: glance
          admin_password: {{ pillar['openstack']['keystone']['tenants']['service']['users']['glance']['password'] }}
          auth_host: {{ controller }}
        paste_deploy:
          flavor: keystone
    - require:
      - file: glance-registry-conf

glance-sync:
  cmd.run:
    - name: glance-manage db_sync
    - user: glance
    - require:
      - pkg: glance
      - service: glance

glance-sqlite-delete:
  file.absent:
    - name: /var/lib/glance/glance.sqlite
    - require:
      - pkg: glance
