<?php
// $Header: /cvsroot/bitweaver/_bit_xupload/admin/admin_xupload_inc.php,v 1.2 2006/04/07 04:03:17 spiderr Exp $
// Copyright (c) 2006 - bitweaver.org
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

require_once( WIKI_PKG_PATH.'BitPage.php' );

$formXuploadFeatures = array(
	"xupload_allowable_ext" => array(
		'label' => 'Only Allow File Extensions',
		'note' => 'A pipe delimited string, such as "jpg|gif|png|bmp|mp3|mpg|mpeg|avi|rar|zip|7z|gz|txt" or to allow everything, leave blank',
	),
);
$gBitSmarty->assign( 'formXuploadFeatures',$formXuploadFeatures );

if (isset($_REQUEST["xupload_features"])) {
	foreach( $formXuploadFeatures as $item => $data ) {
		$gBitSystem->storeConfig( $item, (!empty( $_REQUEST[$item] ) ? $_REQUEST[$item] : NULL) );
	}
}

?>
