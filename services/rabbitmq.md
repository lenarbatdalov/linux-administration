# Docker
```
docker pull rabbitmq
```

# Running the daemon
```
docker run -d --hostname my-rabbit --name some-rabbit rabbitmq
docker stop some-rabbit

docker run -it --rm --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3-management
```

# установил через магазин приложений manjaro gnome
```
далее
sudo rabbitmq-plugins enable rabbitmq_mqtt
sudo rabbitmq-plugins enable rabbitmq_management
```

# localhost[http://localhost:15672/]
```
guest/guest
```

