# Docker Container for Google PubSub emulator

The gcloud suite has an emulator for Google PubSub, which is great for testing locally how to run code against their APIs. 

However, it is not very useful if you want to run in a containerized environment, and want to test how the whole thing behaves. Hence this container. 

# How to use

```
$ docker pull lucasamorim/pubsub
$ docker run -it --name pubsub-emulator -p 8042:8042 lucasamorim/pubsub
```

Now you need to run the equivalent of the ```$(gcloud beta emulators pubsub env-init)``` command

```
$ export PUBSUB_EMULATOR_HOST=localhost:8042
```

Now you can use the standard APIs such as [gcloud-python](https://github.com/googlecloudplatform/gcloud-python) to interact with it. 

# ENV VARIABLES / TWEAKS
## Data Store

You can bind a volume to /data in the container to get resilient data. 

```
$ docker run -it --name pubsub-emulator -p 8042:8042 -v /path/to/my/data/folder:/data lucasamorim/pubsub
```

## Port

You can also change the port where the emulator runs by editing the HOST_PORT environment variable. 

## Logs

You can check the emulator logs with `docker logs`




