# iperf3-network-testing
Wrapper for iperf3 which automatically logs output to logs folder

- Logs output even if just running a command like --help or if you give it a bad command
- Logs folder is created if it doesn't exist
- Logs are tagged with a test number that is automatically incremented, the command being run, and a timestamp

Example usage:
./record-iperf3.sh -c SERVER_IP --time 0 --bitrate 0 --format m --interval 1
- starts client that sends to SERVER_IP indefinitely at an unlimited bitrate in Mbit/s and reports every 1s and sends tcp
./record-iperf3.sh -c SERVER_IP --time 0 --bitrate 0 --format m --interval 1 --udp
- starts client that sends to SERVER_IP indefinitely at an unlimited bitrate in Mbit/s and reports every 1s and sends udp
./record-iperf3.sh -s --interval 1
- starts server on device that records every 1s
