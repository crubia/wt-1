# -*- coding: utf-8 -*-
import redis
import settings

class DataStoreError(Exception):
    pass

class DataStore:
    def __init__(self):

        # configuration
        self.cache = redis.StrictRedis(host=settings.DS_REDIS_HOST, port=settings.DS_REDIS_PORT, password=settings.DS_REDIS_PASSWORD,db=settings.DS_REDIS_DB)

    # generic methods

    # def clear(self):
    #     '''
    #     Clears all the information in the datastore
    #     '''
    #     self.cache.clear()

    def set(self, key, value):
        '''
        Sets value to a key
        '''
        self.cache.set(key, value)

    def add(self, listKey, value):
        '''
        Adds a item to a list
        '''
        aux = self.cache.get(listKey)
        if aux == None:
            aux = []
        aux.append(value)
        self.cache.set(listKey, aux)

    def get(self, key):
        '''
        Gets a value from it key
        '''
        return self.cache.get(key)


    def delete(self, key, element=None):
        '''
        Deletes a key-value pair or an element in a list (if element argument is given)
        '''
        if element==None:
            self.cache.delete(key)
        else:
            aux = self.cache.get(key)
            aux.remove(element)
            self.cache.set(key, aux)


    def checkIfExists(self, key, element=None):
        '''
        Checks if a key is defined or if an element exists in a list (if element is given)
        '''
        if element==None:
            if self.cache.get(key) == None:
                return False
            return True
        else:
            aux = self.cache.get(key)
            return element in aux

    def raiseIfDifferent(self, a, b):
        if a != b:
            raise DataStoreError('Error: \'' + a + '\' and \'' + b + '\' are different.')

    def raiseIfNotExists(self, key):
        if self.checkIfExists(key) == False:
            raise DataStoreError('Error: \'' + key + '\' does not exists.')