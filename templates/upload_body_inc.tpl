<input type="text" name="url_post" value="{$smarty.server.PHP_SELF}">
<div id="slots"></div>
Send file: <input name="file1x" type="file" onChange="checkExt(this.value)"><br>
Send file: <input name="file2y" type="file"><br>
Send file: <input name="file3z" type="file"><br>
<input type="button" value="+1 upload slot" onClick="addUploadSlot();"><br><br>
<input type="checkbox" name="popup" id="popup" checked="checked"><label FOR="popup" ACCESSKEY="Z">Show upload status in pop-up window</label><br>
<input type="checkbox" name="inline" id="inline"><label FOR="inline" ACCESSKEY="X">Show upload status on this page</label><br>
<br>
<input type="hidden" name="css_name" value="{$gBitSystem->getStyleCss()}">{$gBitSystem->getStyleCss()}
<input type="hidden" name="tmpl_name" value="hitech.html">

<iframe src="about:blank" name="upload" frameborder=0 style="width: 0px; height: 0px;"></iframe>
<div id="div_inline" style="position: absolute; left: 0px; top: 0px; width: 100%; height: 100%; background: url(trans_bg.gif); text-align: center; padding-top: 50px; display: none;">
<iframe src="about:blank" name="transfer" border=0 xSCROLLING=NO topmargin=0 leftmargin=0 frameborder=0 style="width: 320px; height: 240px; border: 1px solid #a3a3a3;"></iframe>
</div>
