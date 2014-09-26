{% for service,options in salt['pillar.get']('openstack:mysql').items() %}
{{ service }}-db:
  mysql_database.present:
    - name: {{ service }}

{% for server in salt['pillar.get']('openstack:controller',[]) %}
{{ server }}-{{ service }}-account:
  mysql_user.present:
    - name: {{ options['username'] }}
    - password: {{ options['password'] }}
    - host: {{ server }}
    - require:
      - mysql_database: {{ service }}-db
  mysql_grants.present:
    - grant: all
    - database: {{ service }}
    - user: {{ options['username'] }}
    - host: {{ server }}
    - password: {{ options['password'] }}
    - require:
      - mysql_user: {{ server }}-{{ service }}-account
{% endfor %}
{% endfor %}
