# docker-nsrt-mk3-dev-logger

## Intro

https://convergenceinstruments.com

https://github.com/xanderhendriks/nsrt-mk3-dev


## Usage

Running it via the Makefile will find the device on your in the Linux /dev directory and pass it into the docker
container.  It will also create a 'measurments' folder in the local directory and mount it into the docker image, where
the application will log sound measuremnts into CSV files inside of the 'measurements' directory.

The measurements may then be read by Telegraf into a time series DB, and then displayed via Grafana. A system that
supports this may be found here: https://github.com/dcwangmit01/sound-meter-influxdb

```
make build && make run
```

Finding Help
```
$ make
build                          Build the docker image
clean                          Clean all temporary files and images
deps                           Install Dependencies
format                         Auto-format and check pep8
help                           Print list of Makefile targets
mrclean                        MrClean everything
push                           Push the docker image
reqs                           Generate the requirements.txt file
run                            Run the docker image
```

