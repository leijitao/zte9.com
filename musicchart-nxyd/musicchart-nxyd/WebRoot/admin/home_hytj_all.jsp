<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>活跃用户统计-全部</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="活跃用户统计-全部">
	
	<link rel="stylesheet" type="text/css" href="css/home.css">
	<style type="text/css">
    	.a_q {
			text-decoration: none;
			color: black;
			display: block;
			width: 80px;
			text-align: center;
		}
		.a_q a:hover {
			font-weight: bold;
		}
    </style>
  </head>
  
  <body>
    <div>
    	<div class="tui_1_head">
    	</div>
    	<div class="tui_1_tongji">
    		<div class="tui_1_tongji_head"><span>访问量统计-全部</span></div>
    		<div class="tui_1_table_div">
    		<table class="tui_1_table_1">
    			<tr class="tui_1_table_1_tr">
    				<td></td>
    				<td class="tui_1_table_td">PV</td>
    				<td class="tui_1_table_td">UV</td>
    				<td class="tui_1_table_td">PV/UV</td>
    			</tr>
    			<tr class="tui_1_table_1_tr">
    				<td class="tui_1_table_td">今日</td>
    				<c:forEach items="${today}" var="list">
    					<td>${list.totalUser}</td>
    					<td>${list.activeUser}</td>
    					<td>${list.ratio}</td>
    				</c:forEach>
    			</tr>
    			<tr class="tui_1_table_1_tr">
    				<td class="tui_1_table_td">昨日</td>
    				<c:forEach items="${yesterday}" var="list">
    					<td>${list.totalUser}</td>
    					<td>${list.activeUser}</td>
    					<td>${list.ratio}</td>
    				</c:forEach>
    			</tr>
    		</table>
    		</div>
    	</div>
    	<div class="tui_1_zoushi">
    		<div class="tui_1_tongji_head">
    			<span>统计趋势</span>
    		</div>
    		<div class="tui_1_xiao_1">
    			<span style="padding-top: 30px;padding-left: 400px">开始：<input id="state" class="Wdate" size="10" type="text" onClick="WdatePicker({el:this,dateFmt:'yyyy-MM-dd'})"></span>
    			<span style="padding-top: 30px;padding-left: 10px">结束：<input id="end" class="Wdate" size="10" type="text" onClick="WdatePicker({el:this,dateFmt:'yyyy-MM-dd'})"></span>
    			<input onclick="shijian()" type="button" value="确定">
    			
    			<div class="tui_1_xiao tui3"><a href="javascript:;" onclick="makeLine(7)" class="a_q"><span>过去7天</span></a></div>&nbsp;&nbsp;&nbsp;
    			<div class="tui_1_xiao tui4"><a href="javascript:;" onclick="makeLine(30)" class="a_q"><span>过去30天</span></a></div>&nbsp;&nbsp;&nbsp;
    			<div class="tui_1_xiao tui5"><a href="javascript:;" onclick="makeLine(90)" class="a_q"><span>过去90天</span></a></div>&nbsp;&nbsp;&nbsp;
    			<div class="tui_1_xiao tui6"><a href="javascript:;" onclick="makeLine(180)" class="a_q"><span>过去6个月</span></a></div>&nbsp;&nbsp;&nbsp;
    		</div>
    			
    		<div class="tui_1_zoushi_2">
    			<div id="container" style="height: 100%;width: 99%"></div>
    		</div>
    	</div>
    	<div class="tui_1_mingxi">
    		<div class="tui_1_tongji_head">
    			<span style="float: left;">明细</span>
    			<div style="float:left;padding-left: 85%">
    				<input type="button" onclick="query()" value="导出" />
    			</div>
    		</div>
    		
    		<div id="table2">
    			<table class="tui_2_table"  cellpadding="0px" cellspacing="0px">
    			</table>
    		</div>
    		<div class="zongji"></div>
    		<div class="food"></div>
    	</div>
    </div>
    <script language="javascript" type="text/javascript" src="js/WdatePicker.js"></script>
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="js/echarts.min(1).js"></script>
    <script type="text/javascript" src="js/echarts.js"></script>
    
    <script type="text/javascript">
    	function shijian(){
				var start = $("#state").val();
				var end = $("#end").val();
				var number = start+","+end;
				makeLine(number);
		}
    	function query(){
    		window.location='ActiveExcelAction.action'; 
    		/* var yesrSele = $("#yesrSele").val();
    		var monSele = $("#monSele").val();
    		var ym = yesrSele+","+monSele;
    		var str="";
    		 $.ajax({
    			type: "post",
    			async : true, //异步执行
    			url: "HYTJMXAction.action",
    			data: {yesrMon:ym},
    			dataType: "json",
    			success: function (activeDateVOs){
    				str+="<table class='tui_2_table'  cellpadding='0px' cellspacing='0px'>";
    				str+="<tr>";
    				str+="<td style='font-weight: bold;'>日期</td>";
    				str+="<td style='font-weight: bold;'>总用户数</td>";
    				str+="<td style='font-weight: bold;'>活跃用户数</td>";
    				str+="<td style='font-weight: bold;'>占比</td>";
    				str+="</tr>";
    				for(var i = 0;i<activeDateVOs.length;i++){
    					str+="<tr>";
    					str+="<td>"+activeDateVOs[i].clickDate+"</td>";
    					str+="<td>"+activeDateVOs[i].totalUser+"</td>";
    					str+="<td>"+activeDateVOs[i].activeUser+"</td>";
    					str+="<td>"+activeDateVOs[i].ratio+"</td>";
    					str+="</tr>";
    				}
    				$("#table2").html(str);
    			}
    		});  */
    	}
    	function ass(number){
			var str="";
			$.ajax({ 
				//这里的需要Struts.xml的<action/>的name属性一致。
				url:"HYAssAction.action",
				//提交类型
				type:"post",
				//返回的数据类型
				async : false, //同步执行
				data : {mub:number},
				dataType:"json", 
				//成功是调用的方法
				success:function(activeVO){ 
				    if (activeVO) {
				    	str+="<div>"
				    	str+="<span>总访问量(PV)："+activeVO.totalUser+"</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
				       	str+="<span>总未订购访问量(PV)："+activeVO.wpvInteger+"</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
				       	str+="<span>总已订购访问量(PV)："+activeVO.ypvInteger+"</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
				       	str+="</div>";
				       	str+="<div style='padding-top: 10px'>";
				       	str+="<span>总访问人数(UV)："+activeVO.activeUser+"</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
				       	str+="<span>总未订购访问人数(UV)："+activeVO.wuvInteger+"</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
				       	str+="<span>总已订购访问人数(UV)："+activeVO.yuvInteger+"</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
				       	str+="</div>";
				       	$(".zongji").html(str);	
				    }
				}
			});
		}
    </script>
    <script>
		        	window.onload = makeLine(7);
		            function makeChart () {
		           		var dom = document.getElementById("container");
						var myChart = echarts.init(dom);
		                return myChart;
		            }
		            function makeLine (number) {
		                var chart = makeChart();
		                var xAxisData = [];
		                var data = [];
		                for (var i = 0; i < 5; i++) {
		                    xAxisData[i] = [];
		                    data[i] = [];
		                    for (var j = 0; j < 10; j++) {
		                        xAxisData[i].push('jj' + j);
		                        data[i].push((Math.random() * 5).toFixed(2));
		                    }
		                }
		                var option = {
		                    tooltip : {
		                        trigger: 'axis'
		                    },
		                    legend: {
		                    	layout: 'vertical',
                    			align: 'right',
                    			borderWidth: 0,
                    			verticalAlign: 'middle',
                    			y: 0,
                    			x: 100,
		                        data: ['PV','UV','PV/UV']
		                    },
		                    toolbox: {
		                        top: 0,
		                        feature: {
		                            magicType: {
		                            },
		                            myTool1: {
		                                show: false,
		                                title: '自定义扩展方法：重新加载 option',
		                                icon: 'path://M432.45,595.444c0,2.177-4.661,6.82-11.305,6.82c-6.475,0-11.306-4.567-11.306-6.82s4.852-6.812,11.306-6.812C427.841,588.632,432.452,593.191,432.45,595.444L432.45,595.444z M421.155,589.876c-3.009,0-5.448,2.495-5.448,5.572s2.439,5.572,5.448,5.572c3.01,0,5.449-2.495,5.449-5.572C426.604,592.371,424.165,589.876,421.155,589.876L421.155,589.876z M421.146,591.891c-1.916,0-3.47,1.589-3.47,3.549c0,1.959,1.554,3.548,3.47,3.548s3.469-1.589,3.469-3.548C424.614,593.479,423.062,591.891,421.146,591.891L421.146,591.891zM421.146,591.891',
		                                onclick: function (){
		                                    chart.setOption(option);
		                                    alert('chart.setOption(option) DONE!')
		                                }
		                            }
		                        }
		                    },
		                    xAxis : [
		                        {
		                            type : 'category',
		                            boundaryGap : false,
		                        }
		                    ],
		                    yAxis : [
		                        {
		                            type : 'value'
		                        }
		                    ],
		                    series : [
		                    	{
		                    		name : 'PV',
		                    		type : 'line',
		                    		stack :'1',
		                    	},
		                    	{
		                    		name : 'UV',
		                    		type : 'line',
		                    		stack :'2',
		                    	},
		                    	{
		                    		name : 'PV/UV',
		                    		type : 'line',
		                    		stack :'3',
		                    	}
		                    ]
		                }
		                loadDATA(option,number);
		                chart.setOption(option,number);
		            }
		        	function loadDATA(option,number){
		            	$.ajax({ 
				        //这里的需要Struts.xml的<action/>的name属性一致。
				       	url:"LoginHYTJAction.action",
				       	//提交类型
				       	type:"post",
				       	//返回的数据类型
				       	async : false, //同步执行
				       	data : {mub:number},
				       	dataType:"json", 
				       	//成功是调用的方法
				       	success:function(result){ 
				       		if (result) {
				       			option.xAxis[0].data=[];
				       			for(var i=0;i<result.length;i++){
				       				option.xAxis[0].data.push(result[i].name);
				       			}
				       			option.series[0].data=[];
				       			for(var i=0;i<result.length;i++){
				       				option.series[0].data.push(result[i].data);
				       			}
				       			option.series[1].data=[];
				       			for(var i=0;i<result.length;i++){
				       				option.series[1].data.push(result[i].data2);
				       			}
				       			option.series[2].data=[];
				       			for(var i=0;i<result.length;i++){
				       				option.series[2].data.push(result[i].data3);
				       			}
				       			var str = "";
				       			str+="<table class='tui_2_table'  cellpadding='0px' cellspacing='0px'>";
			    				str+="<tr>";
			    				str+="<td style='font-weight: bold;'>日期</td>";
			    				str+="<td style='font-weight: bold;'>总(PV)</td>";
			    				str+="<td style='font-weight: bold;'>未订购(PV)</td>";
			    				str+="<td style='font-weight: bold;'>已订购(PV)</td>";
			    				str+="<td style='font-weight: bold;'>总(UV)</td>";
			    				str+="<td style='font-weight: bold;'>未订购(UV)</td>";
			    				str+="<td style='font-weight: bold;'>已订购(UV)</td>";
			    				str+="<td style='font-weight: bold;'>总(PV/UV)</td>";
			    				str+="</tr>";
			    				for(var i = 0;i<result.length;i++){
			    					str+="<tr>";
			    					str+="<td>"+result[i].name+"</td>";
			    					str+="<td>"+result[i].data+"</td>";
			    					str+="<td>"+result[i].wpv+"</td>";
			    					str+="<td>"+result[i].ypv+"</td>";
			    					str+="<td>"+result[i].data2+"</td>";
			    					str+="<td>"+result[i].wuv+"</td>";
			    					str+="<td>"+result[i].yuv+"</td>";
			    					str+="<td>"+result[i].data3+"</td>";
			    					str+="</tr>";
			    				}
			    				$("#table2").html(str);
				       		}
		        		}
			    	});
			    	ass(number);
				   }            
		        </script>
  </body>
</html>
