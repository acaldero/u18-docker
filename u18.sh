#!/bin/bash
#set -x


#
# Usage
#

if [ $# -eq 0 ]; then
	echo ""
	echo "Usage: $0 <build|start|status|bash|stop>"
	echo ""
	exit
fi


#
# for each argument, try to execute it
#

for arg_i in "$@"
do
	case $arg_i in
	     build)
		docker image build -t u18 -f u18-dockerfile .
	     ;;
	     start)
		docker-compose -f u18-dockercompose.yml up -d
	     ;;
	     status)
		docker ps
	     ;;
	     bash)
		docker exec -it u18 /bin/bash
	     ;;
	     stop)
		docker-compose -f u18-dockercompose.yml down
	     ;;
	     *)
		echo ""
		echo "Unknow command:"
		echo "Usage: $0 <build|start|status|bash|stop>"
	     ;;
	esac
done


