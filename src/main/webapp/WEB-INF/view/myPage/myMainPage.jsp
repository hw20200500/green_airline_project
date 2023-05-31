<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<style>
      .main--img--div{
         width: 100vw;
        height: 450px;
         background-size: 100%;
        position: relative;
        background: url("../images/321.jpg");
        background-size: cover;
        }
    .main--img--div::before{
        content: "";
        opacity: 0.45;
        position: absolute;
        top: 0px;
        left: 0px;
        right: 0px;
        bottom: 0px;
        background-color: #000;
        color: initial ;
    }
    .box01 {
    	 color: #fff;
    position: relative;
    padding-left: 500px;
    padding-top: 125px;
    position: absolute;
    Transform: translateX(-20%);
    
    }
    #donut_single{
    position: relative;
    padding-left:200px; 
    padding-bottom: 500px;
    position: absolute;
    Transform: translateX(-5%);
    Transform: translateY(-30%);
    }
</style>



<main>
<div>
	<div class="main--img--div">
		<div class="box01">
			<h2>정다운</h2>
			<p>JUNG DAUN</p>
			<h2>등급 나오게</h2>
 <div id="donut_single" style="width: 1000px; height: 1000px;"></div>
		</div>
	</div>
	</div>
</main>

 <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {

        var data = google.visualization.arrayToDataTable([
          ['Effort', 'Amount given'],
          ['My all',     100],
        ]);

        var options = {
        		chartArea: {
        	        backgroundColor: {
        	          fill: 'black',
        	          fillOpacity: 100
        	        },
        	      },
        	      backgroundColor: {
        	        fill: '#FF0000',
        	        fillOpacity: 0
        	      },
        	      responsive: false	,
          pieHole: 0.9,
          pieSliceTextStyle: {
            color: 'black',
            
          },
          legend: 'none'
          
        };

        var chart = new google.visualization.PieChart(document.getElementById('donut_single'));
        chart.draw(data, options);
      }
    
    </script>


<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
