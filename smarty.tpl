<style>
h1{ldelim}
	font-size: 1em;
{rdelim}
pre{ldelim}
	padding-left: 50px;
{rdelim}

</style>
<h1>$smarty.get</h1>
<pre>
{$smarty.get|@print_r:1}
</pre>

<h1>$smarty.post</h1>
<pre>
{$smarty.post|@print_r:1}
</pre>

<h1>$smarty.cookie</h1>
<pre>
{$smarty.cookies|@print_r:1}
</pre>

<h1>$smarty.server</h1>
<pre>
{$smarty.server|@print_r:1}
</pre>

<h1>$smarty.env</h1>
<pre>
{$smarty.env|@print_r:1}</pre>

<h1>$smarty.session</h1>
<pre>
{$smarty.session|@print_r:1}
</pre>

<h1>$smarty.request</h1>
<pre>
{$smarty.request|@print_r:1}
</pre>
