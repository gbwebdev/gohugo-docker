# gohugo-docker

Container for [Gohugo](https://gohugo.io) static site generator.

## Usage

### Dynamically serve the site

Hugo can serve your website for live preview.
It re-renders the pages as you edit them and you can see those change in near real time in your browser.

To do that you can simply run :
```console
docker run -v <<path of your project directory>>:/mnt/workdir -p 1313:1313 gbwebdev/gohugo
```

When inside your project directory, you can simply run :
```console
docker run -v $(pwd):/mnt/workdir -p 1313:1313 gbwebdev/gohugo
```

Then simply browse to `http://localhost:1313`.

### Use the CLI

To use the CLI, simply run :
```console
docker run -v <<path of your project directory>>:/mnt/workdir [-p 1313:1313]  -it gbwebdev/gohugo entrypoint
```
You can then simply type "hugo" and start using the cli.

When inside your project directory, you can simply run :
```console
docker run -v $(pwd):/mnt/workdir [-p 1313:1313]  -it gbwebdev/gohugo entrypoint
```

If the project is not setup yet, it will be setup automatically.

You can use the `FORMAT` environment variable to choose the configuration files format (by default it is "yaml").