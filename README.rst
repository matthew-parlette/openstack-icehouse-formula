==========================
openstack-icehouse-formula
==========================

A saltstack formula for openstack icehouse on ubuntu.

.. note::

    There are no requirements in these states.
    It is expected that they are used with orchestration to execute the states
    in the correct order.

Available states
================

.. contents::
    :local:

``rabbitmq``
------------

Installs and runs the rabbitmq-server service.

``mysql``
------------
Install mysql package and setup my.cnf for openstack usage.

``mysql.client``
------------
Install the mysql python client

``mysql.schema``
------------
Add database accounts for openstack services according to pillar data.

``keystone``
------------
Install keystone package and run db_sync.

``keystone.tenants``
------------
Add tenants to keystone based on pillar data.

``keystone.services``
------------
Add services and roles to keystone based on pillar data.

``keystone.users``
------------
Add users to keystone based on pillar data.
