<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%@taglib  prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %> 

<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">

   <c:set  var="showprev"        value="${ pagePdsVo.isshowpageprev }" />
   <c:set  var="shownext"        value="${ pagePdsVo.isshowpagenext }" />
    
   <c:set  var="startnum"        value="${ pagePdsVo.pagestartnum }" /> 
   <c:set  var="endnum"          value="${ pagePdsVo.pageendnum }" /> 
   <c:set  var="pagegrpnum"      value="${ pagePdsVo.pagegrpnum }" />
   
   <c:set  var="totalcount"      value="${ pagePdsVo.totalcount }" />
   <c:set  var="pagecount"       value="${ pagePdsVo.pagecount }" />
   <c:set  var="totalpagecount"  value="${ pagePdsVo.totalpagecount }" />
   
   <c:set  var="nowpage"         value="${ pagePdsVo.nowpage }" />
   <c:set  var="prevnowpage"     value="${ pagePdsVo.prevnowpage }" />
   <c:set  var="nextnowpage"     value="${ pagePdsVo.nextnowpage }" />
   
   <c:set  var="menu_id"         value="${ pagePdsVo.menu_id }" />
       

<div>
  <table>
   <tr>
    <td>
      
      <c:if  test="${ showprev eq true }">
        <a href="/PDS/List?menu_id=${menu_id}&nowpage=1&pagecount=${pagecount}&pagegrpnum=${pagegrpnum}">
         [처음]
        </a>
      </c:if>
      
      <c:if  test="${ showprev eq true }">
       <a href=""/PDS/List?menu_id=${menu_id}&nowpage=${prevnowpage}&pagecount=${pagecount}&pagegrpnum=${pagegrpnum}">
        [이전 10 개]
       </a>
      </c:if>
      
      <!--  11   12  13  14  15  16  17  18  19    20  -->
      <c:forEach var="pagenum" begin="${ startnum }" end="${ endnum }" step="1">
      <a href="/PDS/List?menu_id=${ menu_id }&nowpage=${pagenum}&pagecount=${pagecount}&pagegrpnum=${pagegrpnum}">
         ${ pagenum }
      </a>&nbsp;&nbsp;
      </c:forEach>
      
      <c:if test="${ shownext eq true }">
       <a href="/PDS/List?menu_id=${menu_id}&nowpage=${nextnowpage}&pagecount=${pagecount}&pagegrpnum=${pagegrpnum}"">
        [다음 10 개]
       </a>
      </c:if>
      <c:if test="${ shownext eq true }">
       <a href="/PDS/List?menu_id=${menu_id}&nowpage=${endnum}&pagecount=${pagecount}&pagegrpnum=${pagegrpnum}">
        [마지막]
       </a>
      </c:if>
      
      
    </td>
   </tr>
  </table>
</div>


