FROM gitpod/workspace-full:latest

RUN sudo apt-get install -y fonts-firacode fonts-cascadia-code
RUN brew install zig
