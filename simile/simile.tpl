{if isset($smarty.request.height)}
	{assign var="height" value=`$smarty.request.height`}
{else}
	{assign var="height" value="200"}
{/if}


{literal}
<html>
	<head>
		<script src="http://simile.mit.edu/timeline/api/timeline-api.js" type="text/javascript"></script>
		<script src="http://simile.mit.edu/timeline/examples/examples.js" type="text/javascript"></script>

		<title>testfoo</title>
		<script language="javascript">
			var tl;
			function onLoad() {
				var eventSource = new Timeline.DefaultEventSource();

				var theme = Timeline.ClassicTheme.create();
				theme.event.label.width = 500; 
				theme.event.bubble.width = 100;
				theme.event.bubble.height = 100;
				var today = new Date();

				var bandInfos = [
					Timeline.createBandInfo({
						eventSource:	eventSource,
						width:		"67%", 
						intervalUnit:	Timeline.DateTime.DAY, 
						intervalPixels:	100,
						theme:		theme,
						trackHeight:    2,
					}),
					Timeline.createBandInfo({
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

				var kalender_url = "http://kalender.scoutnet.de/2.0/show.php?id={/literal}{$kalender.id}{literal}&content_type=xml&nogz&template=export/simile_timeline_xml.tpl&charset=utf8";
				Timeline.loadXML(kalender_url, function(xml, url) { eventSource.loadXML(xml, url); });
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
		{/literal}
		<style type="text/css">
		html {
		    font-family: Trebuchet MS, Helvetica, Arial, sans serif;
		        font-size: 8pt;
			    border: 1px solid #aaa;
			    }
		</style>
	</head>

	<body onload="onLoad()" onresize="onResize()">
		<div id="tl" class="timeline-default timeline-container" style="height: {$height}px; {if isset($smarty.request.noborder)} {else}border: 1px solid #aaa{/if}"></div>
	</body>
</html>

