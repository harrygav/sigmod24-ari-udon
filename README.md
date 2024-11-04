# Dockerfile for building Udon

## build docker image
`docker build -t udon:latest .`

## Start container
`docker run --rm -d --name udon -p 8080:8080 udon:latest`

## Copy experiment datasets to container
Coco dataset:

`docker cp core/experiment-related/datasets/val2017 udon:/tmp`

TPC-H Lineitem dataset:

`docker cp core/experiment-related/datasets/lineitem.tbl udon:/tmp`

Twitter dataset:

`docker cp core/experiment-related/datasets/twitter-dataset-for-udon-experiment.csv udon:/tmp`

## Enter container and start Udon
`docker exec -it udon bash -c "./deploy-daemon.sh"`

## Open the web interface
located at [localhost:8080](http://localhost:8080)

## Configurations

For W2 edit the UDF:
```python
import en_core_web_sm
nlp = en_core_web_sm.load()
```