# -*- coding: utf-8 -*-

# web service settings
WS_BIND_IP_REDMINE = '0.0.0.0'
"""Host ip to bind"""
WS_BIND_PORT_REDMINE = 6969
"""Port to bind"""
WS_BIND_IP_ALFRESCO = '0.0.0.0'
"""Host ip to bind"""
WS_BIND_PORT_ALFRESCO = 7070
"""Port to bind"""

# datastore settings
DS_REDIS_HOST = 'localhost'
""" In case of 'redis' datastore, host that hosts the redis server. """

DS_REDIS_PORT = 6379
""" In case of 'redis' datastore, port where the redis server will be listening. """

DS_REDIS_PASSWORD = ''
""" In case of 'redis' datastore, password for server. """

DS_REDIS_DB = 0
""" In case of 'redis' datastore, redis DB. By default 0. """