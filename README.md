# centos-ssh commands

Construire l'image
```
make build
```

Si fichier .ssh/authorized_keys embarqué dans l'image (Ancienne version)
```
docker container run --rm --detach --name sshd clevandowski/centos-sshd
```


Si fichier .ssh/authorized_keys monté dans le container
(Nécessite le répertoire ssh en ```chmod 700``` et le fichier ssh/authorized_keys en ```chmod 600```)
```
docker container run --rm --detach --name sshd -v ssh:/home/guest/.ssh clevandowski/centos-sshd
```

Se logguer au container (vérifier son ip avec ```docker container inspect sshd```)
```
ssh -i .ssh/id_rsa guest@172.17.0.2
```

Se lancer un bash via ```docker exec```
```
docker exec -ti sshd /bin/bash
```

Arrêt
```
docker container stop sshd
```

Récupérer le port exposé
```
$ minikube -n app-cluster service sshd --url
http://192.168.99.100:32509
```

Se connecter en ssh au service dans kubernetes
```
ssh -i .ssh/id_rsa guest@192.168.99.100 -p 32509
```

Se connecter sur le pod
```
kubectl -n app-cluster exec -ti $(kubectl -n app-cluster get pods | grep sshd | awk '{ print $1 }') /bin/bash
```

Voir le status du pod
```
watch kubectl -n app-cluster get pods
```

Appliquer les changements dans le déploiement
```
kubectl -n app-cluster apply -f sshd-deployment.yaml
```