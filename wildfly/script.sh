#!/bin/bash
# 起動
/opt/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 &

# 起動待ち
sleep 3
RET=1
while [ $RET != 0 ]
do
	/opt/wildfly/bin/jboss-cli.sh --connect ls
	RET=$?
	sleep 3
done

# ユーザ作成
/opt/wildfly/bin/add-user.sh -u admin -p password

# データソース作成
#cat /tmp/jboss-cli.txt | /opt/wildfly/bin/jboss-cli.sh

# ajp
/opt/wildfly/bin/jboss-cli.sh --connect '/subsystem=undertow/server=default-server/ajp-listener=myListener:add(socket-binding=ajp, scheme=http)'

# デプロイ
/opt/wildfly/bin/jboss-cli.sh --connect 'deploy /tmp/docker-example.war'

# exit対策
tail -f /dev/null
