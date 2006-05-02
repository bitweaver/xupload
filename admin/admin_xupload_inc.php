<?php
// $Header: /cvsroot/bitweaver/_bit_xupload/admin/admin_xupload_inc.php,v 1.3 2006/05/02 11:24:51 squareing Exp $
// Copyright (c) 2006 - bitweaver.org
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

require_once( WIKI_PKG_PATH.'BitPage.php' );

$formXuploadFeatures = array(
	"xupload_allowable_ext" => array(
		'label' => 'Only Allow File Extensions',
		'note' => 'A pipe delimited string, such as "jpg|gif|png|bmp|mp3|mpg|mpeg|avi|rar|zip|7z|gz|txt" or to allow everything, leave blank.',
		'type' => 'text',
	),
	"xupload_use_popup" => array(
		'label' => 'Use a Popup',
		'note' => 'Use a popup progress meter. This popup is likely to be disabled by popup blockers. When you don\'t use a popup, the progress will be displayed in the same screen.',
		'type' => 'checkbox',
	),
);
$gBitSmarty->assign( 'formXuploadFeatures', $formXuploadFeatures );

if( isset( $_REQUEST["xupload_features"] ) ) {
	foreach( $formXuploadFeatures as $item => $data ) {
		if( $data['type'] == 'checkbox' ) {
			simple_set_toggle( $item, XUPLOAD_PKG_NAME );
		} else {
			$gBitSystem->storeConfig( $item, ( !empty( $_REQUEST[$item] ) ? $_REQUEST[$item] : NULL ), XUPLOAD_PKG_NAME );
		}
	}
}

?>
