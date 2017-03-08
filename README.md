# GitlabTools

## Setup

This section explains how to set up this project.

Create a configuration. The default location is ~/.gitlab-tools.sh.

```sh
# Required.
TOKEN=changeme
# Optional. Default: http://localhost
GITLAB_URL=http://example.org
```


## Usage

This section explains how to use this project.

Run the main program.

```sh
bin/gt
```

Show list of owned repositories.

```sh
bin/list-repositories.sh
```

Specify a config file for any command.

```sh
bin/list-repositories.sh --config ~/.gitlab-tools-mine.conf
```

Create and delete a repository.

```sh
bin/create-repository.sh example-project
bin/create-repository.sh --visibility internal example-project
bin/delete-repository.sh example-project
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
