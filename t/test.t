#!perl

use strict;
use warnings;
use App::EUMM::Upgrade;
use Test::More tests => 3;

{
my $text=<<'EOT';
WriteMakefile(
	VERSION   => $VERSION,
	($] >= 5.005 ? (
		AUTHOR  => '***',
	) : ()),
);
EOT

my $text1=<<'EOT';
WriteMakefile(
	VERSION   => $VERSION,
	AUTHOR  => '***',
);
EOT
is(App::EUMM::Upgrade::remove_conditional_code($text,"\t"),$text1);

}

{
my $text=<<'EOT';
	($ExtUtils::MakeMaker::VERSION ge '6.31' ? (
		LICENSE => 'perl',
	) : ()),
EOT

my $text1=<<'EOT';
	LICENSE => 'perl',
EOT
is(App::EUMM::Upgrade::remove_conditional_code($text,"\t"),$text1);

}

{
my $text=<<'EOT';
	($ExtUtils::MakeMaker::VERSION ge '6.48' ? (
		MIN_PERL_VERSION => 5.004,
		META_MERGE => {
			resources => {
				repository => '',
			},
		},
	) : ()),
EOT

my $text1=<<'EOT';
	MIN_PERL_VERSION => 5.004,
	META_MERGE => {
		resources => {
			repository => '',
		},
	},
EOT
is(App::EUMM::Upgrade::remove_conditional_code($text,"\t"),$text1);

}
