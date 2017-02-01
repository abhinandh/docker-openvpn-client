FROM alpine

CMD ["openvpn", "--config", "/vpn/vpn.conf"]
VOLUME ["/vpn"]
COPY firewall.sh /usr/bin/firewall.sh
ENTRYPOINT ["/bin/sh", "/usr/bin/firewall.sh"]
RUN apk add --no-cache openvpn
