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

Both of the above commands will produce large diffs even the out module set for replacement is identical to the module currently being required.

## Diffs

### `go.mod`

```bash
$ git diff go.mod
diff --git a/go.mod b/go.mod
index c469ef1..52cde13 100644
--- a/go.mod
+++ b/go.mod
@@ -3,11 +3,13 @@ module github.com/jtlisi/go_modules_replace_behaviour
 go 1.14

 require (
+       github.com/baiyubin/aliyun-sts-go-sdk v0.0.0-20180326062324-cfa1a18b161f // indirect
        github.com/blang/semver v3.5.1+incompatible // indirect
        github.com/cortexproject/cortex v1.2.1-0.20200708152413-8aab40a10ac5
        github.com/gorilla/mux v1.7.4 // indirect
        github.com/grpc-ecosystem/go-grpc-prometheus v1.2.1-0.20191002090509-6af20e3a5340 // indirect
        github.com/lann/builder v0.0.0-20180802200727-47ae307949d0 // indirect
+       github.com/lann/ps v0.0.0-20150810152359-62de8c46ede0 // indirect
 )

 // Overrides from Loki
@@ -27,3 +29,5 @@ replace github.com/satori/go.uuid => github.com/satori/go.uuid v1.2.0

 // Use fork of gocql that has gokit logs and Prometheus metrics.
 replace github.com/gocql/gocql => github.com/grafana/gocql v0.0.0-20200605141915-ba5dc39ece85
+
+replace github.com/cortexproject/cortex => github.com/cortexproject/cortex v1.2.1-0.20200708152413-8aab40a10ac5
```

### `go.sum`q