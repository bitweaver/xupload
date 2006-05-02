<?php
global $gBitSystem, $gBitSmarty;

$registerHash = array(
	'package_name' => 'xupload',
	'package_path' => dirname( __FILE__ ).'/',
//	'service' => LIBERTY_SERVICE_UPLOAD,
);
$gBitSystem->registerPackage( $registerHash );

if( $gBitSystem->isPackageActive( 'xupload' ) ) {
	if( !empty( $_REQUEST['xupload'] ) && is_array( $_REQUEST['xupload'] ) ) {
		$uploads = count( $_REQUEST['xupload'] );
		// for some reason xupload gets upset if we play with $_REQUEST
		$xupload = $_REQUEST['xupload'];
		for( $i = 0; $i < $uploads; $i += 2 ) {
			if( !empty( $xupload[$i + 1] ) && preg_match( "/^OK/", $xupload[$i + 1] ) ) {
				if( preg_match( "/OK\. renamed to:(.*)/", $xupload[$i + 1], $matches ) ) {
					$xupload[$i] = $matches[1];
				}
				$fullname = $_REQUEST['target_dir'].'/'.$xupload[$i];
				$ext = substr( $xupload[$i], ( strrpos( $xupload[$i], '.' ) + 1 )  );
				$_FILES[] = array(
					'type'     => $gBitSystem->lookupMimeType( $ext ),
					'size'     => filesize( $fullname ),
					'tmp_name' => $fullname,
					'name'     => $xupload[$i],
					'error'    => 0,
				);
			}
		}
	}

	/*
	$gLibertySystem->registerService( LIBERTY_SERVICE_ACCESS_CONTROL, PROTECTOR_PKG_NAME, array(
		'content_display_function' => 'protector_content_display',
		'content_preview_function' => 'protector_content_edit',
		'content_edit_function' => 'protector_content_edit',
		'content_store_function' => 'protector_content_store',
		'content_list_sql_function' => 'protector_content_list',
		'content_load_sql_function' => 'protector_content_load',
		'content_edit_mini_tpl' => 'bitpackage:protector/choose_protection.tpl',
		'content_icon_tpl' => 'bitpackage:protector/protector_service_icon.tpl',
	) );
	*/
}
?>
