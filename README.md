# Dockerfile for building Udon

## build docker image
`docker build -t udon:latest .`

## Start container
`docker run --rm -d --name udon -p 8080:8080 udon:latest`

## Copy sample files to container
Coco dataset:
`docker cp core/experiment-related/val2017 udon:/tmp`
TPC-H Lineitem dataset:
`docker cp core/experiment-related/lineitem.tbl udon:/tmp`
Twitter dataset:
`docker cp core/experiment-related/twitter-dataset-for-udon-experiment.csv udon:/tmp`

## Enter container and start Udon
`docker exec udon bash -c"./deploy.sh"`

## Open the web interface
which is located at (localhost:8080)[http://localhost:8080]
