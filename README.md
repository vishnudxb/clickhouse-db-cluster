# clickhouse-db-cluster github action

A github action to run clickhouse db with 2 shards / 2 replica with ZooKeeper.

To setup a local cluster for development purposes, please run the following:

```sh

# Install Minikube
make install
# Start the cluster
make start

```

It will likely take a few minutes for everything to bootup.

```sh

# Check on the cluster status
make status

```

Once you are done with the clutser - you can stop or delete it.

```sh

# Stop the cluster
make stop
# Delete the cluster
make delete

```

## If you're using Github actions as your CI/CD, please check this [workflow](https://github.com/vishnudxb/clickhouse-db-cluster/blob/master/.github/workflows/main.yml)


| **GitHub Action**  |
|:------------------:| 
| [![Testing clickhouse db action](https://github.com/vishnudxb/clickhouse-db-cluster/actions/workflows/main.yml/badge.svg)](https://github.com/vishnudxb/clickhouse-db-cluster/actions/workflows/main.yml) |
