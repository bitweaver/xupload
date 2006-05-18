<script type="text/javascript">
var exts = "{$gBitSystem->getConfig('xupload_allowable_ext','.*')}";
/* <![CDATA[ */
{literal}
// start fix for moz and netscape 6
if(typeof HTMLElement!="undefined" && !HTMLElement.prototype.insertAdjacentElement) {
	HTMLElement.prototype.insertAdjacentElement = function(where,parsedNode) {
		switch (where) {
			case 'beforeBegin':
				this.parentNode.insertBefore(parsedNode,this)
					break;
			case 'afterBegin':
				this.insertBefore(parsedNode,this.firstChild);
				break;
			case 'beforeEnd':
				this.appendChild(parsedNode);
				break;
			case 'afterEnd':
				if (this.nextSibling) 
					this.parentNode.insertBefore(parsedNode,this.nextSibling);
				else this.parentNode.appendChild(parsedNode);
				break;
		}
	}

	HTMLElement.prototype.insertAdjacentHTML = function	(where,htmlStr) {
		var r = this.ownerDocument.createRange();
		r.setStartBefore(this);
		var parsedHTML = r.createContextualFragment(htmlStr);
		this.insertAdjacentElement(where,parsedHTML)
	}
}
// end fix

var UID,NF=0;
function openStatusWindow() { 
	if($('popup')) {
		win1 = window.open('{/literal}{$smarty.const.XUPLOAD_PKG_URL}{literal}cgi/upload_status.cgi?upload_id='+UID+'&num_files=','win1','width=340,height=280,resizable=1');
		win1.window.focus();
	}
	if($('inline')) {
		$('div_inline').style.display='block';
		self.transfer.document.location=('{/literal}{$smarty.const.XUPLOAD_PKG_URL}{literal}cgi/upload_status.cgi?upload_id='+UID+'&num_files=');
	}
}

function generateSID() {
	UID = Math.round(10000*Math.random())+'0'+Math.round(10000*Math.random());
	var xform=$('xuploadform');
	xform.action = xform.action.split('?')[0]+'?upload_id='+UID;
}

function StartUpload() {
	NF=0;
	for (var i=0;i<$('xuploadform').length;i++) {
		current = $('xuploadform').elements[i];
		if(current.type=='file' && current.value!='') {
			if(!checkExt(current.value))return false;
			NF++;
		}
	}
	generateSID();
	openStatusWindow();
}

function checkExt(value) {
	if(value=="")return true;
	var re = new RegExp("^.+\.("+exts+")$","i");
	if(!re.test(value)) {
		alert("Extension not allowed for file: \"" + value + "\"\nOnly these extensions are allowed: "+exts.replace(/\|/g,',')+" \n\n");
		return false;
	}
	return true;
}

function addUploadSlot() {
	$('slots').insertAdjacentHTML("afterEnd", '<input name="xupload[]" type="file"><br>');
}
{/literal}
/* ]]> */
</script>
