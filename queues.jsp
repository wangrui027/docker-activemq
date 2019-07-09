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
<c:set var="pageTitle" value="Queues"/>

<%@include file="decorators/head.jsp" %>
</head>
<body>

<%@include file="decorators/header.jsp" %>

<table>
<tr>
<td>
<div>
<form action="createDestination.action" method="post">
    <input type="hidden" name="JMSDestinationType" value="queue"/>
    <input type="hidden" name="secret" value="<c:out value='${sessionScope["secret"]}'/>"/>

    <label name="destination">Queue Name</label>
    <input type="text" name="JMSDestination" value=""/>

    <input type="submit" value="Create"/>
</form>
</div>
</td>

<td>
<div>
<form action="queues.jsp" method="get">
    <label name="destination">Queue Name Filter</label>
    <input type="text" name="QueueFilter" value="<c:out value='${param.QueueFilter}'/>"/>

    <input type="submit" value="Filter"/>
</form>
</div>
</tr>
</table>

<h2>Queues:<c:if test="${null != param.QueueFilter && param.QueueFilter != ''}"> (filter="<c:out value='${param.QueueFilter}'/>")</c:if></h2>

<table id="queues" class="sortable autostripe">
<thead>
<tr>
<th>队列名称</th>
<th>未使用</th>
<th>消费者</th>
<th>入队</th>
<th>出队</th>
<th>视图</th>
<th>操作</th>
</tr>
</thead>
<tbody>
<c:forEach items="${requestContext.brokerQuery.queues}" var="row">
<c:if test="${param.QueueFilter == '' || fn:containsIgnoreCase(row.name, param.QueueFilter)}">

<tr>
<td><a href="<c:url value="browse.jsp">
                        <c:param name="JMSDestination" value="${row.name}" /></c:url>"><form:tooltip text="${row.name}" length="50"/></a></td>
<td><c:out value="${row.queueSize}" /></td>
<td><c:out value="${row.consumerCount}" /></td>
<td><c:out value="${row.enqueueCount}" /></td>
<td><c:out value="${row.dequeueCount}" /></td>
<td>
    <a href="<c:url value="browse.jsp">
                   <c:param name="JMSDestination" value="${row.name}" /></c:url>">浏览</a>
	<a href="<c:url value="queueConsumers.jsp">
	                <c:param name="JMSDestination" value="${row.name}" /></c:url>">消费者</a><br/>
	<a href="<c:url value="queueProducers.jsp">
	                <c:param name="JMSDestination" value="${row.name}" /></c:url>">生产者</a><br/>
    <a href="queueBrowse/<form:escape text="${row.name}" />?view=rss&feedType=atom_1.0" title="Atom 1.0"><img src="images/feed_atom.png"/></a>
    <a href="queueBrowse/<form:escape text="${row.name}" />?view=rss&feedType=rss_2.0" title="RSS 2.0"><img src="images/feed_rss.png"/></a>
</td>
<td>
    <a href="<c:url value="send.jsp">
                    <c:param name="JMSDestination" value="${row.name}" />
                    <c:param name="JMSDestinationType" value="queue"/></c:url>">发送</a>
    <a href="<c:url value="purgeDestination.action">
                    <c:param name="JMSDestination" value="${row.name}" />
                    <c:param name="JMSDestinationType" value="queue"   />
                    <c:param name="secret" value='${sessionScope["secret"]}'/></c:url>">清理</a>
    <a href="<c:url value="deleteDestination.action">
                    <c:param name="JMSDestination" value="${row.name}" />
                    <c:param name="JMSDestinationType" value="queue"   />
                    <c:param name="secret" value='${sessionScope["secret"]}'/></c:url>">删除</a>
</td>
</tr>

</c:if>
</c:forEach>
</tbody>
</table>

<%@include file="decorators/footer.jsp" %>

</body>
</html>
	
