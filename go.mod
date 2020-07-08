module github.com/jtlisi/go_modules_replace_behaviour

go 1.14

require (
	github.com/blang/semver v3.5.1+incompatible // indirect
	github.com/cortexproject/cortex v1.2.1-0.20200708152413-8aab40a10ac5
	github.com/gorilla/mux v1.7.4 // indirect
	github.com/grpc-ecosystem/go-grpc-prometheus v1.2.1-0.20191002090509-6af20e3a5340 // indirect
	github.com/lann/builder v0.0.0-20180802200727-47ae307949d0 // indirect
)

// Overrides from Loki
replace golang.org/x/net => golang.org/x/net v0.0.0-20190923162816-aa69164e4478

// Overrides from Cortex
replace github.com/Azure/azure-sdk-for-go => github.com/Azure/azure-sdk-for-go v36.2.0+incompatible

replace github.com/Azure/go-autorest => github.com/Azure/go-autorest v13.3.0+incompatible

replace git.apache.org/thrift.git => github.com/apache/thrift v0.0.0-20180902110319-2566ecd5d999

replace k8s.io/client-go => k8s.io/client-go v0.18.3

// >v1.2.0 has some conflict with prometheus/alertmanager. Hence prevent the upgrade till it's fixed.
replace github.com/satori/go.uuid => github.com/satori/go.uuid v1.2.0

// Use fork of gocql that has gokit logs and Prometheus metrics.
replace github.com/gocql/gocql => github.com/grafana/gocql v0.0.0-20200605141915-ba5dc39ece85
