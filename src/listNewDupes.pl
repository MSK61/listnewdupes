#!/usr/bin/perl -w
############################################################
#
# Copyright 2011 Mohammed El-Afifi
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.

# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# program:      new RPM package duplicate enumerator
#
# file:         listNewDupes.pl
#
# function:     complete program listing in this file
#
# description:  summarizes the latest version of duplicate installed RPM
#               packages
#
# author:       Mohammed Safwat (MS)
#
# environment:  Komodo IDE, version 6.1.3, build 66534, perl 5.14.2, Fedora
#               release 16 (Verne)
#               Komodo IDE, version 7.1.2, build 73175, perl 5.14.3, Fedora
#               release 17 (Beefy Miracle)
#
# notes:        This is a private program.
#
############################################################
use strict;

my @dupeList;
my $newDupeFile = "newDupes.txt";
my $newPkgFile = "allNew.txt";
my @totalUpdates = ();
my @updatedDupes = ();

# Read the file containing the duplicate packages.
open dupeRep, $ARGV[0] or die "Couldn't open $ARGV[0]: $!\n";
@dupeList = map {

    chomp;
    $_;

} <dupeRep>;
close dupeRep;

# Read the file containing the recently updated packages.
open updateRep, $ARGV[1] or die "Couldn't open $ARGV[1]: $!\n";

while (<updateRep>)
   {

    /Updated: (?:\d+:)?(.+)/;
    push @totalUpdates, $1;
    push @updatedDupes, grep($1 eq $_, @dupeList);

   }

close updateRep;

# Dump all the newly updated packages.
open newPkgRep, "> $newPkgFile";
print newPkgRep "$_\n" for @totalUpdates;
close newPkgRep;

# Dump the newly updated duplicate packages.
open newDupeRep, "> $newDupeFile";
print newDupeRep "$_\n" for @updatedDupes;
close newDupeRep;
