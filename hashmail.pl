#!/home/baerg/perl5/perlbrew/perls/perl-5.14.2/bin/perl

## replace with directory where this script lives
my $appdir = '.';

use lib "$appdir/lib";

my $mail;
while (<>) {
  $mail .= $_;
}

use Email::Store "dbi:SQLite:$appdir/hashmail.sqlite";

Email::Store::Mail->store($mail);
