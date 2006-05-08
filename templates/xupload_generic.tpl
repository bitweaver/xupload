{include file="bitpackage:xupload/upload_form_inc.tpl"}

{form onsubmit="return StartUpload();" target="upload" action="/cgi-bin/xupload/upload.cgi?upload_id=" enctype="multipart/form-data" id=xuploadform legend=$xuploadLegend|default:"Upload Files"}
	{include file="bitpackage:xupload/upload_body_inc.tpl"}

	<div class="row submit">
		<input type="submit" value="Upload Files">
	</div>
{/form}
