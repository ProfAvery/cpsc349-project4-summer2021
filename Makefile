.PHONY: clean

var/mockroblog.db: share/mockroblog.sql clean
	sqlite3 $@ < $<
	sqlite-utils enable-fts $@ posts text --create-triggers --tokenize=porter

clean:
	rm -f var/mockroblog.db
