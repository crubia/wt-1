# -*- coding: utf-8 -*-
from bottle import get, request, run
import alfresco
import settings
from tokens import newToken
from dataStore import DataStore

@get('/validate')
def validate():
    ip = request.query['IP']

    test = alfresco.Alfresco
    test.base_url = "http://" + ip + ":8080"
    resul = alfresco.run_test(test)
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

run(host=settings.WS_BIND_IP_ALFRESCO, port=settings.WS_BIND_PORT_ALFRESCO)