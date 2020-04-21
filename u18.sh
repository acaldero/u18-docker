#!/bin/bash
#set -x


#
# Usage
#

if [ $# -eq 0 ]; then
	$0 help
	exit
fi


#
# for each argument, try to execute it
#

. ./.env

CO_NAME=$COMPOSE_PROJECT_NAME"_node_1"

for arg_i in "$@"
do
	case $arg_i in
	     build)
		docker image build -f u18-dockerfile .
	     ;;
	     start)
		docker-compose -f u18-dockercompose.yml up -d
	     ;;
	     status)
		docker ps
	     ;;
	     bash)
		docker exec -it $CO_NAME /bin/bash
	     ;;
	     stop)
		docker-compose -f u18-dockercompose.yml down
	     ;;
	     cleanup)
                docker rm      -f $(docker ps     -a -q)
                docker rmi     -f $(docker images -a -q)
                docker volume rm  $(docker volume ls -q)
                docker network rm $(docker network ls|tail -n+2|awk '{if($2 !~ /bridge|none|host/){ print $1 }}')
	     ;;
	     help)
		echo ""
		echo "Usage: $0 <build|start|status|bash|stop|cleanup>"
		echo ""
	     ;;
	     *)
		echo ""
		echo "Unknow command:"
                $0 help
	     ;;
	esac
done


