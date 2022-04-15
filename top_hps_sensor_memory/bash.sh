#!/bin/bash

PATH_LOCAL=""
PATH_REMOTE="/home/root"
SERVIDORIP="192.168.1.2"
NAMEFILE="FPGAHPS_MAIN"


synToServers(){
	scp ${NAMEFILE} root@${SERVIDORIP}:${PATH_REMOTE}
}

synToServers
