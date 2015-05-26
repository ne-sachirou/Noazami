Noazami on Windows
==
Install Ruby
--
Install an installer or a 7zip archive of

- Ruby 2.2.2
- Ruby 2.2.2(x64)

from [RubyInstaller](http://rubyinstaller.org/downloads/)

and DevKit-mingw64-*-4.7.2-20130224-1432-sfx.exe, then set PATH.

Install Noazami
--
### Clone the repo
```bat
git clone https://github.com/ne-sachirou/Noazami.git
cd Noazami\server
```

### Install puma
Since puma is native gem, OpenSSL dev package is needed.
`bundle install` will fail.

cf. [Installing puma on windows](https://github.com/hicknhack-software/rails-disco/wiki/Installing-puma-on-windows)

1. download [OpenSSL Developer Package](http://packages.openknapsack.org/openssl/openssl-1.0.0k-x86-windows.tar.lzma)
2. unpack that tar.lzma (use [Explzh (x86)](http://www.ponsoftware.com/) or [7-Zip](http://sevenzip.osdn.jp/) etc.)
3. open cmd window and run `devkitvars.bat` (in Devkit directory)
4. gem install puma -- --with-opt-dir=c:\path\to\openssl

### bundle install
```bat
bundle install
```

Run Noazami server
--
Open cmd window

```bat
cd server
set RUBYOPT=-EUTF-8
bundle exec puma -p3000 config.ru
```

Access http://localhost:3000/
