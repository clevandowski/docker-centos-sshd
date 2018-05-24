# centos-ssh commands

```
make build
```

Si fichier .ssh/authorized_keys embarqué dans l'image

```
docker container run --rm --detach --name sshd clevandowski/centos-sshd
```


Si fichier .ssh/authorized_keys monté dans le container
(Nécessite le répertoire ssh en ```chmod 700``` et le fichier ssh/authorized_keys en ```chmod 600```)

```
docker container run --rm --detach --name sshd -v ssh:/home/guest/.ssh clevandowski/centos-sshd
```


ssh -i .ssh/id_rsa guest@172.17.0.2

docker exec -ti sshd /bin/bash

docker container stop sshd
