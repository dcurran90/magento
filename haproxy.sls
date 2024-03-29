haproxy-software:
  pkg.installed:
    - pkgs:
      - haproxy

/etc/haproxy/haproxy.cfg:
  file.managed:
    - source: salt://magento/files/haproxy/haproxy.cfg
    - template: jinja
    - makedirs: True

/etc/default/haproxy:
  file.managed:
    - source: salt://magento/files/haproxy/default-haproxy
    - makedirs: True

haproxy-service:
  service:
    - name: haproxy
    - running
    - enable: True
    - require:
      - pkg: haproxy-software
    - watch:
      - file: /etc/haproxy/haproxy.cfg
      - file: /etc/default/haproxy
