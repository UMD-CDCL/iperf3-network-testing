# iperf3-network-testing
Wrapper for iperf3 which automatically logs output to logs folder

- Logs output even if just running a command like --help or if you give it a bad command
- Logs folder is created if it doesn't exist
- Logs are tagged with a test number that is automatically incremented, the command being run, and a timestamp
