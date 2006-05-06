#!/usr/bin/perl
### XUpload v2.5
### SibSoft.net (26 Jan 2006) by Art Bogdanov aKa PilgrimX182 <bogdanov@sibsoft.net>
use strict;
use CGI::Carp qw(fatalsToBrowser);
use CGI qw/:standard/;
use File::Basename;
use lib dirname(__FILE__);
use XUploadConfig;
#$CGI::close_upload_files = $CGI::CLOSE_UPLOAD_FILES = 1; #works for 1 file only (prob:reusing file handler)
$CGI::POST_MAX = 1024 * $c->{max_upload_size};   # set max Total upload size

my $sid = (split(/[&=]/,$ENV{QUERY_STRING}))[1]; # get the random id for temp files

$sid ||= join '', map int rand 10, 1..7;         # if client has no javascript, generate server-side
&xmessage("Invalid Upload ID") unless $sid=~/^\d+$/; # Checking for invalid IDs
my $temp_dir = "$c->{temp_dir}/$sid";
mkdir $temp_dir;
my $mode = 0777;
chmod $mode,$temp_dir;

# Tell CGI.pm to use our directory based on sid
$CGITempFile::TMPDIRECTORY = $TempFile::TMPDIRECTORY = $temp_dir;


# Remove all files if user presses stop
sub CleanUp
{
   &DelData($temp_dir);
   exit(0);
}
 
$SIG{HUP} = 'IGNORE';
local $SIG{__DIE__} = 'CleanUp';

if($ENV{'CONTENT_LENGTH'} > 1024*$c->{max_upload_size})
{
   &lmsg('ERROR: Maximum upload size exceeded<br>You should stop transfer right now');
   sleep 1;
   &DelData($temp_dir);
   &xmessage("Maximum upload size exceeded");
}
else
{
   open FILE,">$temp_dir/flength";
   print FILE $ENV{'CONTENT_LENGTH'}."\n";
   close FILE;
   my $mode = 0777; chmod $mode,"$temp_dir/flength";
}

my $cg = new CGI;
if( $cg->cgi_error() )
{
   &DelData($temp_dir);
   &xmessage("ERROR: Maximum upload size exceeded");
}

my (@fileslots,@filenames,@file_status);
my @params = $cg->param;

for my $k ( keys %{$cg->{'.tmpfiles'}} )
{
   $cg->{'.tmpfiles'}->{$k}->{info}->{'Content-Disposition'} =~ /name="(.+?)"; filename="(.+?)"/;
   my ($field_name,$filename) = ($1,$2);
      
   $filename =~ s/.*\\([^\\]*)$/$1/;

   push @fileslots, $field_name;
   push @filenames, $filename;
   $filename=~ /(.+)\.(.+)/;
   my ($fn,$ext) = ($1,$2);
   if($ext !~ /^$c->{ext_allowed}$/i)
   {
      &lmsg("MSG:File $filename have unallowed extension!");
      push @file_status, "unallowed extension";
      next;
   }
   $fn = substr($fn,0,$c->{max_name_length});
   my $i;
   $i++ while (-e "$c->{target_dir}/$fn$i.$ext" && $c->{copy_mode} eq 'Rename');

   $filename="$fn$i.$ext";
   push @file_status, "OK. renamed to:$fn$i.$ext" if $i;
   &lmsg("MSG:File '$fn.$ext' already exist!<br>New file saved as '$filename'.") if $i;

   if(-e "$c->{target_dir}/$filename" && $c->{copy_mode} eq 'Warn')
   {
      &lmsg("MSG:File $filename already exist! New file wasn't saved.");
      push @file_status, "error:filename already exist";
      next;
   }
   
   &SaveFile2( ${$cg->{'.tmpfiles'}->{$k}->{name}}, $c->{target_dir}, $filename );
   push @file_status, "OK" unless $i;
}

### Small pause to sync messages with pop-up
select(undef, undef, undef,0.1);
&DelData($temp_dir);
&DeleteOldTempFiles;

print"Content-type: text/html\n\n";

### Sending data with POST request if required
my $url_post = $cg->param('url_post');
$url_post ||= $c->{url_post};
if($url_post)
{
   my ($str,@har);
   for (0..$#fileslots)
   {
      push @har, { name=>$fileslots[$_],          'value'=>$filenames[$_] };
      push @har, { name=>"$fileslots[$_]_status", 'value'=>$file_status[$_] };
   }
   for my $k (@params)
   {
      my @arr = $cg->param($k);
      for my $p (@arr)
      {
         next if ref $p eq 'Fh'; #&& $p !~ /\.$c->{ext_allowed}$/i; # Skip unallowed files
         $p =~ s/.*\\([^\\]*)$/$1/;
         push @har, { name=>$k, value=>$p };
      }
   }

   push @har, { name=>'target_dir', value=>$c->{target_dir} };

   print"<HTML><BODY onLoad='document.F1.submit();'><Form name='F1' action='$url_post' target='_parent' method='POST'>";
   print"<textarea name='$_->{name}'>$_->{value}</textarea>" for @har;
   print"</Form></BODY></HTML>";
   exit;
}

### Upload finished, redirecting 
my $redirect_link = $cg->param('redirect_link');
$redirect_link ||= $c->{redirect_link};
print"<HTML><Script>parent.document.location='$redirect_link';</Script></HTML>";

#############################################

sub DeleteOldTempFiles
{
   my @ff;
   opendir(DIR, $c->{temp_dir}) || &xmessage("Can't opendir temporary folder: $!");
   @ff = readdir(DIR);
   closedir(DIR);
   foreach my $fn (@ff)
   {
      next if $fn =~ /^\.{1,2}$/;
      my $file = $c->{temp_dir}.'/'.$fn;
      my $ftime = (lstat($file))[9];
      my $diff = time() - $ftime;
      next if $diff < $c->{temp_files_lifetime};
      -d $file ? &DelData($file) : unlink($file);
   }
}

# sub SaveFile
# {
#    my ($fh,$dir,$fname) = @_;
#    open(FILE,">$dir/$fname") || &xmessage("Can't open target file");
#    my $buf;
#    print FILE $buf  while read($fh,$buf,$c->{block_size});
#    close FILE;
# }

sub SaveFile2
{
   my ($temp,$dir,$fname) = @_;
   rename($temp,"$dir/$fname");
}

sub DelData
{
   my ($dir) = @_;
   opendir(DIR, $dir) || die"ERROR $!: $dir";
   my @ff = readdir(DIR);
   closedir(DIR);
   for my $fn(@ff)
   {
      unlink("$dir/$fn");
   }
   rmdir("$dir");
}

sub xmessage
{
   my ($msg) = @_;
   print"Content-type: text/html\n\n";
   print"<HTML><BODY><b>$msg</b><br><input type='button' value='&lt; Back' onclick='javascript:history.go(-1);'></BODY></HTML>";
   exit;
}

sub lmsg
{
   my ($msg) = @_;
   open(FILE,">>$temp_dir/flength");
   print FILE $msg."\n";
   close FILE;
}
