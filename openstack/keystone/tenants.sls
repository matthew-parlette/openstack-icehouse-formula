{% for tenant in salt['pillar.get']('openstack:keystone:tenants',{}) %}

{{ tenant }}-tenant:
  keystone.tenant_present:
    - name: {{ tenant }}

{% endfor %}

{% for role in salt['pillar.get']('openstack:keystone:roles',{}) %}

{{ role }}-role:
  keystone.role_present:
    - name: {{ role }}

{% endfor %}
