# -*- coding: utf-8 -*-
from bottle import get, request, run
import redmine
import settings
from tokens import newToken
from dataStore import DataStore

@get('/validate')
def validate():
    ip = request.query['IP']

    test = redmine.Redmine
    test.base_url = "http://" + ip + ":3000/"
    resul = redmine.run_test(test)
    exito = resul.wasSuccessful() # True si SUCCESSFULL, False si FAILURE 
    exito=('SUCCESSFULL' if exito else 'FAILURE')
    
    ds = DataStore
    ident = newToken(datastore=ds)
    ds().set(key=ident, value=str(exito))

    return ident

@get('/status')
def status():
    ident = request.query['ID']
    ds = DataStore()
    
    if ds.checkIfExists(key=ident):
        resul = ds.get(key=ident)
    else:
        resul = 'NOT EXIST'

    return resul

run(host=settings.WS_BIND_IP_REDMINE, port=settings.WS_BIND_PORT_REDMINE)