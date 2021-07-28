.PHONY: clean

mockroblog.db: mockroblog.sql clean
	sqlite3 $@ < $<

clean:
	rm -f mockroblog.db
