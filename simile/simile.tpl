<html>
	<head>
		<script src="http://simile.mit.edu/timeline/api/timeline-api.js" type="text/javascript"></script>
		<script src="http://simile.mit.edu/timeline/examples/examples.js" type="text/javascript"></script>

		<title>testfoo</title>
		<script language="javascript">
			// bugfix to show correct Timezone in popups
		/*	Timeline.DefaultEventSource.Event.prototype.fillTime = function(elmt, labeller) {
				if (this._instant) {
					if (this.isImprecise()) {
						elmt.appendChild(elmt.ownerDocument.createTextNode(this.getProperty("start")));
						elmt.appendChild(elmt.ownerDocument.createElement("br"));
						elmt.appendChild(elmt.ownerDocument.createTextNode(this.getProperty("end")));
					} else {
						elmt.appendChild(elmt.ownerDocument.createTextNode(this.getProperty("start")));
					}
				} else {
					if (this.isImprecise()) {
						elmt.appendChild(elmt.ownerDocument.createTextNode(this.getProperty("start") + " ~ " + this.getProperty("latestStart")));
						elmt.appendChild(elmt.ownerDocument.createElement("br"));
						elmt.appendChild(elmt.ownerDocument.createTextNode(this.getProperty("earliestEnd") + " ~ " + this.getProperty("end")));
					} else {
						elmt.appendChild(elmt.ownerDocument.createTextNode(this.getProperty("start")));
						elmt.appendChild(elmt.ownerDocument.createElement("br"));
						elmt.appendChild(elmt.ownerDocument.createTextNode(this.getProperty("end")));
					}
				}
			};*/
			var tl;
			function onLoad() {
				var eventSource = new Timeline.DefaultEventSource();

				var theme = Timeline.ClassicTheme.create();
				theme.event.label.width = 500; // px
				//theme.event.label.vertical-align = "middle";
				theme.event.bubble.width = 250;
				theme.event.bubble.height = 200;
				var today = new Date();

				var bandInfos = [
					Timeline.createBandInfo({
						//timeZone:	-1,
						eventSource:	eventSource,
						width:		"67%", 
						intervalUnit:	Timeline.DateTime.DAY, 
						intervalPixels:	100,
						theme:		theme,
						trackHeight:    2,
					}),
					Timeline.createBandInfo({
						//timeZone:	-1,
						showEventText:  false,
						trackHeight:    0.6,
						trackGap:       0.2,
						eventSource:    eventSource,
						width:          "22%", 
						intervalUnit:   Timeline.DateTime.MONTH, 
						intervalPixels: 200,
						theme:		theme
					}),
					Timeline.createBandInfo({
						//timeZone:	-1,
						showEventText:  false,
						trackHeight:    0.3,
						trackGap:       0.2,
						eventSource:    eventSource,
						width:          "11%", 
						intervalUnit:   Timeline.DateTime.YEAR, 
						intervalPixels: 400,
						theme:		theme
					})
				]; 
				bandInfos[1].syncWith = 0;
				bandInfos[1].highlight = true;
				bandInfos[1].eventPainter.setLayout(bandInfos[0].eventPainter.getLayout());
				bandInfos[2].syncWith = 0;
				bandInfos[2].highlight = true;
				bandInfos[2].eventPainter.setLayout(bandInfos[0].eventPainter.getLayout());

				for (var i = 0; i < bandInfos.length; i++) {
					bandInfos[i].decorators = [
						new Timeline.PointHighlightDecorator({
							date:       today,
							color:      "#FFC080",
							opacity:    50,
							theme:      theme
						})
					];
				}
            

				tl = Timeline.create(document.getElementById("tl"), bandInfos);

				var kalender_url = "http://kalender.scoutnet.de/2.0/show.php?id=3&content_type=xml&nogz&template=export/simile_timeline_xml.tpl&charset=utf8";
				Timeline.loadXML(kalender_url, function(xml, url) { eventSource.loadXML(xml, url); });
				//Timeline.loadXML("http://kalender.scoutnet.de/tmp/jfk.xml", function(xml, url) { eventSource.loadXML(xml, url); });
				setupFilterHighlightControls(document.getElementById("controls"),tl,[0,1],theme);
			}

			var resizeTimerID = null;
			function onResize() {
				if (resizeTimerID == null) {
					resizeTimerID = window.setTimeout(function() {
						resizeTimerID = null;
						tl.layout();
					}, 500);
				}
			}
		</script>
		<style type="text/css">
		html {
		    font-family: Trebuchet MS, Helvetica, Arial, sans serif;
		        font-size: 8pt;
			    border: 1px solid #aaa;
			    }
		</style>
	</head>

	<body onload="onLoad()" onresize="onResize()">
		<div id="tl" class="timeline-default timeline-container" style="height: 200px; border: 1px solid #aaa"></div>
		<!--div id="controls" class="controls"></div-->
	</body>
</html>
