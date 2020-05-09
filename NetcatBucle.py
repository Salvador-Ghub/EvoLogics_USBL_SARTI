# -*- coding: utf-8 -*-
"""

All credits to https://www.instructables.com/member/swarajdh/
Published Oct 8th, 2017 - https://www.instructables.com/id/Netcat-in-Python/

Created on Thu May  7 21:02:05 2020
Plataforma para utilizar Python como netcat
conexión TCP cerrada y abierta constantemente
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
    
    
    sock.close()

while 1:
    buf=""
    shouldClose=False
    
    #recoger petición
    inp=input(">>>")
    #while inp != "":
        #detiene el proceso si queremos cerrar la conexión
    if(inp == "netcat close"):
            shouldClose=True
        
    buf +=inp+"\n"
        #inp=input("Pulse enter para obtener respuesta:")
        
    buf+="\n"
    
    if(shouldClose):
        print("Conexión cerrada.")
        break 
    
    netcat(hostname,port,buf.encode())


