#!/bin/bash
#$EAP_HOME/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 &
serverstate="$(./jboss-cli.sh -c "read-attribute server-state")"
while [ "$serverstate" != "running" ]; do
    sleep 5
    serverstate="$(./jboss-cli.sh -c "read-attribute server-state")"
    echo 'wating... status: '$serverstate
done
touch $EAP_HOME/standalone/deployments/ROOT.war.dodeploy
echo 'Ok is done liferay was sended'
