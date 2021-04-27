--Create IM DB Tables
CREATE TABLE im_instrument_list(
	instrument_id INT IDENTITY PRIMARY KEY
	, instrument_name CHAR(12) NOT NULL 
)

CREATE TABLE im_band_member(
	band_member_id INT IDENTITY PRIMARY KEY
	, band_member_name VARCHAR(30) NOT NULL 
	, instrument_id INT FOREIGN KEY REFERENCES im_instrument_list(instrument_id) NOT NULL 
)

CREATE TABLE im_song(
	song_id INT IDENTITY PRIMARY KEY
	, song_title VARCHAR(30) NOT NULL 
	, song_writer VARCHAR(30) NOT NULL 
	, length_minutes INT NOT NULL
	, length_seconds INT NOT NULL
)

CREATE TABLE im_member_song(
	member_song_id INT IDENTITY PRIMARY KEY
	, band_member_id  INT FOREIGN KEY REFERENCES im_band_member(band_member_id) NOT NULL
	, song_id INT FOREIGN KEY REFERENCES im_song(song_id) NOT NULL 
)

CREATE TABLE im_certification_rank_list (
	certification_rank_id INT IDENTITY PRIMARY KEY
	, certification_rank INT NOT NULL
)

CREATE TABLE im_studio (
	studio_id INT IDENTITY PRIMARY KEY
	, studio_name VARCHAR(30) NOT NULL
)

CREATE TABLE im_recording_location (
	recording_location_id INT IDENTITY PRIMARY KEY
	, recording_location VARCHAR(30) NOT NULL
)

CREATE TABLE im_album (
	album_id INT IDENTITY PRIMARY KEY
	, album_title VARCHAR(40) NOT NULL
	, track_count INT NOT NULL
	, release_year VARCHAR(4) NOT NULL
	, album_length_minutes INT
	, album_length_seconds INT
	, us_peak_charts INT
	, uk_peak_charts INT
	, us_certification INT
	, uk_certification INT
	, band_member_id INT FOREIGN KEY REFERENCES im_band_member(band_member_id)
	, song_id INT FOREIGN KEY REFERENCES im_song(song_id)
	, studio_id INT FOREIGN KEY REFERENCES im_studio(studio_id)
	, recording_location_id INT FOREIGN KEY REFERENCES im_recording_location(recording_location_id)
)

CREATE TABLE im_album_song(
	album_song_id INT IDENTITY PRIMARY KEY
	, album_id  INT FOREIGN KEY REFERENCES im_album(album_id) NOT NULL
	, song_id INT FOREIGN KEY REFERENCES im_song(song_id) NOT NULL 
)

CREATE TABLE im_producer (
	producer_id INT IDENTITY PRIMARY KEY
	, producer_name VARCHAR(30)
	, album_id INT FOREIGN KEY REFERENCES im_album(album_id)
)

-- Insert Data
INSERT INTO im_instrument_list
    (instrument_name)
VALUES
    ('Guitar'),
    ('Drums'),
    ('Vocals'),
    ('Bass')

INSERT INTO im_band_member
    (band_member_name, instrument_id)
VALUES
    ('Steve Harris', 4)
		,
    ('Dave Murray', 1)
		,
    ('Adrian Smith', 1)
		,
    ('Bruce Dickinson', 3)
		,
    ('Nicko McBrain', 2)
		,
    ('Janick Gers', 1)
		,
    ('Doug Sampson', 2)
		,
    ('Paul Di''Anno', 3)
		,
    ('Dennis Stratton', 1)
		,
    ('Clive Burr', 2)
		,
    ('Blaze Bayley', 3)

