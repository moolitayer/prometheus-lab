# prometheus-lab
Run a prometheus stack locally for research purposes. The stack includes:

[1] A server exporting a /metrics endpoint
[1] Prometheus built from the release-2.0 branch  
[1] Alertmanager built from the release-0.12 branch  
[1] FakeSMTP build from master

## Questions

What happens to firing alerts in prometheus after restart?

What happens to firing alerts in prometheus after configuration reload?

What happens to firing alerts in prometheus after removing their definition and running configuration reload?

What happens to firing alerts in prometheus after removing their definition and restarting?

What happens to active alerts in alermanager after restart? 
 