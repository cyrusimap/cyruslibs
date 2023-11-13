#!/usr/bin/perl -w

my $tag = shift;

# make sure we're up to date
system('git', 'submodule', 'init');
system('git', 'submodule', 'update');

unless ($tag) {
  # do we already have a tagged version here?
  open(FH, "git tag --points-at HEAD |");
  while(<FH>) {
    next unless m{cyruslibs-fastmail-v(\d+)};
    print "ALREADY a tagged version $1\n";
    exit 0;
  }
  close(FH);

  # calculate the next version
  my $v = 0;
  open(FH, "git tag -l |");
  while(<FH>) {
    next unless m{cyruslibs-fastmail-v(\d+)};
    $v = $1 if $v < $1;
  }
  $v++;
  close(FH);
  $tag = "cyruslibs-fastmail-v$v";
}

print "TAGGING $tag\n";

my %modules;
open(FH, "git config -f .gitmodules -l |");
while (<FH>) {
  next unless m{submodule\.([^\.=]+)\.([^\.=]+)=(.*)};
  $modules{$1}{$2} = $3;
}

for my $module (sort keys %modules) {
  next unless $modules{$module}{url} =~ m{github.com/cyrusimap/(.*)};
  my $name = $1;
  $name =~ s/\.git$//;
  print "$module $modules{$module}{url}\n";
  chdir $modules{$module}{path};
  system('git', 'remote', 'add', 'github', "git\@github.com:cyrusimap/$name.git");
  system('git', 'tag', '-f', $tag);
  system('git', 'push', 'github', $tag);
  chdir '..';
}

system('git', 'remote', 'add', 'github', "git\@github.com:cyrusimap/cyruslibs.git");
system('git', 'tag', '-f', $tag);
system('git', 'push', 'github', $tag);

