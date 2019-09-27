Stolon-based HA PostgreSQL Cluster
==================================

Installs a highly-available [PostgreSQL](https://www.postgresql.org) cluster using [Stolon](https://github.com/sorintlab/stolon).

Installing the Chart
--------------------

    $ helm install --name my-release ./postgresql

Configuration
-------------

| Parameter                      | Description                                                                                             | Default                       |
|:-------------------------------|:--------------------------------------------------------------------------------------------------------|:------------------------------|
| `image.repository`             | Image repository                                                                                        | `quay.io/acoustid/postgresql` |
| `image.tag`                    | Image tag                                                                                               | `v2019.09.26-pg11`            |
| `image.pullPolicy`             | Image pull policy                                                                                       | `IfNotPresent`                |
| `serviceAccount.create`        | Create a new service account for the cluster                                                            | `true`                        |
| `serviceAccount.name`          | Name of an existing service account to use                                                              | `nil`                         |
| `persistence.enabled`          | Enable persistence using PVC                                                                            | `true`                        |
| `persistence.storageClassName` | PVC Storage Class for PostgreSQL volume                                                                 | `""`                          |
| `persistence.accessMode`       | PVC Access Mode for PostgreSQL volume                                                                   | `"ReadWriteOnce"`             |
| `persistence.size`             | PVC Storage Request for PostgreSQL volume                                                               | `1Gi`                         |
| `sentinel.replicas`            | Number of replicas for stolon-sentinel                                                                  | `2`                           |
| `sentinel.resources`           | CPU/Memory resource requests/limits for stolon-sentinel                                                 | `{}`                          |
| `proxy.replicas`               | Number of replicas for stolon-proxy                                                                     | `2`                           |
| `proxy.resources`              | CPU/Memory resource requests/limits for stolon-proxy                                                    | `{}`                          |
| `keeper.replicas`              | Number of replicas for stolon-keeper                                                                    | `2`                           |
| `keeper.resources`             | CPU/Memory resource requests/limits for stolon-keeper                                                   | `{}`                          |
| `superuser.username`           | PostgreSQL superuser                                                                                    | `"postgres"`                  |
| `superuser.password`           | PostgreSQL superuser’s password                                                                         | `""`                          |
| `replication.username`         | PostgreSQL replication user                                                                             | `"replication"`               |
| `replication.password`         | PostgreSQL replication user’s password                                                                  | `""`                          |
| `debug`                        | Debug mode                                                                                              | `false`                       |
| `nameOverride`                 | String to partially override postgresql.fullname template with a string (will prepend the release name) | `nil`                         |
| `fullnameOverride`             | String to fully override postgresql.fullname template with a string                                     | `nil`                         |
