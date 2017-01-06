<!-- 
Written by Ankeet Tendulkar
USC CSCI 548 Fall 2016
This page gives different graphical representations of the data integrated from over three different sources using D3.
-->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>   

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<!-- Gauge -->
<style>
.chart .legend {
  fill: black;
  font: 14px sans-serif;
  text-anchor: start;
  font-size: 12px;
}

canvas {
float: left;
margin-top: 25px;
margin-left: 50px;
}

#line {
float: right;
margin-top: 80px;

}

#abcd {
padding-bottom: 30px;
}

.chart text {
  fill: white;
  font: 10px sans-serif;
  text-anchor: end;
}

.chart .label {
  fill: black;
  font: 14px sans-serif;
  text-anchor: end;
}

.bar:hover {
  fill: brown;
}

.axis path,
.axis line {
  fill: none;
  stroke: #000;
  shape-rendering: crispEdges;
}

.label{
	font-size:12px;
	fill:#ffffff;
	text-anchor:middle;
	alignment-baseline:middle;
}

a.button {
    -webkit-appearance: button;
    -moz-appearance: button;
    appearance: button;
	size: 30px;
    text-decoration: none;
    color: initial;
}

.face{
	stroke:#c8c8c8;
	stroke-width:2;
}

.majorTicks{
	stroke:white;
	stroke-width:3;
}

.chart {
	width:1100 px; !important
}

.abcd {
	width: 1100px;
}
</style>




<!-- Line Chart -->

<link rel="stylesheet" type="text/css" href="line.css"/>
<script type="text/javascript" src="http://d3js.org/d3.v3.min.js"></script>
<script src="http://labratrevenge.com/d3-tip/javascripts/d3.tip.v0.6.3.js"></script>



</head>
<body>

<!DOCTYPE html>
<meta charset="utf-8">

<% ArrayList Inner = new ArrayList(); %>

<% Inner = (ArrayList)request.getAttribute("Outer_ArrayList"); %>
<button onclick="location.href='Search.jsp'" type="button" style="width: 20em; height: 3em;">
     <strong>Return to homepage</strong></button>
<h1 align="center" style="font-size: 50px; line-height: 20px;"><font face="MV Boli" color="#008B8B"><%=Inner.get(1)%></font></h1>
<h1 align="center" style="font-size: 35px; line-height: 20px;"><font face="MV Boli" color="#008B8B"><%=Inner.get(0)%></font></h1>

<hr width="80%">

<div style="float:left; width: 650px;">


<h1 align="center" style="font-size:36px;"><font face="MV Boli">Bechdel Results</font></h1>

<% if(Inner.get(10).equals("Passed")) {%>
<h1 align="center" style="font-size:30px; color:green">PASS</h1>
<% }else{ %>
<h1 align="center" style="font-size:30px; color:red">FAIL</h1>
<%} %>


<div style="height:220px;width:300px; margin-left: 180px; font-size: 16px; border:1px solid #ccc; overflow:scroll; overflow-y:scroll; overflow-x:hidden;">
<%=Inner.get(9)%>
</div>	
</div>


<div style="margin-top: 30px;">
<h1 align="center" style="font-size:36px;"><font face="MV Boli">Gender Results</font></h1>
<svg class="chart" style="margin-bottom: 20px;"></svg>
<script src="http://d3js.org/d3.v3.min.js"></script>
<script>

var data = {
  labels: [
    'Actors', 'Directors', 'Writers',
    'Producers', 'Editors', 'Camera Artists','Sound Artists'
  ],
  series: [
    {
      label: 'Male',
      values: ["<%=Inner.get(18)%>", "<%=Inner.get(20)%>", "<%=Inner.get(22)%>", "<%=Inner.get(30)%>", "<%=Inner.get(26)%>", "<%=Inner.get(28)%>", "<%=Inner.get(24)%>"]
    },

    {
      label: 'Female',
      values: ["<%=Inner.get(19)%>", "<%=Inner.get(21)%>", "<%=Inner.get(23)%>", "<%=Inner.get(31)%>", "<%=Inner.get(27)%>", "<%=Inner.get(29)%>", "<%=Inner.get(25)%>"]
    },]
};

var chartWidth       = 400,
    barHeight        = 20,
    groupHeight      = barHeight * data.series.length,
    gapBetweenGroups = 10,
    spaceForLabels   = 150,
    spaceForLegend   = 150;

// Zip the series data together (first values, second values, etc.)
var zippedData = [];
for (var i=0; i<data.labels.length; i++) {
  for (var j=0; j<data.series.length; j++) {
    zippedData.push(data.series[j].values[i]);
  }
}

// Color scale
var color = d3.scale.category20();
var chartHeight = barHeight * zippedData.length + gapBetweenGroups * data.labels.length;

var x = d3.scale.linear()
    .domain([0, d3.max(zippedData)])
    .range([0, chartWidth]);

var y = d3.scale.linear()
    .range([chartHeight + gapBetweenGroups, 0]);

var yAxis = d3.svg.axis()
    .scale(y)
    .tickFormat('')
    .tickSize(0)
    .orient("left");

// Specify the chart area and dimensions
var chart = d3.select(".chart")
    .attr("width", spaceForLabels + chartWidth + spaceForLegend)
    .attr("height", chartHeight).style("float", "right");

// Create bars
var bar = chart.selectAll("g")
    .data(zippedData)
    .enter().append("g")
    .attr("transform", function(d, i) {
      return "translate(" + spaceForLabels + "," + (i * barHeight + gapBetweenGroups * (0.5 + Math.floor(i/data.series.length))) + ")";
    });

// Create rectangles of the correct width
bar.append("rect")
    .attr("fill", function(d,i) { return color(i % data.series.length); })
    .attr("class", "bar")
    .attr("width", x)
    .attr("height", barHeight - 1);

// Add text label in bar
bar.append("text")
    .attr("x", function(d) { return x(d) - 3; })
    .attr("y", barHeight / 2)
    .attr("fill", "red")
    .attr("dy", ".35em")
    .text(function(d) { return d; });

// Draw labels
bar.append("text")
    .attr("class", "label")
    .attr("x", function(d) { return - 10; })
    .attr("y", groupHeight / 2)
    .attr("dy", ".35em")
    .text(function(d,i) {
      if (i % data.series.length === 0)
        return data.labels[Math.floor(i/data.series.length)];
      else
        return ""});

chart.append("g")
      .attr("class", "y axis")
      .attr("transform", "translate(" + spaceForLabels + ", " + -gapBetweenGroups/2 + ")")
      .call(yAxis);

// Draw legend
var legendRectSize = 18,
    legendSpacing  = 4;

var legend = chart.selectAll('.legend')
    .data(data.series)
    .enter()
    .append('g')
    .attr('transform', function (d, i) {
        var height = legendRectSize + legendSpacing;
        var offset = -gapBetweenGroups/2;
        var horz = spaceForLabels + chartWidth + 40 - legendRectSize;
        var vert = i * height - offset;
        return 'translate(' + horz + ',' + vert + ')';
    });

legend.append('rect')
    .attr('width', legendRectSize)
    .attr('height', legendRectSize)
    .style('fill', function (d, i) { return color(i); })
    .style('stroke', function (d, i) { return color(i); });

legend.append('text')
    .attr('class', 'legend')
    .attr('x', legendRectSize + legendSpacing)
    .attr('y', legendRectSize - legendSpacing)
    .text(function (d) { return d.label; });

</script>
</div>


<hr width="80%">


<div>

<h1 style="margin: 20px 0 0 190px; padding-top:20px; font-size: 30px;"><font face="MV Boli" >Profanity Level &nbsp; &nbsp; &nbsp; &nbsp; Sex/Nuditiy Level &nbsp; &nbsp; &nbsp; Violence/Gore Level</font></h1>

<svg id="abcd" width="1200" height="200" style="margin: 20px 0 0 200px;"></svg>
<script src="https://d3js.org/d3.v3.min.js"></script>
<script src="http://vizjs.org/viz.v1.0.0.min.js"></script>

<script>
  var svg=d3.select("#abcd");
  var g=svg.append("g").attr("transform","translate(100,100)");
  
  var domain = [0,100];
  
  var gg = viz.gg()
	.domain(domain)
	.outerRadius(100)
	.innerRadius(10)
	.value("<%=Inner.get(11)%>" * 10)
	.duration(1000);
  
  gg.defs(svg);
  g.call(gg);  
  
  d3.select(self.frameElement).style("height", "700px");
  setInterval( function(){gg.setNeedle(a);},2000);
</script>
<script>
  var svg=d3.select("#abcd");
  var g=svg.append("g").attr("transform","translate(480,100)");
  var domain = [0,100];
  
  var gg = viz.gg()
	.domain(domain)
	.outerRadius(100)
	.innerRadius(10)
	.value("<%=Inner.get(12)%>" * 10)
	.duration(1000);
  
  gg.defs(svg);
  g.call(gg);  
  
  
  //d3.select(self.frameElement).style("width", "1000px");
  setInterval( function(){gg.setNeedle(a);},2000);
</script>

<script>
  var svg=d3.select("#abcd");
  var g=svg.append("g").attr("transform","translate(850,100)");
  var domain = [0,100];
  
  var gg = viz.gg()
	.domain(domain)
	.outerRadius(100)
	.innerRadius(10)
	.value("<%=Inner.get(13)%>" * 10)
	.duration(1000);
  
  gg.defs(svg);
  g.call(gg);  
  
  d3.select(self.frameElement).style("height", "700px");
  setInterval( function(){gg.setNeedle(a);},2000);
</script>
</div>

<p style="width: 280px; word-break: keep-all; diplay:block; float: left; margin: 15px 0 30px 185px; font-size:16px;">"<%=Inner.get(14)%>"</p>
<p style="width: 280px; word-break: keep-all; diplay:block; float:left; margin-bottom: 35px; padding-left: 90px; font-size:16px;">"<%=Inner.get(15)%>"</p>
<p style="width: 280px; word-break: keep-all; diplay:block; float:left; margin-bottom: 35px; padding-left: 90px; font-size:16px;">"<%=Inner.get(16)%>"</p>

<hr width="80%">


<!-- Pie Chart -->
<div id="pie">
<h1 style="margin-left: 270px; font-size: 36px;"><font face="MV Boli">Release year &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;Over the years</font></h1>
<script src="pieChartNew.js"></script>
	<script>
		window.onload = function () {
			var total = parseInt("<%=Inner.get(32)%>") + parseInt("<%=Inner.get(33)%>") + parseInt("<%=Inner.get(34)%>") + parseInt("<%=Inner.get(35)%>");
			var v1 = ("<%=Inner.get(32)%>" / total) * 100;
			var v2 = ("<%=Inner.get(33)%>" / total) * 100;
			var v3 = ("<%=Inner.get(34)%>" / total) * 100;
			var v4 = ("<%=Inner.get(35)%>" / total) * 100;
			
			console.log(total)
			console.log(v1);
			console.log(v2);
			console.log(v3);
			console.log(v4);
			var data = [
				{
					"name": "Passed 0 tests",
					"value": v1
				},
				{
					"name": "Passed 1 test",
					"value": v2
				},
				{
					"name": "Passed 2 tests",
					"value": v3
				},
				{
					"name": "Passed 3 tests",
					"value": v4
				}
			];
			new PieChart(data, { size: "400px" });
		}
	</script>
	</div>
	
<!-- Line Graph -->
<div id="line">

    <script>
            var data = [{
                "date": "1991",
                    "Pass": "3",
                    "NotPassed": "3"
            }, {
                "date": "1992",
                    "Pass": "9",
                    "NotPassed": "21"
            }, {
                "date": "1993",
                    "Pass": "27",
                    "NotPassed": "27"
            }, {
                "date": "1994",
                    "Pass": "30",
                    "NotPassed": "18"
            }, {
                "date": "1995",
                    "Pass": "18",
                    "NotPassed": "36"
            }, {
                "date": "1996",
                    "Pass": "18",
                    "NotPassed": "30"
            }, {
                "date": "1997",
                    "Pass": "33",
                    "NotPassed": "30"
            }, {
                "date": "1998",
                    "Pass": "45",
                    "NotPassed": "42"
            }, {
                "date": "1999",
                    "Pass": "51",
                    "NotPassed": "39"
            }, {
                "date": "2000",
                    "Pass": "39",
                    "NotPassed": "18"
            }, {
                "date": "2001",
                    "Pass": "57",
                    "NotPassed": "36"
            }, {
                "date": "2002",
                    "Pass": "36",
                    "NotPassed": "42"
            }, {
                "date": "2003",
                    "Pass": "45",
                    "NotPassed": "33"
            }, {
                "date": "2004",
                    "Pass": "60",
                    "NotPassed": "48"
            }, {
                "date": "2005",
                    "Pass": "60",
                    "NotPassed": "33"
            }, {
                "date": "2006",
                    "Pass": "66",
                    "NotPassed": "48"
            }, {
                "date": "2007",
                    "Pass": "84",
                    "NotPassed": "57"
            }, {
                "date": "2008",
                    "Pass": "69",
                    "NotPassed": "63"
            }, {
                "date": "2009",
                    "Pass": "78",
                    "NotPassed": "69"
            }, {
                "date": "2010",
                    "Pass": "93",
                    "NotPassed": "75"
            }, {
                "date": "2011",
                    "Pass": "120",
                    "NotPassed": "102"
            }, {
                "date": "2012",
                    "Pass": "99",
                    "NotPassed": "96"
            }, {
                "date": "2013",
                    "Pass": "180",
                    "NotPassed": "120"
            }, {
                "date": "2014",
                    "Pass": "156",
                    "NotPassed": "132"
            }, {
                "date": "2015",
                    "Pass": "153",
                    "NotPassed": "132"
            }, {
                "date": "2016",
                    "Pass": "84",
                    "NotPassed": "57"
            }];
            var margin = {
                top: 50,
                right: 45,
                bottom: 30,
                left:30
            },
            width = 600 - margin.left - margin.right,
                height = 500 - margin.top - margin.bottom;
            var parseDate = d3.time.format("%Y").parse;
            var x = d3.time.scale()
                .range([0, width]);
            var y = d3.scale.linear()
                .range([height, 0]);
            var color = d3.scale.ordinal()
              .domain(["USA", "China*"])
              .range(["#A3EEFF", "#0050FF"]);
            var xAxis = d3.svg.axis()
                .scale(x)
                .orient("bottom");
            var yAxis = d3.svg.axis()
                .scale(y)
                .orient("left");
            var line = d3.svg.line()
                .interpolate("basis")
                .x(function (d) {
                return x(d.date);
            })
                .y(function (d) {
                return y(d.temperature);
            });
            var svg = d3.select("body").append("svg")
                .attr("width", width + margin.left + margin.right)
                .attr("height", height + margin.top + margin.bottom)
                .style("margin-left", "120px")
                .style("margin-top", "-50px")
                .append("g")
                .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
            color.domain(d3.keys(data[0]).filter(function (key) {
                return key !== "date";
            }));
            data.forEach(function (d) {
                d.date = parseDate(d.date);
            });
            var cities = color.domain().map(function (name) {
                return {
                    name: name,
                    values: data.map(function (d) {
                        return {
                            date: d.date,
                            temperature: +d[name]
                        };
                    })
                };
            });
            x.domain(d3.extent(data, function (d) {
                return d.date;
            }));
            y.domain([
            d3.min(cities, function (c) {
                return d3.min(c.values, function (v) {
                    return v.temperature;
                });
            }),
            d3.max(cities, function (c) {
                return d3.max(c.values, function (v) {
                    return v.temperature;
                });
            })]);
            svg.append("g")
                .attr("class", "x axis")
                .attr("transform", "translate(0," + height + ")")
                .call(xAxis);
            svg.append("g")
                .attr("class", "y axis")
                .call(yAxis)
                .append("text")
                .attr("transform", "rotate(-90)")
                .attr("y", 6)
                .attr("dy", ".71em")
                .style("text-anchor", "end")
                .text("Number of Movies");
            var city = svg.selectAll(".city")
                .data(cities)
                .enter().append("g")
                .attr("class", "city");
            city.append("path")
                .attr("class", "line")
                .attr("d", function (d) {
                return line(d.values);
            })
                .style("stroke", function (d) {
                return color(d.name);
            });
            city.append("text")
                .datum(function (d) {
                return {
                    name: d.name,
                    value: d.values[d.values.length - 1]
                };
            })
                .attr("transform", function (d) {
                return "translate(" + x(d.value.date) + "," + y(d.value.temperature) + ")";
            })
                .attr("x", 3)
                .attr("dy", ".35em")
                .text(function (d) {
                return d.name;
            });
    </script>
    </div>

</body>
</html>