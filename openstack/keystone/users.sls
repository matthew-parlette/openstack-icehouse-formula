{% for tenant,users in salt['pillar.get']('openstack:keystone:tenants',{}).iteritems() %}
{% for user,details in users['users'].iteritems() %}

{{ user }}-user:
  keystone.user_present:
    - name: {{ user }}
    - password: {{ details['password'] }}
    - email: {{ details['email'] }}
    - tenant: {{ tenant }}
    - roles:
      - {{ tenant }}: {{ details['roles'] }}

{% endfor %}
{% endfor %}
