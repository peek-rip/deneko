# optimized compiling

# here are optimized compilation flags for nim:
# nim c -r -d:ssl --opt:size --threads:on --app:console -d:release "{NIM FILE PATH}"

# here are optimized upx flags for the final executable
# upx -9 --best -f --lzma --brute --ultra-brute --overlay=strip --8086 --8-bit --no-align --strip-relocs=1 {EXE FILE PATH}