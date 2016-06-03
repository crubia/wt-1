# -*- coding: utf-8 -*-
import string
import random
from dataStore import DataStore

def newToken(size=6, chars=string.ascii_uppercase + string.ascii_lowercase + string.digits, datastore=None):
    '''
    Generates a new token. 'size' indicates de number of characters. 'chars' the allowed characters
    and 'datastore' the target datastore (if any, it will be checked that the token does not exists).
    '''
    exists = True
    token = None
    while exists:
        token = ''.join(random.choice(chars) for _ in range(size))
        if isinstance(datastore, DataStore)==False:
            exists = False
        elif datastore.checkIfExists(token) == False:
            exists = False

    return token