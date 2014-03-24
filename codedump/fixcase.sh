#from http://stackoverflow.com/questions/11818408/convert-all-file-extensions-to-lower-case
find . -name '*.*' -exec sh -c '
  a=$(echo {} | sed -r "s/([^.]*)\$/\L\1/");
  [ "$a" != "{}" ] && mv "{}" "$a" ' \;
