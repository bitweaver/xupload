{include file="bitpackage:xupload/upload_form_inc.tpl"}

{form onSubmit="return StartUpload();" target="upload" action="/xupload/cgi/upload.cgi?upload_id=" enctype="multipart/form-data" name="F1" legend=$xuploadLegend|default:"Upload Files"}
	{include file="bitpackage:xupload/upload_body_inc.tpl"}

	<div class="row submit">
		<input type="submit" value="Upload Files">
	</div>
{/form}
