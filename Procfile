sandman: sandman2ctl -p $PORT --enable-cors True sqlite+pysqlite:///var/mockroblog.db
api: python3 -m bottle --bind=localhost:$PORT --debug --reload search
