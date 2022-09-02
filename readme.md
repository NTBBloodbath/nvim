# nvim.fnl

`nvim.fnl` is a personal Neovim setup made using Fennel, it is highly inspired
by [doom-nvim](https://github.com/NTBBloodbath/doom-nvim) and covers **only** my needs.

![demo](https://user-images.githubusercontent.com/36456999/186290407-68de61f6-eb54-497a-ba66-6bd2e4894d08.png)

> **NOTE**: This setup does some black magic during launch so its startup time
>       is a pretty stable 15ms average on my machine (~2008 hardware!).


## But why?

I love Lisp and wanted to experiment with Fennel just for fun and also to try
something new, nothing more.


## Are you going to abandon doom-nvim?

If you are now wondering this, the answer is no, I'm not going to abandon `doom-nvim`.
I'm just taking a break from the project so I can experiment with a whole new codebase.

It's probable that some things made here will be also transpiled to Lua by me and
introduced into `doom-nvim` (e.g. the [heirline.nvim](https://github.com/rebelot/heirline.nvim) setup) in a near future.


## Measuring startup time

In case you want to measure my configuration startup time, you can use the script called
`measure_nvim.sh` in `extern` directory.


## Acknowledgements

This probably wouldn't have been possible if it wasn't for `zest.nvim` and some configs
I saw in Fennel (can't remember the names right now) so I want to thank the authors of
`zest.nvim` and those configurations since I got some Fennel macros from them.


## License

As _almost_ always, this project is licensed under [GPLv3](./LICENSE).