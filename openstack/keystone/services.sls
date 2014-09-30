{% for service,details in salt['pillar.get']('openstack:keystone:services',{}).iteritems() %}

{{ service }}-service:
  keystone.service_present:
    - name: {{ service }}
    - service_type: {{ details['service_type'] }}
    - description: {{ details['description'] }}

{{ service }}-endpoint:
  keystone.endpoint_present:
    - name: {{ service }}
    - adminurl: {{ details['endpoint']['adminurl'] }}
    - internalurl: {{ details['endpoint']['internalurl'] }}
    - publicurl: {{ details['endpoint']['publicurl'] }}

{% endfor %}
