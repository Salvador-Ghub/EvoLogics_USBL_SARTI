# -*- coding: utf-8 -*-
"""

All credits to https://www.instructables.com/member/swarajdh/
Published Oct 8th, 2017 - https://www.instructables.com/id/Netcat-in-Python/

Created on Thu May  7 20:26:35 2020
Plataforma para utilizar Python como netcat
conexión TCP abierta y cerrada por cada llamada
@author: Salvador
"""

#import sys
import socket
import time

#obtener argumentos de dirección
hostname="10.42.57.1"  #"10.42.57.2" 
#sys.argv[1]
port=9200
#int(sys.argv[2])

def netcat(hn, p, content):
    #inicializa la conexión
    sock=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    sock.connect((hn,p))
    
    sock.sendall(content)
    time.sleep(0.5)
    sock.shutdown(socket.SHUT_WR)
    
    res=""
    
    while True:
        data=sock.recv(2048)
        if(not data):
            break
        res+=data.decode()
    
    print(res)
    
    print("Conexión cerrada.")
    sock.close()

content="AT?S\n\n"
netcat(hostname,port,content.encode())