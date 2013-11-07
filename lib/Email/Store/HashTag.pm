package Email::Store::HashTag;
use strict;
use base "Email::Store::DBI";
Email::Store::HashTag->table("hashtag");
Email::Store::HashTag->columns(Primary => qw/id/);
Email::Store::HashTag->columns(All => qw/id hashtag/);

sub on_store_order { 99 }
sub on_store {
  my ($self, $mail) = @_;
}

package Email::Store::HashTag::Mail;
use base "Email::Store::DBI";
Email::Store::HashTag::Mail->table("mail_hashtag");
Email::Store::HashTag::Mail->columns( All => qw/ id mail hashtag /);
Email::Store::HashTag::Mail->has_a("hashtag" => "Email::Store::HashTag");
Email::Store::HashTag::Mail->has_a("mail" => "Email::Store::Mail");


package Email::Store::HashTag::Entity;
use base "Email::Store::DBI";
Email::Store::HashTag::Entity->table("mail_entity_hashtag");
Email::Store::HashTag::Entity->columns( All => qw/ id entity hashtag /);
Email::Store::HashTag::Entity->has_a("hashtag" => "Email::Store::HashTag");
Email::Store::Hashtag::Entity->has_a("entity" => "Email::Store::Entity");

Email::Store::Mail->has_many("hashtags" => "Email::Store::HashTag::Mail");
Email::Store::Entity->has_many("hashtags" => "Email::Store::HashTag::Entity");

package Email::Store::HashTag;
1;

=head1 NAME

Email::Store::HashTag - hashtags in emails

=head1 SYNOPSIS

  my $hashtag = Email::Store::HashTag->search( hashtag => "#foo" );
  @hashtagged_emails = $hashtag->mails;

=head1 DESCRIPTION

Searches email for hashtags

=cut

__DATA__
CREATE TABLE IF NOT EXISTS hashtag (
  id integer auto_increment NOT NULL PRIMARY KEY,
  hashtag text
);

CREATE TABLE IF NOT EXISTS mail_hashtag (
  id integer auto_increment NOT NULL PRIMARY KEY,
  mail varchar(255)
);

CREATE TABLE IF NOT EXISTS mail_entity_hashtag (
  id integer auto_increment NOT NULL PRIMARY KEY,
  entity integer
);

