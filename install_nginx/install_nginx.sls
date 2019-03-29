{% set soft_files = '/home/soft' %}
{% set nginx_home = '/home/nginx' %}
{% set nginx_package = 'nginx-1.15.10.tar.gz' %}
{% set nginx_files = 'nginx-1.15.10' %}
{% set module_package = 'nginx_upstream_check_module-master.zip' %}
{% set module_files = 'nginx_upstream_check_module-master' %}
{% set items = [nginx_package, module_package] %}

{% for item in items %}
{{ soft_files }}/{{ item }}:
  file.managed:
    - source: salt://install_nginx/{{ item }}
    - makedirs: True
    - unless: test -f {{ soft_files }}/{{ item }}
{% endfor %}

install_package:
  pkg.installed:
    - names: 
      - unzip
      - patch
      - gcc
      - gcc-c++
      - pcre-devel
      - openssl
      - openssl-devel

un_nginx:
  cmd.run:
    - cwd: {{ soft_files }}
    - name: tar zxf {{ nginx_package }}
    - require:
      - file: {{ soft_files }}/{{ nginx_package }} 
    - unless: 
      - test -d {{ soft_files }}/{{ nginx_files }}
      - test -f {{ nginx_home }}/sbin/nginx

un_module:
  cmd.run:
    - cwd: {{ soft_files }}
    - name: unzip -q {{ module_package }}
    - require:
      - file: {{ soft_files }}/{{ module_package }}
      - pkg: install_package
    - unless: 
      - test -d {{ soft_files }}/{{ module_files }}
      - test -f {{ nginx_home }}/sbin/nginx

install_nginx:
  cmd.run:
    - cwd: {{ soft_files }}/{{ nginx_files }}
    - names:
      - patch -p1 < ../{{ module_files }}/check_1.14.0+.patch && ./configure --prefix={{ nginx_home }} --with-http_ssl_module --add-module=../{{ module_files }} && make && make install
    - unless:
      - test -f {{ nginx_home }}/sbin/nginx
  file.append:
    - name: /etc/rc.d/rc.local
    - text:
      - {{ nginx_home }}/sbin/nginx
    
