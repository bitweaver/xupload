<Script language="JavaScript">
var totalsize=<TMPL_VAR data_total>;
function setCookie( sName, sValue )
{
    if(sName.length<1)return;

    if (0<sValue.length)
    {
        var expDate = new Date();
        expDate.setTime( expDate.getTime() + 365*24*60*60*1000 );

        document.cookie = "" + sName + "=" + sValue + "; " + "expires=" + expDate.toGMTString();
    }
    else
    {
        //  this will cause the named cookie to be deleted.
        document.cookie = sName + "=";
    }
}

function fetchDocumentCookie( sName )
{
    var sValue = "";
    var index = 0;

    if( document.cookie )
        index = document.cookie.indexOf( sName + "=" );
    else
        index = -1;

    if ( index < 0 )
    {
        sValue = "";
    }
    else
    {
        var countbegin = (document.cookie.indexOf( "=", index ) + 1);
        if ( 0 < countbegin )
        {
            var countend = document.cookie.indexOf( ";", countbegin );
            if ( countend < 0 )
                countend = document.cookie.length;
            sValue = document.cookie.substring( countbegin, countend );
        }
        else
        {
            sValue = "";
        }
    }
    return sValue;
}

function changeValue(id,value)
{
  if(id && document.getElementById(id))
  {
      document.getElementById(id).innerHTML = value;
  }
}

function SP(cursize,time,speed,files,left)
{
    var percent = parseInt(100*parseFloat(cursize)/parseFloat(totalsize));
    document.getElementById('upload_status').style.width = percent+'%';
    changeValue('percent', percent+'%' );
	changeValue('current',cursize);
	changeValue('speed',speed);
	changeValue('files',files);
	changeValue('time', convertSeconds(time) );
	changeValue('left', convertSeconds(left) );
}

function convertSeconds(seconds)
{
	hours = parseInt(seconds/36000);
	mins  = parseInt(seconds/60);
	secs  = seconds - hours*3600 - mins*60;
	if(hours<10){ hours = '0'+hours; }
	if(mins<10){ mins  = '0'+mins; }
	if(secs<10){ secs  = '0'+secs; }
	return hours+':'+mins+':'+secs;
}

function Message(msg)
{
	document.getElementById('message').innerHTML += msg+'<br>';
	window.scrollBy(0,550);
}

function SetUpSettings()
{
    if(!document.getElementById('close_finished'))return;
    cf = fetchDocumentCookie( 'close_finished' );
	if(cf=='false')cf=0;
	document.getElementById('close_finished').checked = cf;
}

function ClosePopUp()
{
    if(document.getElementById('close_finished') && document.getElementById('close_finished').checked==true)self.close();
}
</Script>