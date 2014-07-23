

nginx 反向代理

    user nginx;
    worker_processes 5;

    error_log /var/log/nginx/error.log;

    pid /var/run/nginx.pid;

    events {
        worker_connections 1024;
        use epoll;
    }

    proxy_next_upstream error;

    upstream tornadoes {
        server 127.0.0.1:8000;
        server 127.0.0.1:8001;
        server 127.0.0.1:8002;
        server 127.0.0.1:8003;
    }

    server {
        listen 80;
        server_name www.example.org *.example.org;

        location /static/ {
            root /var/www/static;
            if ($query_string) {
                expires max;
            }
        }

        location / {
            proxy_pass_header Server;
            proxy_set_header Host $http_host;
            proxy_redirect off;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Scheme $scheme;
            proxy_pass http://tornadoes;
        }
    }


开启ssl

    server {
        listen 443;
        ssl on;
        ssl_certificate /path/to/cert.pem;
        ssl_certificate_key /path/to/cert.key;

        default_type application/octet-stream;

        location /static/ {
            root /var/www/static;
            if ($query_string) {
                expires max;
            }
        }

        location = /favicon.ico {
            rewrite (.*) /static/favicon.ico;
        }

        location / {
            proxy_pass_header Server;
            proxy_set_header Host $http_host;
            proxy_redirect off;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Scheme $scheme;
            proxy_pass http://tornadoes;
        }
    }

supervisor

因为我们为每个CPU核心运行一个独立的Tornado进程，因此有很多进程需要监控和控制。supervisor守护进程可以帮助我们完成这个任务。

Supervisor的设计是每次开机时启动其配置文件中列出的进程。
这里，我们将看到管理我们在Nginx配置文件中作为上游主机提到的四个Tornado实例的Supervisor配置。
典型的supervisord.conf文件中包含了全局的配置指令，并加载conf.d目录下的其他配置文件。

------------------------------

一旦你安装和配置好Supervisor，你就可以使用supervisorctl来管理supervisord进程。为了启动你的Web应用，你可以让Supervisor重新读取配置，然后任何配置改变的程序或程序组将被重启。你同样可以手动启动、停止和重启被管理的程序或检查整个系统的状态。

    supervisor> update
    tornadoes: stopped
    tornadoes: updated process group
    supervisor> status
    tornadoes:tornado-8000 RUNNING pid 32091, uptime 00:00:02
    tornadoes:tornado-8001 RUNNING pid 32092, uptime 00:00:02
    tornadoes:tornado-8002 RUNNING pid 32093, uptime 00:00:02
    tornadoes:tornado-8003 RUNNING pid 32094, uptime 00:00:02

Supervisor和你系统的初始化进程一起工作，并且它应该在系统启动时自动注册守护进程。当supervisor启动后，程序组会自动在线。默认情况下，Supervisor会监控子进程，并在任何程序意外终止时重生。如果你想不管错误码，重启被管理的进程，你可以设置autorestart为true。

Supervisor不只可以使管理多个Tornado实例更容易，还能让你在Tornado服务器遇到意外的服务中断后重新上线时泰然处之。
