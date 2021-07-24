PRAGMA foreign_keys=ON;

CREATE TABLE IF NOT EXISTS users (
    id        INTEGER PRIMARY KEY,
    username  TEXT NOT NULL UNIQUE,
    email     TEXT NOT NULL UNIQUE,
    password  TEXT NOT NULL
);
INSERT INTO users
    VALUES(1, 'ProfAvery', 'kavery@fullerton.edu', 'password');
INSERT INTO users
    VALUES(2, 'KevinAWortman', 'kwortman@fullerton.edu', 'qwerty');
INSERT INTO users
    VALUES(3, 'Beth_CSUF', 'beth.harnick.shapiro@fullerton.edu', 'secret');


CREATE TABLE IF NOT EXISTS followers (
    id            INTEGER PRIMARY KEY,
    follower_id   INTEGER NOT NULL,
    following_id  INTEGER NOT NULL,

    FOREIGN KEY(follower_id) REFERENCES users(id),
    FOREIGN KEY(following_id) REFERENCES users(id),
    UNIQUE(follower_id, following_id)
);
INSERT INTO followers(follower_id, following_id) VALUES(1, 2);
INSERT INTO followers(follower_id, following_id) VALUES(1, 3);
INSERT INTO followers(follower_id, following_id) VALUES(2, 1);
INSERT INTO followers(follower_id, following_id) VALUES(2, 3);
INSERT INTO followers(follower_id, following_id) VALUES(3, 2);


CREATE TABLE IF NOT EXISTS posts (
    id          INTEGER PRIMARY KEY,
    user_id     INTEGER NOT NULL,
    text        TEXT NOT NULL,
    timestamp   INTEGER DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(user_id) REFERENCES users(id)
);
CREATE INDEX IF NOT EXISTS post_user_id_fk_idx ON posts(user_id);
CREATE INDEX IF NOT EXISTS post_timestamp_idx ON posts(timestamp);

INSERT INTO posts(user_id, text)
    VALUES(
        1,
        'Meanwhile, at the R1 institution down the street... https://uci.edu/coronavirus/messages/200710-sanitizer-recall.php'
    );

INSERT INTO posts(user_id, timestamp, text)
    VALUES(
        1, DATETIME(CURRENT_TIMESTAMP, '+5 minutes'),
        'FYI: https://www.levels.fyi/still-hiring/'
    );

INSERT INTO posts(user_id, timestamp, text)
    VALUES(
        1, DATETIME(CURRENT_TIMESTAMP, '+3 minutes'),
        'Yes, the header file ends in .h. C++ is for masochists.'
    );

INSERT INTO posts(user_id, timestamp, text)
    VALUES(
        2, DATETIME(CURRENT_TIMESTAMP, '+2 minutes'),
        'If academia were a video game, then a 2.5 hour administrative meeting that votes to extend time 15 minutes is a fatality. FINISH HIM'
    );

INSERT INTO posts(user_id, timestamp, text)
    VALUES(
        2, DATETIME(CURRENT_TIMESTAMP, '+4 minutes'),
        'I keep seeing video from before COVID, of people not needing to mask or distance, and doing something like waiting in line at Burger King. YOU''RE WASTING IT!'
    );

INSERT INTO posts(user_id, timestamp, text)
    VALUES(
        3, DATETIME(CURRENT_TIMESTAMP, '+1 minute'),
        '#cpsc315 #engr190w NeurIPS is $25 for students and $100 for non-students this year! https://medium.com/@NeurIPSConf/neurips-registration-opens-soon-67111581de99'
    );

CREATE TABLE IF NOT EXISTS direct_messages (
    id              INTEGER PRIMARY KEY,
    from_user_id    INTEGER NOT NULL,
    to_user_id      INTEGER NOT NULL,
    in_reply_to_id  INTEGER,
    text            TEXT NOT NULL,
    timestamp       INTEGER DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(from_user_id) REFERENCES users(id),
    FOREIGN KEY(to_user_id) REFERENCES users(id),
    FOREIGN KEY(in_reply_to_id) REFERENCES direct_messages(id)
);
CREATE INDEX IF NOT EXISTS direct_messages_from_user_id_fk_idx
    ON direct_messages(from_user_id);
CREATE INDEX IF NOT EXISTS direct_messages_to_user_id_fk_idx
    ON direct_messages(to_user_id);
CREATE INDEX IF NOT EXISTS direct_messages_in_reply_to_id_fk_idx
    ON direct_messages(in_reply_to_id);

INSERT INTO direct_messages(id, from_user_id, to_user_id, text)
    VALUES(
        1, 3, 1,
        'Thought this was of interest: https://computinged.wordpress.com/2018/11/16/how-machine-learning-impacts-the-undergraduate-computing-curriculum/'
    );
INSERT INTO
    direct_messages(from_user_id, to_user_id, in_reply_to_id, timestamp, text)
    VALUES(
        1, 3, 1, DATETIME(CURRENT_TIMESTAMP, '+1 minute'),
        'Thanks! Going to share this with Dr. Ryu.'
    );

CREATE TABLE IF NOT EXISTS polls (
    id          INTEGER PRIMARY KEY,
    user_id     INTEGER NOT NULL,
    question    TEXT NOT NULL,

    FOREIGN KEY(user_id) REFERENCES users(id)
);
CREATE INDEX IF NOT EXISTS polls_user_id_fk_idx ON polls(user_id);

INSERT INTO polls(id, user_id, question)
    VALUES(1, 1, 'What''s is your favorite term of the academic year?');

CREATE TABLE IF NOT EXISTS poll_options (
    id      INTEGER PRIMARY KEY,
    poll_id INTEGER NOT NULL,
    text    TEXT NOT NULL,

    FOREIGN KEY(poll_id) REFERENCES polls(id)
);
CREATE INDEX IF NOT EXISTS poll_options_poll_id_fk_idx
    ON poll_options(poll_id);

INSERT INTO poll_options(poll_id, id, text) VALUES(1, 1, 'Fall Semester');
INSERT INTO poll_options(poll_id, id, text) VALUES(1, 2, 'Spring Semester');
INSERT INTO poll_options(poll_id, id, text) VALUES(1, 3, 'Summer Session A');
INSERT INTO poll_options(poll_id, id, text) VALUES(1, 4, 'Summer Session B');

CREATE TABLE IF NOT EXISTS poll_votes (
    id          INTEGER PRIMARY KEY,
    poll_id     INTEGER NOT NULL,
    user_id     INTEGER NOT NULL,
    option_id   INTEGER NOT NULL,

    FOREIGN KEY(poll_id) REFERENCES polls(id),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(option_id) REFERENCES poll_options(id),
    UNIQUE(poll_id, user_id)
);
CREATE INDEX IF NOT EXISTS poll_votes_poll_id_fk_idx
    ON poll_votes(poll_id);
CREATE INDEX IF NOT EXISTS poll_votes_user_id_fk_idx
    ON poll_votes(user_id);
CREATE INDEX IF NOT EXISTS poll_votes_option_id_fk_idx
    ON poll_votes(option_id);

INSERT INTO poll_votes(poll_id, user_id, option_id) VALUES(1, 1, 4);
INSERT INTO poll_votes(poll_id, user_id, option_id) VALUES(1, 2, 1);
INSERT INTO poll_votes(poll_id, user_id, option_id) VALUES(1, 3, 1);

