# somafm-currently-playing

A basic webscraper to fetch the currently playing track from a specified [SomaFM] station

## Usage

Fetch the currently playing track from the specified [SomaFM] station.

```bash
carton exec ./somafm-currently-playing.pl dronezone
"Innesti + Jacob Newman" playing "Windslept" from album: "Spoke of Several"
```

Saving the currently playing track to a file.

```bash
carton exec -- ./somafm-currently-playing.pl dronezone >> check_out_later.txt
```

Both getting the currently playing track and saving it to a file

```bash
carton exec -- ./somafm-currently-playing.pl dronezone | tee -a check_out_later.txt
"Innesti + Jacob Newman" playing "Windslept" from album: "Spoke of Several"
```

## Installation

There is not proper installation at this time. The application is a single script, which can be executed using [carton](https://metacpan.org/pod/Carton).

```bash
carton exec -- ./somafm-currently-playing.pl <station>
```

## Description

TODO

## Diagnostics

TODO

## Exit Status

- `0` success, provided argument has resolved and the currently playing track has been located and emitted

- `1` no station short name argument is provided

- `2` the provided station shortname does not match any known stations

## Dependencies

- Mojolicious
- Perl 5.16.0 or higher
- OpenSSL

Please see `cpanfile` for a complete list of dependencies.

## Bugs and Limitations

The application is basically a webscraper, so it will break of the HTML for the SomaFM website changes radically and the expected structure is no longer in place.

## Author

- jonasbn

## Motivation

I have been consuming [SomaFM] marvelous streaming for ages. Some times tracks I listen too stand out and I want to save them for later. I used to do this using  **AppleScript** to fetch the information from iTunes, however the source code was lost at some point.

Since I wanted to pick up the practice again, I decided to scrape the information from [SomaFM].

Perl has pretty strong scraping capabilities and especially when using Mojolicious, so I decided to use those tools for this task.

## Resources and References

- [SomaFM]
- [SomaFM playlists](https://somafm.com/playlist/)
- [Playlist for Space Station Soma](https://somafm.com/spacestation/songhistory.html)
- [Mojolicious](https://mojolicious.org/)
- [Mojolicious Cookbook: "Web-scraping"](https://docs.mojolicious.org/Mojolicious/Guides/Cookbook#Web-scraping)
- [Mojolicious: Mojo::DOM::CSS](https://docs.mojolicious.org/Mojo/DOM/CSS)
- [dev.to: "Scraping Google Scholar with Perl and Mojo"](https://dev.to/raigaurav/scrapping-google-scholar-with-perl-and-mojo-4neg) by Gaurav Rai, served as good example

If you want to dig more into the topic of Mojolicious client, I can point to the following book:

- [Mojolicious Web Clients](https://leanpub.com/mojo_web_clients) by brian D Foy

## License and Copyright

Copyright Jonas Brømsø (jonasbn) 2022-2024

MIT License, see separate `LICENSE` file

[SomaFM]: https://somafm.com/
