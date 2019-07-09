# docker-activemq

本镜像在 [rmohr/activemq](<https://hub.docker.com/r/rmohr/activemq>) 镜像的基础之上汉化了部分页面，目前汉化部分：

`webapps/admin/queues.jsp`

`webapps/admin/topics.jsp`

启动示例：

```bash
docker run -d --restart always --name activemq -p 61616:61616 -p 8161:8161  wangrui027/activemq
```

