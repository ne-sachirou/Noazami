set RUBYOPT=-EUTF-8
set CWD=%CD%
cd server
bundle install
rem rackup -sPuma -Eproduction -p3000 config.ru
puma -p3000 config.ru
cd %CWD%
