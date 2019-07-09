<%--
    Licensed to the Apache Software Foundation (ASF) under one or more
    contributor license agreements.  See the NOTICE file distributed with
    this work for additional information regarding copyright ownership.
    The ASF licenses this file to You under the Apache License, Version 2.0
    (the "License"); you may not use this file except in compliance with
    the License.  You may obtain a copy of the License at
   
    http://www.apache.org/licenses/LICENSE-2.0
   
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
--%>
<%-- Workaround for https://ops4j1.jira.com/browse/PAXWEB-1070 --%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="WEB-INF/jspf/headertags.jspf" %>
<html>
<head>
<c:set var="pageTitle" value="Topics"/>

<%@include file="decorators/head.jsp" %>
</head>
<body>

<%@include file="decorators/header.jsp" %>

<div>
<form action="createDestination.action" method="post">
    <input type="hidden" name="JMSDestinationType" value="topic"/>
    <input type="hidden" name="secret" value="<c:out value='${sessionScope["secret"]}'/>"/>

    <label name="destination">Topic Name</label>
    <input type="text" name="JMSDestination" value=""/>

    <input type="submit" value="Create"/>
</form>
</div>

<h2>Topics</h2>

<table id="topics" class="sortable autostripe">
<thead>
<tr>
<th>队列名称</th>
<th>消费者</th>
<th>入队</th>
<th>出队</th>
<th>操作</th>
</tr>
</thead>
<tbody>
<c:forEach items="${requestContext.brokerQuery.topics}" var="row">
<tr>
<td><a href="<c:url value="send.jsp">
                        <c:param name="JMSDestination" value="${row.name}" />
                        <c:param name="JMSDestinationType" value="topic"/></c:url>"><form:tooltip text="${row.name}" length="50"/></a></td>
<td><c:out value="${row.consumerCount}" /></td>
<td><c:out value="${row.enqueueCount}" /></td>
<td><c:out value="${row.dequeueCount}" /></td>
<td>
    <a href="<c:url value="send.jsp">
                        <c:param name="JMSDestination" value="${row.name}" />
                        <c:param name="JMSDestinationType" value="topic"/></c:url>">发送</a>
    <a href="<c:url value="topicSubscribers.jsp">
                        <c:param name="JMSDestination" value="${row.name}" /></c:url>">消费者</a><br/>
    <a href="<c:url value="topicProducers.jsp">
                        <c:param name="JMSDestination" value="${row.name}" /></c:url>">生产者</a><br/>
    <a href="<c:url value="deleteDestination.action">
                   <c:param name="JMSDestination" value="${row.name}" />
                   <c:param name="JMSDestinationType" value="topic"/>
                   <c:param name="secret" value='${sessionScope["secret"]}'/></c:url>">删除</a>
</td>
</tr>
</c:forEach>
</tbody>
</table>

<%@include file="decorators/footer.jsp" %>

</body>
</html>
	
