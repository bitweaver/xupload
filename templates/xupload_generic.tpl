{include file="bitpackage:xupload/upload_form_inc.tpl"}

<form name="F1" enctype="multipart/form-data" method="post" action="/xupload/cgi/upload.cgi?upload_id=" legend="Upload Files" onSubmit="return StartUpload();" target="upload">

	{include file="bitpackage:xupload/upload_body_inc.tpl"}

	<input type="submit" value="Upload Files">
</form>

