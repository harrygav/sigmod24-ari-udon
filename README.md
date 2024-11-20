# Dockerfile for building Udon

## build docker image
`docker build -t udon:latest .`

## Start container
`docker run --rm -d --name udon -p 8080:8080 udon:latest`

## Set JVM options
Inside `core/amber` create `.jvmopts` and put the following config:

```
-Xms8196M                  # Set minimum heap size to 8196 MB (8 GB)
-Xmx8196M                  # Set maximum heap size to 8196 MB (8 GB)
-Xss6M                     # Set stack size to 6 MB
-XX:ReservedCodeCacheSize=256M  # Set reserved code cache size to 256 MB
-Dfile.encoding=UTF-8      # Set file encoding to UTF-8
```

## Copy experiment datasets to container
Coco dataset:

`docker cp core/experiment-related/datasets/val2017 udon:/tmp`

TPC-H Lineitem dataset:

`docker cp core/experiment-related/datasets/lineitem.tbl udon:/tmp`

Twitter dataset:

`docker cp core/experiment-related/datasets/twitter-dataset-for-udon-experiment.csv udon:/tmp`

## Enter container and start Udon
`docker exec -it udon bash -c "./scripts/deploy-daemon.sh"`

`-s` for skipping compilation

## Open the web interface
located at [localhost:8080](http://localhost:8080)

## Workflow-specific debugger settings
test variable in: `core/amber/src/main/python/core/architecture/managers/udon_experiment_manager.py`

debug optimizations in: `core/amber/src/main/python/core/architecture/managers/debug_manager.py`

## Experiments

Table 1, Figure 18 -> Logs

Figure 19 -> debug manager:

    OP1_ENABLED = False
    OP2_ENABLED = False

Figure 20 -> Scan operator set limit and get from log (UDF + overhead), SET OP1, OP2 to True

Figure 21 -> SET OP1, OP2 to True, (for now) change worker to X

Figure 26 -> W6 Add (copy/paste dummy operators in between)