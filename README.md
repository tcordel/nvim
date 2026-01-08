# Full React and Java IDE based on [LazyVim](https://www.lazyvim.org/)

## Prerequesites

* Python3 dev environment
* Go dev environment (gitlab integration)
* [tidy](https://www.html-tidy.org/) (xml formatting)
* luarocks
* tree sitter cli: `npm install tree-sitter-cli`
* JDK > 21
* [cargo](https://doc.rust-lang.org/cargo/getting-started/installation.html) and libssl-dev

## Install

```bash
./ls/load_and_build_all.sh
```

## Configuration

```bash
# Disable sonar and spring-boot-lsp
export NO_CI=true
# NO_CI & no lsp
export NO_LSP=true
```
