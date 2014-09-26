python-mysqldb:
  pkg.installed

{% for service,options in salt['pillar.get']('openstack:mysql').items() %}
{{ service }}-db:
  mysql_database.present:
    - name: {{ service }}
{% endfor %}
