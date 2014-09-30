{% for tenant in salt['pillar.get']('openstack:keystone:tenants',{}) %}
{% for user,settings in tenant[users].iteritems() %}

{{ user }}-user:
  keystone.user_present:
    - name: {{ user }}
    - password: {{ settings['password'] }}
    - email: {{ settings['email'] }}
    - tenant: {{ tenant }}
    - roles:
      - {{ tenant }}: {{ settings['roles'] }}

{% endfor %}
{% endfor %}
