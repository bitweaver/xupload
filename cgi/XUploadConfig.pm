package XUploadConfig;

BEGIN
{
  use Exporter;
  @XUploadConfig::ISA = qw( Exporter );
  @XUploadConfig::EXPORT = qw( $c );
}

our $c=
{
 # Directory for temporary using files
 temp_dir        => '/tmp/xupload/temp',

 # Directory for uploaded files
 target_dir      => '/tmp/xupload/uploads',

 # Path to the template using for upload status window
 templates_dir   => '/home/viovio/bwHEAD/xupload/cgi/Templates',

 # Allowed file extensions delimited with '|'
 ext_allowed     => 'jpg|jpeg|gif|png|rar|zip|mp3|avi|txt|csv|rpm',

 # URL to send all input values from upload page
 # This setting can be submitted from HTML form, then it will have priority
 url_post        => 'http://test.boo.viovio.com/xupload/cgi/post.cgi',

 # The link to redirect after complete upload
 # This setting can be submitted from HTML form, then it will have priority
 redirect_link   => 'http://test.boo.viovio.com/xupload/upload_form.html',

 # Max length of uploaded filenames(without ext). Longer filenames will be cuted.
 max_name_length => 64,

 # Type of behavior when uploaded file already exist on disc. Available 3 modes: Rewrite/Rename/Warn
 copy_mode       => 'Rename',

 # Maximum total upload size in Kbytes
 max_upload_size => 700000000,      

 # Time to keep temp upload files on server, sec (24 hours = 86400 seconds)
 temp_files_lifetime => 864000,

 # CSS names
 styles			 => { 'black'   => 'black.css',
			      'hitech'  => 'hi_tech.css',
			      'aqua'    => 'aqua.css',
			      'tiny'    => 'tiny.css',
                              'contrast'=> 'contrast.css',
			    },

 # Template names
 templates => { 'simple' => 'simple.html',
                'hitech' => 'hitech.html',
	        'nice'   => 'nice.html',
	      },
};

1;
