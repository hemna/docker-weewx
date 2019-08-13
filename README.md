Basic usage:
clone the git repo:

git clone https://github.com/hemna/docker-weewx

cd docker-weewx
docker build -t hemna/weewx:latest .

docker run -d --name weewx -v <path to >/docker-weewx/archive:/home/weewx/archive -v /dev/bus/usb:/dev/bus/usb --privileged hemna/weewx

docker run -d --name weewx2 -v $HOME/docker/weewx/archive/:/home/weewx/archive -v $HOME/docker/weewx/logs:/home/weewx/logs -v $HOME/docker/weewx/public_html:/home/weewx/public_html -v /dev/bus/usb:/dev/bus/usb -p 80:9999 --privileged hemna/weewx:latest
