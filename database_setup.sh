createuser --echo --createdb --encrypted --pwprompt --no-createrole --no-superuser mytechbooks
createdb --echo --owner=mytechbooks -E utf8 mytechbooks_development
createdb --echo --owner=mytechbooks -E utf8 mytechbooks_test
