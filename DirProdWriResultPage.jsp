<!-- 
Written by Ankeet Tendulkar
This page showing results of the Director Producer Writer Combination
-->


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>   

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style>
/* basic positioning */
.legend { list-style: none; }
.legend li { float: left; margin-right: 10px; }
.legend span { border: 1px solid #ccc; float: left; width: 12px; height: 12px; margin: 2px; }
/* your colors */
.legend .superawesome { background-color: #ff00ff; }
.legend .awesome { background-color: #00ffff; }
.legend .kindaawesome { background-color: #0000ff; }
.legend .notawesome { background-color: #000000; }

</style>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<button onclick="location.href='Search.jsp'" type="button" style="width: 20em; height: 3em;">
     <strong>Return to homepage</strong></button>
<h3 align="center" style="font-size: 30px;"><font face="MV Boli" color="#008B8B">Choose the right drivers for your movie!</font></h3>

<% ArrayList Inner = new ArrayList(); %>

<% Inner = (ArrayList)request.getAttribute("Outer_ArrayList"); %>



<h3 align="center" style="font-size: 25px;"><font face="MV Boli">Likelihood of passing the Bechdel test: <font color="green">72.7%</font></font></h3>


<% ArrayList Inner2 = new ArrayList(); %>

<% Inner2 = (ArrayList)request.getAttribute("Second_Outer_ArrayList"); %>


<% if(Inner2.isEmpty()) { %>
<br>
<p align="center">No Records Exist For The Entered #CR Number</p>
<% response.sendRedirect("Cr_Search.jsp"); %>
<% } else { %>

<table border="1" align="center">

<tr>

<tr>
<td>
<font style="font-size: 25px;" face="MV Boli"><b> &nbsp;Fail&nbsp; </b></font>
</td>
<td>
<font style="font-size: 25px;" face="MV Boli"><b> &nbsp;Pass&nbsp; </b></font>
</td>
</tr>


<tr>
<td>
<font style="font-size: 25px;" face="MV Boli">&nbsp;&nbsp;<%= Inner2.get(1) %></font>
</td>
<td>
<font style="font-size: 25px;" face="MV Boli">&nbsp;&nbsp;<%= Inner2.get(3) %></font>
</td>
</tr>

<%-- <% ID = Inner.get(0); %> --%>
</tr>
<%} %>

</table>

<br>

<div style="margin-left: 400px; float:left;" class="bubble-chart">
<ul class="legend" style="margin-left: 25px;">

</ul></div>
<div style="float: right"></div>

<script src="http://d3js.org/d3.v3.min.js"></script>
<script>
console.log("CAME HERE");

//for(i = 0; i < "<%= Inner.size()%>"; i+=2) {
	
//}

console.log("THIS IS NAME" + name);
console.log("THIS IS NAME" + "Hello");


var MOVIES = [
              {"name":"<%= Inner.get(0) %>","value":"<%= Inner.get(1) %>"},
              {"name":"<%= Inner.get(2) %>","value":"<%= Inner.get(3) %>"},
              {"name":"<%= Inner.get(4) %>","value":"<%= Inner.get(5) %>"},
              {"name":"<%= Inner.get(6) %>","value":"<%= Inner.get(7) %>"},
              {"name":"<%= Inner.get(8) %>","value":"<%= Inner.get(9) %>"},
              {"name":"<%= Inner.get(10) %>","value":"<%= Inner.get(11) %>"},
              {"name":"<%= Inner.get(12) %>","value":"<%= Inner.get(13) %>"},
              {"name":"<%= Inner.get(14) %>","value":"<%= Inner.get(15) %>"},
              {"name":"<%= Inner.get(16) %>","value":"<%= Inner.get(17) %>"},
              {"name":"<%= Inner.get(18) %>","value":"<%= Inner.get(19) %>"},
              {"name":"<%= Inner.get(20) %>","value":"<%= Inner.get(21) %>"},
              {"name":"<%= Inner.get(22) %>","value":"<%= Inner.get(23) %>"},
              {"name":"<%= Inner.get(24) %>","value":"<%= Inner.get(25) %>"},
              {"name":"<%= Inner.get(26) %>","value":"<%= Inner.get(27) %>"},
              {"name":"<%= Inner.get(28) %>","value":"<%= Inner.get(29) %>"},
              {"name":"<%= Inner.get(30) %>","value":"<%= Inner.get(31) %>"}             
            ];

////////// v code goes below   v  /////////////////////////////////////////////

var svg = d3.select('.bubble-chart')
  .append('svg')
  .attr('width', 800)
  .attr('height', 800);

var bubble = d3.layout.pack()
    .sort(null)
    .size([600, 600])
    .padding(1.5);

var color = d3.scale.category10();

function animate(data) {

  var treeLikeData = {"children": data};

  var bubbleData = bubble.nodes(treeLikeData)
    .filter(function(d) { return !d.children; });

  var node = svg.selectAll('.node')
    .data(bubbleData, function(d) { return d.name; });

  var enter = node.enter().append('g')
    .attr('class', 'node')
    .attr('transform', function(d) {return 'translate(' + d.x + ',' + d.y + ')'; });
  enter.append('circle')
    .style('fill', function(d) { return color(d.name); })
    .attr('r' , 0);
  enter.append('text')
    .style('opacity', 1)
    .style('fill', 'black')
    .style('text-anchor', 'middle')
    .text(function(d) { return d.name; });

  var update = node.transition()
    .attr('transform', function(d) {return 'translate(' + d.x + ',' + d.y + ')'; });
  update.select('circle')
      .attr('r' , function(d) { return d.r; });
  update.select('text')
      .style('opacity', 1);

  var exit = node.exit()
    .transition()
      .remove();
  exit.select('circle').attr('r', 0);
  exit.select('text').style('opacity', 0);

}

animate(MOVIES);

animate(MOVIES);
////////// ^ code goes above  ^  /////////////////////////////////////////////

setTimeout(function() {
  MOVIES[0].value = 90;            // changes value of tea to 100
  animate(MOVIES);
}, 1000);

setTimeout(function() {
  MOVIES[4].value = 3;            // changes value of coffe to 3
  animate(MOVIES);
}, 1500);

setTimeout(function() {
  MOVIES.pop();                 // removes wine
  animate(MOVIES);
}, 2000);

setTimeout(function() {
  //MOVIES.push({name: "kombucha", value: 50});     // adds kombucha in
  animate(MOVIES);
}, 2500);

setTimeout(function() {
  //MOVIES.push({name: "wine", value: 60});    // adds wine back
  animate(MOVIES);
}, 3000);

setTimeout(function() {
  MOVIES[3].value = 40;             // changes value of gatorade to 50
  animate(MOVIES);
}, 3500);

setTimeout(function() {
  MOVIES[4].value = 10;             // coffee is now 10
  animate(MOVIES);
}, 3750);

setTimeout(function() {
  MOVIES[0].value = 15;             // tea is now 15
  animate(MOVIES);
}, 4000);

</script>

</body>
</html>