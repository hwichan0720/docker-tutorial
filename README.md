# 2022 小町研 新入生向けチュートリアル Docker チュートリアル

発表スライド
https://docs.google.com/presentation/d/1H4uXBLe3Ofpd0BeNZXUlL2Saz5qR26FsAxUjLscYwKs/edit#slide=id.p

# How to use

- [base.dockerfile](https://github.com/hwichan0720/docker-tutorial/blob/master/dockerfiles/base.dockerfile) を適宜修正
- [docker-compose.yml](https://github.com/hwichan0720/docker-tutorial/blob/master/docker-compose.yml) の image, ports を適宜修正

## Build docker image

`docker-compose build`

## Run docker container

`docker-compose up -d <service name>`

VSCode の Remote Containers を使いたい場合 <service name> に dev を指定

## Stop docker container

`docker-compose down -v`
