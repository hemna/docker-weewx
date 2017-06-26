Basic usage:
clone the git repo:

git clone https://github.com/hemna/docker-weewx

cd docker-weewx
docker build -t hemna/weewx .

docker run -d --name weewx -v <path to >/docker-weewx/archive:/home/weewx/archive -v /dev/bus/usb:/dev/bus/usb --privileged hemna/weewx
