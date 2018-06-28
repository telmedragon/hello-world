#!/usr/bin/perl
#################################################################
# Author: Kevin Pham
# Name: plexDB
#
# Purpose: To iterate through the plex media directory and catalog the Movies, 
# TV Shows, and Anime folders. 
# It should
#
# 1) Move orphaned shows/movies into a correct <Title><Year> folder
# 2) Notify me of older file types (.avis). 
# 3) Generate the disk usage info so I can be updated automatically when I add stuff rather than 
#     having to manually ssh in and type the commands 
# 
# Because file names are not always clean, I need a "blacklist" regex to run
# the movie title through so that it generates something I can give to IMDB IF I
# decide to feed IMDB a string from raw video file
#
#################################################################

use Env;
use strict;
use warnings;
# Let's me figure out where I am
use Cwd;
#
# Let's me find files
use File::Find;
use File::Basename;

# Allows me to traverse webpages
use WWW::Mechanize;

use HTML::Form;
use 5.18.0;

my @where_am_i;
my $file_formats;
my $file_name;
my $stardir = "/media/plex0";
my $renamed;
my $imdb_url = "https://www.imdb.com/";
my $mech = WWW::Mechanize->new(autocheck => 1);


sub check_imdb() {
# Goes to home page of IMDB
  $mech->get($imdb_url);
  my $num_history = $mech->history_count();
  say $num_history;
  my $page = $mech->content();
# Grabs all the "forms" of the webpage, in IMDB's case, there is only one on that  page which makes it easier to manage
  my @forms = $mech->forms();
  say "@forms";

  my $success =$mech->submit_form(
      form_number=>1,
      #q is the name of element that accepts text input, identified by the html div id "nb_search".
      fields => { 'q' => 'Dunkirk'}
    );
  die "Couldn't submit form" unless $success->is_success;
  $num_history = $mech->history_count();
  say $num_history;
  my $cur_link = $mech->uri();
  say $cur_link;

#my @link = $mech->find_all_links(text_regex => qr[Dunkirk\s])
# Returns Link object, use url for relative path, base for base path, and url_abs for full path. Should I just take the first hit and go with it?
  my @link = $mech->find_all_links(url_regex => qr'.*\/title\/tt[0-9]*')
    or die "No matches were found";
  say @link;
  foreach my $links (@link) {
    say $links->url_abs();
    say $links->header();
    #if ($links->url_abs() =~ /\/title\//) say $_;
    #else say "Not a movie title";
  }
  $num_history = $mech->history_count();
  say $num_history;
  $mech->get($link[0]);
  $num_history = $mech->history_count();
  say $num_history;
  $cur_link = $mech->uri();
  say $cur_link;
  $num_history = $mech->history_count();
  say $num_history;
#print $page;
#open(FH, ">imdb.txt");
#print FH $page;
#close(FH);
}

sub search_n_log() {
  # If this is an orphaned file. Orphaned is when the video file itself exists in the Movie/Anime/TV Shows.
  # Orphaned is identified when it has a video file extension and exists in Movie/Anime/TV Shows without it's own
  # wrapper folder
  my $stripped_name;
  if ( -d $_) {
    say "The directory is named: $_";
  }
  if ( /.(avi|mkv|mp4|mpg|mpeg|wmv)/   and 
       -f ($_)                          and
       ((split '/', cwd())[-1] eq 'Movies')
     ) {
      $stripped_name = $_;
      say "The extension is named: $1";
      say "The file is named: $_";
      $stripped_name =~ s/.(avi|mkv|mp4|mpg|mpeg|wmv)//; 
      say "The stripped name: $stripped_name";
      `mkdir "$stripped_name"`;
  }
  if ( -d "Dunkirk (2017)") {
    say "hello";
  }

  
}

# This function cleans the title of the file
# so that I can give a clean string to IMDB
find(\&search_n_log, $stardir)
