<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      

<meta charset="UTF-8" />

<!-- 메뉴 목록 -->
  <table id="menulist">
    <tr>
  <c:forEach var="menu" items="${ menuList }" >
     <td>
       <a href="/PDS/List?menu_id=${ menu.menu_id }">
          ${ menu.menu_name }
       </a>
     </td>
  </c:forEach>  
    </tr>  
  </table>
  
  
  
  
  
  

