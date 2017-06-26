Basic usage:
clone the git repo:

git clone https://github.com/hemna/docker-weewx

cd docker-weewx
docker build -t hemna/weewx .

docker run -d --name weewx -v <path to host archive dir to store DB>:/home/weewx/archive hemna/weewx
