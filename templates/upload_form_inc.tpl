{literal}
<Script language="JavaScript">

var exts = "jpg|gif|png|bmp|mp3|mpg|mpeg|avi|rar|zip|7z|gz|txt|rpm";
//var exts = ".*"; //Use this to accept all Extensions

//- Fix for Netscape 6/Mozilla ------------
if(typeof HTMLElement!="undefined" && !HTMLElement.prototype.insertAdjacentElement)
{
	HTMLElement.prototype.insertAdjacentElement = function
	(where,parsedNode)
	{
	switch (where){
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
	
	HTMLElement.prototype.insertAdjacentHTML = function	(where,htmlStr)
	{
		var r = this.ownerDocument.createRange();
		r.setStartBefore(this);
		var parsedHTML = r.createContextualFragment(htmlStr);
		this.insertAdjacentElement(where,parsedHTML)
	}
}
//---------------------


var UID,NF=0,cx=0;
function openStatusWindow()
{ 
 if(document.F1.popup.checked == true)
 {
   win1 = window.open('/xupload/cgi/upload_status.cgi?upload_id='+UID+'&num_files='+NF+'&css_name='+document.F1.css_name.value+'&tmpl_name='+document.F1.tmpl_name.value,'win1','width=320,height=240,resizable=1');
   win1.window.focus();
 }
 if(document.F1.inline.checked == true)
 {
   document.getElementById('div_inline').style.display='block';
   self.transfer.document.location='/xupload/cgi/upload_status.cgi?inline=1&upload_id='+UID+'&num_files='+NF+'&css_name='+document.F1.css_name.value+'&tmpl_name='+document.F1.tmpl_name.value;
 }
}

function generateSID()
{
 UID = Math.round(10000*Math.random())+'0'+Math.round(10000*Math.random());
 var f1=document.F1;
 f1.action = f1.action.split('?')[0]+'?upload_id='+UID;
 //for (var i=0;i<document.F1.length;i++)
 //{
 //    current = document.F1.elements[i];
 //    if(current.type=='file' && current.value!='')NF++;
 //}
}

function StartUpload()
{
    NF=0;
    for (var i=0;i<document.F1.length;i++)
    {
     current = document.F1.elements[i];
     if(current.type=='file' && current.value!='')
      {
         if(!checkExt(current.value))return false;
         NF++;
      }
    }
    generateSID();
    openStatusWindow();
}

function checkExt(value)
{
    if(value=="")return true;
    var re = new RegExp("^.+\.("+exts+")$","i");
    if(!re.test(value))
    {
        alert("Extension not allowed for file: \"" + value + "\"\nOnly these extensions are allowed: "+exts.replace(/\|/g,',')+" \n\n");
        return false;
    }
    return true;
}

function addUploadSlot()
{
  cx++;
  document.getElementById('slots').insertAdjacentHTML("afterEnd", 'Send file: <input name="userfile'+cx+'" type="file"><br>');
}
</Script>
{/literal}
