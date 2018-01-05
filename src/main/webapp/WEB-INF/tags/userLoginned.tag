
<%@ tag body-content="empty" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="custom" %>


<c:choose>
  <c:when test="${empty sessionScope.user}">
    <a style="outline: none; border: none;" href="#login-modal" data-toggle="modal">
    <span class="glyphicon glyphicon-log-in"></span> Login</a>
  </c:when>
  <c:otherwise>
     <a style="outline: none; border: none;" href="#" data-toggle="modal">
        <span class="glyphicon glyphicon-user"></span> Account</a>
  </c:otherwise>
</c:choose>
