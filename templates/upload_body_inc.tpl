<div class="row">
	{formlabel label="Upload Files"}
	{forminput}
		<div id="slots"></div>
		<input name="xupload[]" type="file" onchange="checkExt(this.value)" /><br />
		<input name="xupload[]" type="file" /><br />
		<input name="xupload[]" type="file" /><br />
		<input type="button" value="{tr}Add upload slot{/tr}" onclick="addUploadSlot();" /><br /><br />
		<br />
		{if $gBitSystem->isFeatureActive( 'xupload_use_popup' )}
			<input type="hidden" name="popup" id="popup" />
		{else}
			<input type="hidden" name="inline" id="inline" />
		{/if}
		<input type="hidden" id="url_post" name="url_post" value="{$smarty.server.PHP_SELF}" />
		<input type="hidden" id="css_name" name="css_name" value="bitweaver.css" />
		<input type="hidden" id="tmpl_name" name="tmpl_name" value="bitweaver.html" />
		<iframe src="about:blank" name="upload" frameborder="0" style="width:0; height:0; border:0;"></iframe>
		<div id="div_inline" style="position: absolute; left: 0px; top: 0px; width: 100%; height: 100%; background: url({$smarty.const.XUPLOAD_PKG_URL}icons/trans_bg.gif); text-align: center; padding-top: 50px; display: none;">
			<iframe src="about:blank" name="transfer" border="0" xSCROLLING="NO" topmargin="0" leftmargin="0" frameborder="0" style="width:340px; height:280px; border:1px solid #aaa;"></iframe>
		</div>
	{/forminput}
</div>
