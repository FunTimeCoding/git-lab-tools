# GitlabTools

## Configuration

This section explains how to configure this project.

Example config. The default location is ~/.gitlab-tools.conf.

```sh
# Required.
TOKEN=changeme
# Optional. Default: http://localhost
GITLAB_URL=http://example.org
```


## Usage

This section explains how to use this project.

Show list of owned repositories.

```sh
bin/list-repos.sh
```

Specify a config file for any command.

```sh
bin/list-repos.sh --config ~/.gitlab-tools-mine.conf
```


## Development

This section explains how to use scripts that are intended to ease the development of this project.

Install development tools.

```sh
sudo apt-get install shellcheck
```

Run style check and show all concerns.

```sh
./run-style-check.sh
```

Build the project like Jenkins.

```sh
./build.sh
```
