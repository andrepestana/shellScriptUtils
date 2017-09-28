

#### linux date timestamp
date '+%Y-%m-%d %H:%M:%S.%3N'


#### exchange ssh keys
ssh-keygen -t rsa  
for server in  server_01 server_02 ; do ssh-copy-id -i .ssh/id_rsa.pub $server ; done ;
###  remove exchanged keys
ssh -q $server "rm -rf .ssh/authorized_keys;" 


