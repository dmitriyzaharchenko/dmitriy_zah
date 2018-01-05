<!DOCTYPE html>
<html>
<%@ include file="jspf/head.jspf" %>
<body>

  <!-- Navigation -->
  <%@ include file="jspf/menu.jspf" %>


<div class="container" style="padding-top: 25px">



</div><!-- /.container -->

<!-- Modal -->
<c:if test="${empty sessionScope.user}">
<%@ include file="jspf/login_modal.jspf" %>
<%@ include file="jspf/register_modal.jspf" %>
</c:if>


<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>

</body>
</html>