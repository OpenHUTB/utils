# 通过docker run中加入环境变量,取名为gitlab
sudo docker run --detach \
  --hostname gitlab.example.com \
  --publish 8443:443 --publish 80:80 --publish 10022:22 \
  --name gitlab \
  --restart always \
  --volume /var/lib/docker/volumes/gitlab-data/etc:/etc/gitlab \
  --volume /var/lib/docker/volumes/gitlab-data/log:/var/log/gitlab \
  --volume /var/lib/docker/volumes/gitlab-data/data:/var/opt/gitlab \
  --shm-size 256m \
  gitlab/gitlab-ce:11.6.4-ce.0
