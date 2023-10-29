# Fido

<img src="fido_logo.png" height="128" />

CLI tool for saving web pages locally

## Dependencies

- **Ruby** 3.2.2

## Usage

Build with docker:
```shell
docker build -t fido .
```

Then list the sites you would like to download:
```shell
docker run --rm fido https://google.com https://www.twitch.tv https://www.google.com https://www.example.com https://en.wikipedia.org/wiki/Boat
```

The `--metadata` flag can be used to see additional stats:
```shell
docker run --rm fido https://www.twitch.tv --metadata
```

To access the content, [create a volume](https://docs.docker.com/storage/volumes/#start-a-container-with-a-volume) for the `/fetches` directory and it will be filled with the downloaded files.

## Attribution

<a href="https://www.flaticon.com/free-icons/dog-food" title="dog food icons">Dog food icons created by Prashanth Rapolu 15 - Flaticon</a>
