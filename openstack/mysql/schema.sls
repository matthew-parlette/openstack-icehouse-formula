{% for service in salt['pillar.get']('openstack:mysql') %}
{{ service }}-db:
  mysql_database.present:
    name: {{ service }}
    require:
      service: openstack.mysql
