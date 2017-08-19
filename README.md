# Containerized Syncthing

Syncthing in a container. Combine with volumes. The exposed volumes are
by default:

 - /var/syncthing/config - the configuration and index directory
 - /var/syncthing/Sync - the default folder

You can add more folders and map them as you prefer.

Example usage:

```
$ docker pull syncthing/syncthing
$ docker run -p 8384:8384 -p 22000:22000 \
    -v /wherever/st-cfg:/var/syncthing/config \
    -v /wherever/st-sync:/var/syncthing/Sync \
    syncthing/syncthing:latest
```

Note that local device discovery will not work with the above command resulting
in poor local transfer rates if local device addresses are not manually
configured.

To allow local discovery, the docker host network can be used instead:

```
$ docker pull syncthing/syncthing
$ docker run --network=host \
    -v /wherever/st-cfg:/var/syncthing/config \
    -v /wherever/st-sync:/var/syncthing/Sync \
    syncthing/syncthing:latest
```

Be aware that syncthing alone is now in control of what interfaces and ports it
listens on. You can edit the syncthing configuration to change the defaults if
there are conflicts.

## License

The things in this repository are licensed under the MIT license.
Syncthing is distributed under Syncthing's own licensing.

