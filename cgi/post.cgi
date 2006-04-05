#!/usr/bin/perl
use CGI;

my $cgi = CGI->new();
my @param = $cgi->param();

print"Content-type: text/html\n\n";
for(@param)
{
 my @arr = $cgi->param($_);
 print"$_:".join(':',@arr)."<br>";
}