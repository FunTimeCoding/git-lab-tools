# GitLab Tools


## Operation

Specify a config file.

```sh
./bin/script.sh -c /Users/shiin/.gitlab-tools-mine.conf
```


## Configuration

Example config. Default path is ~/.gitlab-tools.conf.

```sh
# required
TOKEN="changeme"
# `GITLAB_URL` is optional and falls back to `http://localhost`.
GITLAB_URL="http://gitlab.dev"
```


## Development

Run any script verbosely if you want to debug it.

```sh
./bin/script.sh -v
```

Install development tools.

```sh
brew install shellcheck
```

Run code style check.

```sh
./run-style-check.sh
```
