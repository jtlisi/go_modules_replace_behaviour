# Go Modules Weird Replace Behaviour

This repo is meant to demo some weird behaviour I noticed with `go mod`.  

If a `replace` override is applied to a module even if there is no difference between the module that is currently set, it still leads to a large change in the `go.sum` and vendored dependencies. 

## Steps to Reproduce


1. Add the following replace override to the go.mod file

  ```
    replace github.com/cortexproject/cortex => github.com/cortexproject/cortex v1.2.1-0.20200708152413-8aab40a10ac5
  ```

2. Run `go mod tidy`
  - [go.mod diff](go_mod.diff)
  - [go.sum diff](go_sum.diff)

3. Run `go mod vendor`

```bash
$ git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   go.mod
	modified:   go.sum
	deleted:    vendor/github.com/coreos/go-semver/NOTICE
	modified:   vendor/github.com/coreos/go-semver/semver/semver.go
	modified:   vendor/github.com/coreos/pkg/capnslog/README.md
	modified:   vendor/github.com/coreos/pkg/capnslog/init.go
	modified:   vendor/github.com/coreos/pkg/capnslog/logmap.go
	modified:   vendor/github.com/coreos/pkg/capnslog/pkg_logger.go
	modified:   vendor/github.com/gorilla/websocket/.gitignore
	modified:   vendor/github.com/gorilla/websocket/.travis.yml
	modified:   vendor/github.com/gorilla/websocket/AUTHORS
	modified:   vendor/github.com/gorilla/websocket/README.md
	modified:   vendor/github.com/gorilla/websocket/client.go
	modified:   vendor/github.com/gorilla/websocket/conn.go
	deleted:    vendor/github.com/gorilla/websocket/conn_write.go
	deleted:    vendor/github.com/gorilla/websocket/conn_write_legacy.go
	modified:   vendor/github.com/gorilla/websocket/doc.go
	modified:   vendor/github.com/gorilla/websocket/mask.go
	modified:   vendor/github.com/gorilla/websocket/prepared.go
	deleted:    vendor/github.com/gorilla/websocket/proxy.go
	modified:   vendor/github.com/gorilla/websocket/server.go
	deleted:    vendor/github.com/gorilla/websocket/trace.go
	deleted:    vendor/github.com/gorilla/websocket/trace_17.go
	modified:   vendor/github.com/gorilla/websocket/util.go
	deleted:    vendor/github.com/gorilla/websocket/x_net_proxy.go
	modified:   vendor/github.com/hashicorp/go-msgpack/codec/decode.go
	modified:   vendor/github.com/hashicorp/go-msgpack/codec/helper.go
	modified:   vendor/github.com/hashicorp/go-msgpack/codec/helper_internal.go
	deleted:    vendor/github.com/mattn/go-ieproxy/go.mod
	deleted:    vendor/github.com/mattn/go-ieproxy/go.sum
	modified:   vendor/github.com/mattn/go-ieproxy/ieproxy_windows.go
	modified:   vendor/github.com/mattn/go-ieproxy/kernel32_data_windows.go
	deleted:    vendor/github.com/mattn/go-ieproxy/proxy_middleman.go
	deleted:    vendor/github.com/mattn/go-ieproxy/proxy_middleman_unix.go
	deleted:    vendor/github.com/mattn/go-ieproxy/proxy_middleman_windows.go
	modified:   vendor/github.com/mattn/go-ieproxy/winhttp_data_windows.go
	modified:   vendor/github.com/tmc/grpc-websocket-proxy/wsproxy/websocket_proxy.go
	modified:   vendor/gopkg.in/ini.v1/.travis.yml
	modified:   vendor/gopkg.in/ini.v1/README.md
	deleted:    vendor/gopkg.in/ini.v1/data_source.go
	deleted:    vendor/gopkg.in/ini.v1/deprecated.go
	modified:   vendor/gopkg.in/ini.v1/error.go
	modified:   vendor/gopkg.in/ini.v1/file.go
	deleted:    vendor/gopkg.in/ini.v1/helper.go
	modified:   vendor/gopkg.in/ini.v1/ini.go
	modified:   vendor/gopkg.in/ini.v1/key.go
	modified:   vendor/gopkg.in/ini.v1/parser.go
	modified:   vendor/gopkg.in/ini.v1/section.go
	modified:   vendor/gopkg.in/ini.v1/struct.go
	modified:   vendor/modules.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	vendor/github.com/gorilla/websocket/conn_read.go
	vendor/github.com/gorilla/websocket/conn_read_legacy.go
	vendor/github.com/mattn/go-ieproxy/GetProxyFunc.go
	vendor/github.com/mattn/go-ieproxy/proxyMiddleman_unix.go
	vendor/github.com/mattn/go-ieproxy/proxyMiddleman_windows.go

no changes added to commit (use "git add" and/or "git commit -a")
```


Both of the above commands will produce large diffs even the out module set for replacement is identical to the module currently being required.
