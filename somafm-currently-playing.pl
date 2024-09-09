#!/usr/bin/env perl

use warnings;
use strict;
use Mojo::UserAgent;
use feature qw(say);
use 5.016; # for Mojolicious
use utf8;

binmode(STDOUT, ":encoding(UTF-8)");

my $requested_station = $ARGV[0];

my $stations = _fetch_stations();

if (not $requested_station) {
    print STDERR "Usage: $0 <station short name>\n";
    print STDERR "Station can be one of:\n";
    foreach my $station (keys %{$stations}) {
        print STDERR "\t$stations->{$station}, short name: $station\n";
    }
    exit 1;
}

if (not exists $stations->{$requested_station}) {
    print STDERR "Requested station >$requested_station< is not known\n";
    print STDERR "Station should be one of:\n";
    foreach my $station (keys %{$stations}) {
        print STDERR "\t$stations->{$station}, short name: $station\n";
    }
    print STDERR "\nUsage: $0 <station short name>\n";
    exit 2;
}

say _fetch_currently_playing_track($requested_station);

exit 0;

sub _fetch_currently_playing_track {
    my $requested_station = shift;

    my $url = sprintf "https://somafm.com/%s/songhistory.html", $requested_station;
    my $songhistory_response = _fetch_url($url);

    return _parse_songhistory_response($songhistory_response);
}

sub _fetch_stations {

    my $playlist_response = _fetch_url('https://somafm.com/playlist/');
    my $stations = _parse_playlist_response($playlist_response);

    return $stations;
}


sub _parse_playlist_response {
    my $response = shift;

    my $trs = $response->dom->find('table.menutable > tr');

    my %stations;
    for my $tr ($trs->each) { 

        my $long_name = $tr->at('td > p > span')->text;
        my $short_name = $tr->at('td > p > a[href]:last-child')->attr('href');

        $long_name =~ s{:}{};
        $short_name =~ s{^/(.*)/songhistory.html$}{$1};

        $stations{$short_name} = $long_name;
    }

    return \%stations;
}

sub _parse_songhistory_response {
    my $response = shift;

    my $dom = $response->dom->at('div#playinc > table > tr:nth-child(3)'); 

    my $artist = $dom->at('td:nth-child(2) > a')->text || 'N/A';
    my $song = $dom->at('td:nth-child(3)')->text || 'N/A';
    my $album = $dom->at('td:nth-child(4)');
    
    # NOTE: If album is present, we have a link else just the string '(single)'
    if ($album->at('a')) {
        $album = $album->at('td:nth-child(4) > a')->text;
    } else {
        $album = $dom->at('td:nth-child(4)')->text;
    }

    return sprintf '"%s" playing "%s" from album: "%s"', $artist, $song, $album;
}

sub _fetch_url {
    my $url = shift;

    my $ua = Mojo::UserAgent->new;
    my $response = $ua->get($url)->result;

    if (not $response->is_success) {
        croak $response->message;
    }

    return $response;
}
