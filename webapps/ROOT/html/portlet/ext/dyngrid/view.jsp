<%@ include file="/html/portlet/ext/dyngrid/init.jsp" %>
<%@taglib uri='/WEB-INF/tld/cewolf.tld' prefix='cewolf' %>
<%@page import="java.util.*"%>
<%@page import="de.laures.cewolf.*"%>
<%@page import="de.laures.cewolf.tooltips.*"%>
<%@page import="de.laures.cewolf.links.*"%>
<%@page import="org.jfree.data.*"%>
<%@page import="org.jfree.data.time.*"%>
<%@page import="org.jfree.data.gantt.*"%>
<%@page import="org.jfree.chart.*"%>
<%@page import="org.jfree.chart.plot.*"%>
<%@page import="org.jfree.data.category.*"%>
<%@page import="org.jfree.data.general.*"%>
<%@page import="org.jfree.data.xy.*"%>

<%@page import="java.awt.Insets" %>





<%

ArrayList resultList=(ArrayList)request.getAttribute("list");




String title = prefs.getValue("title", StringPool.BLANK);
String sqlquery = prefs.getValue("sqlquery", StringPool.BLANK);
String categories = prefs.getValue("categories", StringPool.BLANK);
String valuesstring = prefs.getValue("valuesstring", StringPool.BLANK);
String seriesstring = prefs.getValue("seriesstring", StringPool.BLANK);
String charttype = prefs.getValue("charttype", StringPool.BLANK);
String widthstr = prefs.getValue("width", StringPool.BLANK);
String heightstr = prefs.getValue("height", StringPool.BLANK);
String showData = prefs.getValue("showData", StringPool.BLANK);

int width =(new Integer(widthstr)).intValue();
int height =(new Integer(heightstr)).intValue();
String hostname=PortalUtil.getPortalURL(request);

hostname+="/cewolf/cewolf";


if(showData.equals("yes")) {
%>


<display:table name="${list}" />

<%
}


try {

if(resultList!=null && resultList.size() >0) {

if (pageContext.getAttribute("initFlag") == null) {

//PIE CHART WITH OUR DATA





	DatasetProducer pieData = new DatasetProducer() {
		public Object produceDataset(Map params) {


			ArrayList myresultList=(ArrayList)params.get("rList");
			String category=(String)params.get("categories");
			String valuestr=(String)params.get("valuesstring");
			String[] categories = new String[myresultList.size()];
			DefaultPieDataset ds = new DefaultPieDataset();


			Iterator itr = myresultList.iterator();
			int j=0;
		while (itr.hasNext()) {
				Map row = (Map)itr.next();
				categories[j]=row.get(category).toString();

					ds.setValue(categories[j], new Double(row.get(valuestr).toString()));
				j++;
			}


			return ds;
		}
		public String getProducerId() {
			return "PieDataProducer";
		}
		public boolean hasExpired(Map params, Date since) {
			return false;
		}
	};
	pageContext.setAttribute("pieData", pieData);

	DatasetProducer categoryData = new DatasetProducer() {
		public Object produceDataset(Map params) {




			ArrayList myresultList=(ArrayList)params.get("rList");
				String category=(String)params.get("categories");
			String valuestr=(String)params.get("valuesstring");

			String seriesstring=(String)params.get("seriesstring");

				String valuescat[] ={""};

			 String[] categories = {""};
			 String[] seriesNames = {""};

			if(seriesstring!=null && !seriesstring.equals("")) {
				seriesNames = seriesstring.split(",");
				categories = new String[myresultList.size()];

			} else {

				categories = new String[myresultList.size()];
			}

			final Double[][] startValues = new Double[seriesNames.length][categories.length];
			final Double[][] endValues = new Double[seriesNames.length][categories.length];


			Iterator itr = myresultList.iterator();
			int j=0;


			if(seriesstring!=null && !seriesstring.equals("")) {
				while (itr.hasNext()) {
				Map row = (Map)itr.next();
				categories[j]=row.get(category).toString();
				for (int i = 0; i < seriesNames.length; i++) {
				startValues[i][j] = new Double(0);
				endValues[i][j] = new Double(0 + new Double(row.get(seriesNames[i]).toString()));
			}
			j++;
			}


		}

			else {

			while (itr.hasNext()) {
				Map row = (Map)itr.next();
				categories[j]=row.get(category).toString();

				startValues[0][j] = new Double(0);
					endValues[0][j] = new Double(0 + new Double(row.get(valuestr).toString()));


				j++;
			}


		}



		/*	final String[] categories = { "apples", "pies", "bananas", "oranges" };
			final String[] seriesNames = { "Peter", "Helga", "Franz", "Olga" };
			final Integer[][] startValues = new Integer[seriesNames.length][categories.length];
			final Integer[][] endValues = new Integer[seriesNames.length][categories.length];
			for (int series = 0; series < seriesNames.length; series++) {
				for (int i = 0; i < categories.length; i++) {
					int y = (int) (Math.random() * 10 + 1);
					startValues[series][i] = new Integer(y);
					endValues[series][i] = new Integer(y + (int) (Math.random() * 10));
				}
			}*/
			DefaultIntervalCategoryDataset ds =
				new DefaultIntervalCategoryDataset(seriesNames, categories, startValues, endValues);
			return ds;
		}
		public String getProducerId() {
			return "CategoryDataProducer";
		}
		public boolean hasExpired(Map params, Date since) {
			return false;
		}
	};
	pageContext.setAttribute("categoryData", categoryData);




	CategoryToolTipGenerator catTG = new CategoryToolTipGenerator() {
		public String generateToolTip(CategoryDataset dataset, int series, int index) {
			return String.valueOf(dataset.getValue(series, index));
		}
	};
	pageContext.setAttribute("categoryToolTipGenerator", catTG);

	PieToolTipGenerator pieTG = new PieToolTipGenerator() {
		public String generateToolTip(PieDataset dataset, Comparable section, int index) {
			return String.valueOf(index);
		}
	};
	pageContext.setAttribute("pieToolTipGenerator", pieTG);







	ChartPostProcessor dataColor = new ChartPostProcessor() {
		public void processChart(Object chart, Map params) {

		java.awt.Font	 labelFont = new java.awt.Font("Helvetica", java.awt.Font.PLAIN, 10);
    java.awt.Font    titleFont = new java.awt.Font("Arial Greek", java.awt.Font.BOLD, 12);

			CategoryPlot plot = (CategoryPlot) ((JFreeChart) chart).getPlot();
			for (int i = 0; i < params.size(); i++) {
				String colorStr = (String) params.get(String.valueOf(i));
				plot.getRenderer().setSeriesPaint(i, java.awt.Color.decode(colorStr));
			}


			plot.setBackgroundPaint(java.awt.Color.lightGray);
        plot.setOutlinePaint(java.awt.Color.white);
        plot.setOrientation(PlotOrientation.VERTICAL);
			((JFreeChart) chart).setBackgroundPaint(java.awt.Color.white);

		((JFreeChart) chart).getTitle().setFont(titleFont);
			//System.out.println(((JFreeChart) chart).getTitle().getText());
		}
	};
	pageContext.setAttribute("dataColor", dataColor);
	pageContext.setAttribute("initFlag", "init");
		}
%>



<table border=0>

<tr><td>&nbsp;</td></tr>



<TR>
<TD>
<% if(charttype.equals("piechart")) {%>
	<cewolf:chart id="pieChart" title="<%=title%>" type="pie">
    <cewolf:gradientpaint>
        <cewolf:point x="0" y="0" color="#FFFFFF" />
        <cewolf:point x="300" y="0" color="#DDDDFF" />
    </cewolf:gradientpaint>
    <cewolf:data>
        <cewolf:producer id="pieData" >
        <cewolf:param name="rList" value="<%=resultList%>"/>
        <cewolf:param name="categories" value="<%=categories%>"/>
        <cewolf:param name="valuesstring" value="<%=valuesstring%>"/>


       </cewolf:producer>
    </cewolf:data>

</cewolf:chart>
<cewolf:img chartid="pieChart" renderer="<%=hostname%>" width="<%=width%>"  height="<%=height%>"/>

<%} else if(charttype.equals("areaChart")) {%>


<cewolf:chart id="areaChart" title="<%=title%>" type="area" xaxislabel="<%=categories%>" yaxislabel="<%=valuesstring%>"  background="/img/bg.jpg">
    <cewolf:data>
        <cewolf:producer id="categoryData" >
        <cewolf:param name="rList" value="<%=resultList%>"/>
           <cewolf:param name="categories" value="<%=categories%>"/>
        <cewolf:param name="valuesstring" value="<%=valuesstring%>"/>
          <cewolf:param name="seriesstring" value="<%=seriesstring%>"/>
       </cewolf:producer>
    </cewolf:data>
     <cewolf:chartpostprocessor id="dataColor">
        <cewolf:param name="0" value='<%= "#339900" %>'/>
        <cewolf:param name="1" value='<%= "#cc0000" %>'/>
        <cewolf:param name="2" value='<%= "#0000cc" %>'/>
        <cewolf:param name="3" value='<%= "#666600" %>'/>
        <cewolf:param name="4" value='<%= "#00cc99"%>'/>
         <cewolf:param name="5" value='<%= "#33cc00"%>'/>
        <cewolf:param name="6" value='<%= "#cccc66"%>'/>
        <cewolf:param name="7" value='<%= "#cc99cc"%>'/>
        <cewolf:param name="8" value='<%= "#00cc66"%>'/>
        <cewolf:param name="9" value='<%= "#cccc33"%>'/>
        <cewolf:param name="10" value='<%= "#00ffcc"%>'/>
    </cewolf:chartpostprocessor>
</cewolf:chart>
<cewolf:img chartid="areaChart" renderer="<%=hostname%>" width="<%=width%>"  height="<%=height%>"/>


<%} else if(charttype.equals("horizontalBarChart3D")) {%>


<cewolf:chart id="horizontalBarChart3D" title="<%=title%>" type="horizontalBar3D" xaxislabel="<%=categories%>" yaxislabel="<%=valuesstring%>">
    <cewolf:data>
        <cewolf:producer id="categoryData" >
 <cewolf:param name="rList" value="<%=resultList%>"/>
    <cewolf:param name="categories" value="<%=categories%>"/>
        <cewolf:param name="valuesstring" value="<%=valuesstring%>"/>
            <cewolf:param name="seriesstring" value="<%=seriesstring%>"/>

</cewolf:producer>
    </cewolf:data>
     <cewolf:chartpostprocessor id="dataColor">
        <cewolf:param name="0" value='<%= "#339900" %>'/>
        <cewolf:param name="1" value='<%= "#cc0000" %>'/>
        <cewolf:param name="2" value='<%= "#0000cc" %>'/>
        <cewolf:param name="3" value='<%= "#666600" %>'/>
        <cewolf:param name="4" value='<%= "#00cc99"%>'/>
         <cewolf:param name="5" value='<%= "#33cc00"%>'/>
        <cewolf:param name="6" value='<%= "#cccc66"%>'/>
        <cewolf:param name="7" value='<%= "#cc99cc"%>'/>
        <cewolf:param name="8" value='<%= "#00cc66"%>'/>
        <cewolf:param name="9" value='<%= "#cccc33"%>'/>
        <cewolf:param name="10" value='<%= "#00ffcc"%>'/>
    </cewolf:chartpostprocessor>
</cewolf:chart>
<cewolf:img chartid="horizontalBarChart3D" renderer="<%=hostname%>" width="<%=width%>"  height="<%=height%>"/></TD>




<%} else if(charttype.equals("lineChart")) {%>


<cewolf:chart id="lineChart" title="<%=title%>" type="line" xaxislabel="<%=categories%>" yaxislabel="<%=valuesstring%>">
    <cewolf:data>
        <cewolf:producer id="categoryData" >
 <cewolf:param name="rList" value="<%=resultList%>"/>
    <cewolf:param name="categories" value="<%=categories%>"/>
        <cewolf:param name="valuesstring" value="<%=valuesstring%>"/>
        <cewolf:param name="seriesstring" value="<%=seriesstring%>"/>

</cewolf:producer>
    </cewolf:data>
     <cewolf:chartpostprocessor id="dataColor">
        <cewolf:param name="0" value='<%= "#339900" %>'/>
        <cewolf:param name="1" value='<%= "#cc0000" %>'/>
        <cewolf:param name="2" value='<%= "#0000cc" %>'/>
        <cewolf:param name="3" value='<%= "#666600" %>'/>
        <cewolf:param name="4" value='<%= "#00cc99"%>'/>
         <cewolf:param name="5" value='<%= "#33cc00"%>'/>
        <cewolf:param name="6" value='<%= "#cccc66"%>'/>
        <cewolf:param name="7" value='<%= "#cc99cc"%>'/>
        <cewolf:param name="8" value='<%= "#00cc66"%>'/>
        <cewolf:param name="9" value='<%= "#cccc33"%>'/>
        <cewolf:param name="10" value='<%= "#00ffcc"%>'/>
    </cewolf:chartpostprocessor>
</cewolf:chart>
<cewolf:img chartid="lineChart" renderer="<%=hostname%>" width="<%=width%>"  height="<%=height%>"/>

<%} else if(charttype.equals("stackedHorizontalBar")) {%>

<cewolf:chart id="stackedHorizontalBar" title="<%=title%>" type="stackedHorizontalBar" xaxislabel="<%=categories%>" yaxislabel="<%=valuesstring%>">
    <cewolf:data>
        <cewolf:producer id="categoryData" >
 <cewolf:param name="rList" value="<%=resultList%>"/>
    <cewolf:param name="categories" value="<%=categories%>"/>
        <cewolf:param name="valuesstring" value="<%=valuesstring%>"/>
        <cewolf:param name="seriesstring" value="<%=seriesstring%>"/>

</cewolf:producer>
    </cewolf:data>
    <cewolf:chartpostprocessor id="dataColor">
        <cewolf:param name="0" value='<%= "#339900" %>'/>
        <cewolf:param name="1" value='<%= "#cc0000" %>'/>
        <cewolf:param name="2" value='<%= "#0000cc" %>'/>
        <cewolf:param name="3" value='<%= "#666600" %>'/>
        <cewolf:param name="4" value='<%= "#00cc99"%>'/>
         <cewolf:param name="5" value='<%= "#33cc00"%>'/>
        <cewolf:param name="6" value='<%= "#cccc66"%>'/>
        <cewolf:param name="7" value='<%= "#cc99cc"%>'/>
        <cewolf:param name="8" value='<%= "#00cc66"%>'/>
        <cewolf:param name="9" value='<%= "#cccc33"%>'/>
        <cewolf:param name="10" value='<%= "#00ffcc"%>'/>
    </cewolf:chartpostprocessor>
</cewolf:chart>
<cewolf:img chartid="stackedHorizontalBar" renderer="<%=hostname%>" width="<%=width%>"  height="<%=height%>"/>

<%} else if(charttype.equals("stackedVerticalBar")) {%>



<cewolf:chart id="stackedVerticalBar" title="<%=title%>" type="stackedVerticalBar" xaxislabel="<%=categories%>" yaxislabel="<%=valuesstring%>">
    <cewolf:data>
        <cewolf:producer id="categoryData" >
 <cewolf:param name="rList" value="<%=resultList%>"/>
    <cewolf:param name="categories" value="<%=categories%>"/>
        <cewolf:param name="valuesstring" value="<%=valuesstring%>"/>
        <cewolf:param name="seriesstring" value="<%=seriesstring%>"/>

</cewolf:producer>
    </cewolf:data>
     <cewolf:chartpostprocessor id="dataColor">
        <cewolf:param name="0" value='<%= "#339900" %>'/>
        <cewolf:param name="1" value='<%= "#cc0000" %>'/>
        <cewolf:param name="2" value='<%= "#0000cc" %>'/>
        <cewolf:param name="3" value='<%= "#666600" %>'/>
        <cewolf:param name="4" value='<%= "#00cc99"%>'/>
         <cewolf:param name="5" value='<%= "#33cc00"%>'/>
        <cewolf:param name="6" value='<%= "#cccc66"%>'/>
        <cewolf:param name="7" value='<%= "#cc99cc"%>'/>
        <cewolf:param name="8" value='<%= "#00cc66"%>'/>
        <cewolf:param name="9" value='<%= "#cccc33"%>'/>
        <cewolf:param name="10" value='<%= "#00ffcc"%>'/>
    </cewolf:chartpostprocessor>
</cewolf:chart>
<cewolf:img chartid="stackedVerticalBar" renderer="<%=hostname%>" width="<%=width%>"  height="<%=height%>"/>

<%} else if(charttype.equals("stackedVerticalBar3D")) {%>


<cewolf:chart id="stackedVerticalBar3D" title="<%=title%>" type="stackedVerticalBar3D" xaxislabel="<%=categories%>" yaxislabel="<%=valuesstring%>">
    <cewolf:data>
        <cewolf:producer id="categoryData" >
 <cewolf:param name="rList" value="<%=resultList%>"/>
    <cewolf:param name="categories" value="<%=categories%>"/>
        <cewolf:param name="valuesstring" value="<%=valuesstring%>"/>
          <cewolf:param name="seriesstring" value="<%=seriesstring%>"/>
</cewolf:producer>
    </cewolf:data>
     <cewolf:chartpostprocessor id="dataColor">
        <cewolf:param name="0" value='<%= "#339900" %>'/>
        <cewolf:param name="1" value='<%= "#cc0000" %>'/>
        <cewolf:param name="2" value='<%= "#0000cc" %>'/>
        <cewolf:param name="3" value='<%= "#666600" %>'/>
        <cewolf:param name="4" value='<%= "#00cc99"%>'/>
         <cewolf:param name="5" value='<%= "#33cc00"%>'/>
        <cewolf:param name="6" value='<%= "#cccc66"%>'/>
        <cewolf:param name="7" value='<%= "#cc99cc"%>'/>
        <cewolf:param name="8" value='<%= "#00cc66"%>'/>
        <cewolf:param name="9" value='<%= "#cccc33"%>'/>
        <cewolf:param name="10" value='<%= "#00ffcc"%>'/>
    </cewolf:chartpostprocessor>
</cewolf:chart>
<cewolf:img chartid="stackedVerticalBar3D" renderer="<%=hostname%>" width="<%=width%>"  height="<%=height%>"/>


<%} else if(charttype.equals("VerticalBarChart")) {%>


<cewolf:chart
	id="verticalBar"
	title="<%=title%>"
	type="verticalBar"
xaxislabel="<%=categories%>" yaxislabel="<%=valuesstring%>">
    <cewolf:data>
        <cewolf:producer id="categoryData" >
 <cewolf:param name="rList" value="<%=resultList%>"/>
    <cewolf:param name="categories" value="<%=categories%>"/>
        <cewolf:param name="valuesstring" value="<%=valuesstring%>"/>
          <cewolf:param name="seriesstring" value="<%=seriesstring%>"/>
</cewolf:producer>
    </cewolf:data>
     <cewolf:chartpostprocessor id="dataColor">
        <cewolf:param name="0" value='<%= "#339900" %>'/>
        <cewolf:param name="1" value='<%= "#cc0000" %>'/>
        <cewolf:param name="2" value='<%= "#0000cc" %>'/>
        <cewolf:param name="3" value='<%= "#666600" %>'/>
        <cewolf:param name="4" value='<%= "#00cc99"%>'/>
         <cewolf:param name="5" value='<%= "#33cc00"%>'/>
        <cewolf:param name="6" value='<%= "#cccc66"%>'/>
        <cewolf:param name="7" value='<%= "#cc99cc"%>'/>
        <cewolf:param name="8" value='<%= "#00cc66"%>'/>
        <cewolf:param name="9" value='<%= "#cccc33"%>'/>
        <cewolf:param name="10" value='<%= "#00ffcc"%>'/>
    </cewolf:chartpostprocessor>
</cewolf:chart>
<cewolf:img
	chartid="verticalBar"
	renderer="<%=hostname%>"
	width="300"
	height="300"/>


<%} else if(charttype.equals("verticalBar3D")) {%>


<cewolf:chart id="verticalBar3D" title="<%=title%>" type="verticalBar3D" xaxislabel="<%=categories%>" yaxislabel="<%=valuesstring%>">
    <cewolf:data>
        <cewolf:producer id="categoryData" >
 <cewolf:param name="rList" value="<%=resultList%>"/>
    <cewolf:param name="categories" value="<%=categories%>"/>
        <cewolf:param name="valuesstring" value="<%=valuesstring%>"/>
          <cewolf:param name="seriesstring" value="<%=seriesstring%>"/>
</cewolf:producer>
    </cewolf:data>
     <cewolf:chartpostprocessor id="dataColor">
        <cewolf:param name="0" value='<%= "#339900" %>'/>
        <cewolf:param name="1" value='<%= "#cc0000" %>'/>
        <cewolf:param name="2" value='<%= "#0000cc" %>'/>
        <cewolf:param name="3" value='<%= "#666600" %>'/>
        <cewolf:param name="4" value='<%= "#00cc99"%>'/>
         <cewolf:param name="5" value='<%= "#33cc00"%>'/>
        <cewolf:param name="6" value='<%= "#cccc66"%>'/>
        <cewolf:param name="7" value='<%= "#cc99cc"%>'/>
        <cewolf:param name="8" value='<%= "#00cc66"%>'/>
        <cewolf:param name="9" value='<%= "#cccc33"%>'/>
        <cewolf:param name="10" value='<%= "#00ffcc"%>'/>
    </cewolf:chartpostprocessor>
</cewolf:chart>
<cewolf:img chartid="verticalBar3D" renderer="<%=hostname%>" width="<%=width%>"  height="<%=height%>"/>


<%} else if(charttype.equals("stackedArea")) {%>


<cewolf:chart id="stackedArea" title="<%=title%>" type="stackedarea">
    <cewolf:data>
        <cewolf:producer id="categoryData" >
 <cewolf:param name="rList" value="<%=resultList%>"/>
    <cewolf:param name="categories" value="<%=categories%>"/>
        <cewolf:param name="valuesstring" value="<%=valuesstring%>"/>
          <cewolf:param name="seriesstring" value="<%=seriesstring%>"/>
</cewolf:producer>
    </cewolf:data>
     <cewolf:chartpostprocessor id="dataColor">
        <cewolf:param name="0" value='<%= "#339900" %>'/>
        <cewolf:param name="1" value='<%= "#cc0000" %>'/>
        <cewolf:param name="2" value='<%= "#0000cc" %>'/>
        <cewolf:param name="3" value='<%= "#666600" %>'/>
        <cewolf:param name="4" value='<%= "#00cc99"%>'/>
         <cewolf:param name="5" value='<%= "#33cc00"%>'/>
        <cewolf:param name="6" value='<%= "#cccc66"%>'/>
        <cewolf:param name="7" value='<%= "#cc99cc"%>'/>
        <cewolf:param name="8" value='<%= "#00cc66"%>'/>
        <cewolf:param name="9" value='<%= "#cccc33"%>'/>
        <cewolf:param name="10" value='<%= "#00ffcc"%>'/>
    </cewolf:chartpostprocessor>
</cewolf:chart>
<cewolf:img chartid="stackedArea" renderer="<%=hostname%>" width="<%=width%>"  height="<%=height%>" />

<%}%>

</TD>
</TR>
</TABLE>


<%
}
 } catch (Exception e) {
	e.printStackTrace();
}
%>