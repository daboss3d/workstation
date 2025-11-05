# ---------- Build Stage ----------
FROM alpine:edge AS builder
LABEL maintainer="Carlos Correia <carlos.correia@4d-spaces.com>"

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.23/community" >> /etc/apk/repositories
#RUN apk update

RUN apk add --no-cache \
    lua-luv-dev git cmake make gcc g++ pkgconfig musl-dev gettext-dev curl unzip \
    lua5.1 luajit-dev libtermkey libuv msgpack-c unibilium libvterm  tree-sitter

# Clone and build Neovim
RUN git clone --depth 1 --branch stable https://github.com/neovim/neovim.git /tmp/neovim
WORKDIR /tmp/neovim
RUN make CMAKE_BUILD_TYPE=Release && make install DESTDIR=/tmp/nvim-install

# ---------- Runtime Stage ----------
FROM alpine:edge
LABEL maintainer="Carlos Correia <carlos.correia@4d-spaces.com>"

# Install build dependencies
RUN apk add --no-cache \
    git cmake make gcc g++ pkgconfig \
    musl-dev gettext-dev curl unzip \
    lua5.1-dev luajit-dev \
    libtermkey-dev libuv-dev msgpack-c-dev unibilium-dev libvterm-dev lua-luv-dev tree-sitter-dev



# Copy Neovim from builder
COPY --from=builder /tmp/nvim-install/usr/local /usr/local

# Node.js (for LSP and formatters)
#RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
#    apt-get install -y nodejs
#    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/community" >> /etc/apk/repositories

RUN apk update && apk upgrade && \
    apk add --no-cache nodejs npm



# Install LazyVim
RUN git clone https://github.com/LazyVim/starter /root/.config/nvim 
#RUN git clone https://github.com/LazyVim/starter /root/.config/nvim && \
#    echo 'require("config.cds")' >> /root/.config/nvim/init.lua
 
# Copy LazyVim configs
ADD mason-nvim.lua /root/.config/nvim/lua/plugins/mason-nvim.lua
#ADD cds.lua /root/.config/nvim/lua/config/cds.lua
ADD rest.lua /root/.config/nvim/lua/plugins/rest.lua
ADD keymaps.lua /root/.config/nvim/lua/config/keymaps.lua
ADD options.lua /root/.config/nvim/lua/config/options.lua
#
## Tree-sitter CDS syntax files
#ADD https://github.com/cap-js-community/tree-sitter-cds/raw/main/nvim/locals.scm /root/.config/nvim/queries/cds/locals.scm
#ADD https://github.com/cap-js-community/tree-sitter-cds/raw/main/nvim/folds.scm /root/.config/nvim/queries/cds/folds.scm
#ADD https://github.com/cap-js-community/tree-sitter-cds/raw/main/nvim/highlights.scm /root/.config/nvim/queries/cds/highlights.scm
#ADD https://github.com/cap-js-community/tree-sitter-cds/raw/main/nvim/indents.scm /root/.config/nvim/queries/cds/indents.scm
#ADD https://github.com/cap-js-community/tree-sitter-cds/raw/main/nvim/injections.scm /root/.config/nvim/queries/cds/injections.scm
#
ENTRYPOINT ["nvim"]
#
