FROM rmohr/activemq:5.15.9-alpine

ARG ACTIVEMQ_VERSION=5.15.9

ADD queues.jsp /opt/apache-activemq-${ACTIVEMQ_VERSION}/webapps/admin/queues.jsp
ADD topics.jsp /opt/apache-activemq-${ACTIVEMQ_VERSION}/webapps/admin/topics.jsp
