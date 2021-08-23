-- #######################
-- ##### Drop Tables #####
-- #######################

IF EXISTS (SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'im_album_recording_location')
BEGIN
    DROP TABLE im_album_recording_location
END 
GO

IF EXISTS (SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'im_album_studio')
BEGIN
    DROP TABLE im_album_studio
END 
GO

IF EXISTS (SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'im_producer_album_list')
BEGIN
    DROP TABLE im_producer_album_list
END 
GO

IF EXISTS (SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'im_producer')
BEGIN
    DROP TABLE im_producer
END 
GO

IF EXISTS (SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'im_album_song')
BEGIN
    DROP TABLE im_album_song
END 
GO

IF EXISTS (SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'im_member_song')
BEGIN
    DROP TABLE im_member_song
END 
GO

IF EXISTS (SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'im_song')
BEGIN
    DROP TABLE im_song
END 
GO

-- Start
IF EXISTS (SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'im_album')
BEGIN
    DROP TABLE im_album
END 
GO

IF EXISTS (SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'im_recording_location')
BEGIN
    DROP TABLE im_recording_location
END 
GO
-- End


IF EXISTS (SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'im_studio')
BEGIN
    DROP TABLE im_studio
END 
GO

-- Start
IF EXISTS (SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'im_certification_rank_list')
BEGIN
    DROP TABLE im_certification_rank_list
END 
GO
-- End

IF EXISTS (SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'im_band_member')
BEGIN
    DROP TABLE im_band_member
END 
GO

IF EXISTS (SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'im_instrument_list')
BEGIN
    DROP TABLE im_instrument_list
END 
GO


-- #########################
-- ##### Create Tables #####
-- #########################

CREATE TABLE im_instrument_list(
	instrument_id INT IDENTITY PRIMARY KEY
	, instrument_name CHAR(12) NOT NULL 
)

CREATE TABLE im_band_member(
	band_member_id INT IDENTITY PRIMARY KEY
	, band_member_name VARCHAR(30) NOT NULL 
	, instrument_id INT FOREIGN KEY REFERENCES im_instrument_list(instrument_id) NOT NULL 
)


CREATE TABLE im_certification_rank_list (
	certification_rank_id INT IDENTITY PRIMARY KEY
	, certification_rank CHAR(10) NOT NULL
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
	, release_date DATE NOT NULL
	, album_length_minutes INT
	, album_length_seconds INT
	, us_peak_charts INT
	, uk_peak_charts INT
	, us_certification_id INT FOREIGN KEY REFERENCES im_certification_rank_list(certification_rank_id)
	, uk_certification_id INT  FOREIGN KEY REFERENCES im_certification_rank_list(certification_rank_id)
	--, studio_id INT FOREIGN KEY REFERENCES im_studio(studio_id)
	--, recording_location_id INT FOREIGN KEY REFERENCES im_recording_location(recording_location_id)
	--, band_member_id INT FOREIGN KEY REFERENCES im_band_member(band_member_id)
	--, song_id INT FOREIGN KEY REFERENCES im_song(song_id)
)

CREATE TABLE im_song(
	song_id INT IDENTITY PRIMARY KEY
	, song_title VARCHAR(50) NOT NULL 
	, length_minutes INT NOT NULL
	, length_seconds INT NOT NULL
	, album_id INT FOREIGN KEY REFERENCES im_album(album_id) NOT NULL
	--, song_writer VARCHAR(30) NOT NULL 
)

CREATE TABLE im_member_song(
	member_song_id INT IDENTITY PRIMARY KEY
	, band_member_id  INT FOREIGN KEY REFERENCES im_band_member(band_member_id) NOT NULL 
	, song_id INT FOREIGN KEY REFERENCES im_song(song_id) NOT NULL 
)

CREATE TABLE im_album_song(
	album_song_id INT IDENTITY PRIMARY KEY
	, album_id  INT FOREIGN KEY REFERENCES im_album(album_id) NOT NULL
	, song_id INT FOREIGN KEY REFERENCES im_song(song_id) NOT NULL 
)

CREATE TABLE im_producer (
	producer_id INT IDENTITY PRIMARY KEY
	, producer_name VARCHAR(40)
)

CREATE TABLE im_producer_album_list (
	producer_album_id INT IDENTITY PRIMARY KEY
	, producer_id INT FOREIGN KEY REFERENCES im_producer(producer_id) NOT NULL
	, album_id INT FOREIGN KEY REFERENCES im_album(album_id) 
)

CREATE TABLE im_album_studio (
	album_studio_id INT IDENTITY PRIMARY KEY
	, album_id INT FOREIGN KEY REFERENCES im_album(album_id)
	, studio_id INT FOREIGN KEY REFERENCES im_studio(studio_id)
)

CREATE TABLE im_album_recording_location (
	album_recording_location_id INT IDENTITY PRIMARY KEY
	, album_id INT FOREIGN KEY REFERENCES im_album(album_id)
	, recording_location_id INT FOREIGN KEY REFERENCES im_recording_location(recording_location_id)
)

-- #######################
-- ##### Insert Data #####
-- #######################

-- List of instruments played by band members
INSERT INTO im_instrument_list
    (instrument_name)
VALUES ('Guitar'),('Drums'),('Vocals'),('Bass')

-- Members of the band
INSERT INTO im_band_member
    (band_member_name, instrument_id)
VALUES ('Steve Harris', 4),('Dave Murray', 1),('Adrian Smith', 1),('Bruce Dickinson', 3)
		,('Nicko McBrain', 2),('Janick Gers', 1),('Doug Sampson', 2),('Paul Di''Anno', 3)
		,('Dennis Stratton', 1),('Clive Burr', 2),('Blaze Bayley', 3)

-- List of album certifications based on precious metals
INSERT INTO im_certification_rank_list (certification_rank)
VALUES ('Silver'),('Gold'),('Platinum')

-- #####################
-- ### LEFT OFF HERE ###
-- #####################

-- How to link songs and stuff to associative table?
-- Need Studio ID and Recording Location ID 

-- Studio albums
INSERT INTO im_album (album_title,track_count,album_length_minutes
						,album_length_seconds,release_date,us_peak_charts,uk_peak_charts
						,us_certification_id,uk_certification_id)
VALUES ('Iron Maiden', 8, 37, 35, '4/14/1980', 4, NULL, 3, NULL)
		,('Killers', 10, 38, 13, '2/2/1981', 12, 78, 2, 2)
		, ('The Number of the Beast', 8, 39, 11, '3/22/1982', 1, 33, 3, 3)
		, ('Piece of Mind', 9, 45, 18, '5/16/1983', 3, 14, 3, 3)
		, ('Powerslave', 8, 51, 12, '9/3/1984', 2, 21, 2, 3)
		, ('Somewhere In Time', 8, 51, 18, '9/29/1986', 3, 11, 2, 3)
		, ('Seventh Son of a Seventh Son', 8, 43, 51, '4/11/1988', 1, 12, 2,2)
		, ('No Prayer for the Dying', 10, 43, 42, '10/1/1990', 2, 12,2, 2)
		, ('Fear of the Dark', 12, 57, 58, '5/11/1992', 1, 12, 2, NULL)
		, ('The X Factor', 11, 71, 7, '10/2/1995', 8, 147, 1, NULL)
		, ('Virtual XI', 8, 53, 22, '3/23/1998', 16, 124, 1, NULL)
		, ('Brave New World', 10, 66, 57, '5/29/2000', 7, 39, 2, NULL)
		, ('Dance of Death', 11, 67, 57, '9/8/2003', 2, 18, 2, NULL)
		, ('A Matter of Life and Death', 10, 71, 53, '8/28/2006', 4, 9, 2, NULL)
		, ('The Final Frontier', 10, 76, 34, '8/16/2010', 1, 4, 2, NULL)
		, ('The Book of Souls', 11, 96, 46, '9/4/2015', 1, 4, 2, NULL)

-- How can I link writers from associative table? 

-- Songs
INSERT INTO im_song (song_title, length_minutes, length_seconds,album_id)
VALUES ('Prowler', 3, 55, 1)
		,('Remember Tomorrow', 5, 27, 1)
		,('Running Free', 3, 16, 1)
		,('Phantom of the Opera', 7, 20, 1)
		,('Transylvania (Instrumental)', 4, 5, 1)
		,('Strange World', 5, 45, 1)
		,('Charlotte the Harlot', 4, 12, 1)
		,('Iron Maiden', 3, 35, 1)
		,('The Ides of March (Instrumental)', 1, 48, 2)
		,('Wrathchild', 2, 54, 2)
		,('Murders in the Rue Morgue', 4, 14, 2)
		,('Another Life', 3, 22, 2)
		,('Genghis Khan (Instrumental)', 3, 2, 2)
		,('Innocent Exile', 3, 50, 2)
		,('Killers', 4, 58, 2)
		,('Prodigal Son', 6, 0, 2)
		,('Purgatory', 3, 18, 2)
		,('Drifter', 4, 47, 2)
		,('Invaders', 3, 20, 3)
		,('Children of the Damned', 4, 34, 3)
		,('The Prisoner', 5, 34, 3)
		,('22 Acacia Avenue', 6, 34, 3)
		,('The Number of the Beast', 4, 25, 3)
		,('Run to the Hills', 3, 50, 3)
		,('Gangland', 3, 46, 3)
		,('Hallowed Be Thy Name', 7, 8, 3)
		,('Where Eagles Dare', 6, 8, 4)
		,('Revelations', 6, 51, 4)
		,('Flight of Icarus', 3, 49, 4)
		,('Die with Your Boots On', 5, 22, 4)
		,('The Trooper', 4, 10, 4)
		,('Still Life', 4, 27, 4)
		,('Quest for Fire', 3, 40, 4)
		,('Sun and Steel', 3, 25, 4)
		,('To Tame a Land', 7, 26, 4)
		,('Aces High', 4, 31, 5)
		,('2 Minutes to Midnight', 6, 4, 5)
		,('Losfer Words (Big ''Orra) (Instrumental)', 4, 15, 5)
		,('Flash of the Blade', 4, 5, 5)
		,('The Duellists', 6, 18, 5)
		,('Back in the Village', 5, 2, 5)
		,('Powerslave', 7, 12, 5)
		,('Rime of the Ancient Mariner', 1, 45, 5)
		,('Caught Somewhere in Time', 7, 22, 6)
		,('Wasted Years', 5, 6, 6)
		,('Sea of Madness', 5, 42, 6)
		,('Heaven Can Wait', 7, 24, 6)
		,('The Loneliness of the Long Distance Runner', 6, 31, 6)
		,('Stranger in a Strange Land', 5, 43, 6)
		,('Deja-Vu', 4, 55, 6)
		,('Alexander the Great', 8, 35, 6)
		,('Moonchild', 5, 38, 7)
		,('Infinite Dreams', 6, 8, 7)
		,('Can I Play with Madness', 3, 30, 7)
		,('The Evil That Men Do', 4, 33, 7)
		,('Seventh Son of a Seventh Son', 9, 52, 7)
		,('The Prophecy', 5, 4, 7)
		,('The Clairvoyant', 4, 26, 7)
		,('Only the Good Die Young', 4, 40, 7)
		,('Tailgunner', 4, 13, 8)
		,('Holy Smoke', 3, 47, 8)
		,('No Prayer for the Dying', 4, 22, 8)
		,('Public Enema Number One', 4, 3, 8)
		,('Fates Warning', 4, 9, 8)
		,('The Assassin', 4, 16, 8)
		,('Run Silent Run Deep', 4, 4, 8)
		,('Hooks in You', 4, 6, 8)
		,('Bring Your Daughter... to the Slaughter', 4, 42, 8)
		,('Mother Russia', 5, 30, 8)
		,('Be Quick or Be Dead', 3, 21, 9)
		,('From Here to Eternity', 3, 35, 9)
		,('Afraid to Shoot Strangers', 6, 52, 9)
		,('Fear Is the Key', 5, 30, 9)
		,('Childhood''s End', 4, 37, 9)
		,('Wasting Love', 5, 46, 9)
		,('The Fugitive', 4, 52, 9)
		,('Chains of Misery', 3, 33, 9)
		,('The Apparition', 3, 53, 9)
		,('Judas Be My Guide', 3, 6, 9)
		,('Weekend Warrior', 5, 37, 9)
		,('Fear of the Dark', 7, 16, 9)
		,('Sign of the Cross', 11, 18, 10)
		,('Lord of the Flies',5, 4, 10)
		,('Man on the Edge',4, 13, 10)
		,('Fortunes of War',7, 24, 10)
		,('Look for the Truth',5, 10, 10)
		,('The Aftermath',6, 21, 10)
		,('Judgement of Heaven',5, 12, 10)
		,('Blood on the World''s Hands',5, 58, 10)
		,('The Edge of Darkness',6, 39, 10)
		,('2 A.M.',5, 38, 10)
		,('The Unbeliever',8, 10, 10)
		,('Futureal',3, 0, 11)
		,('The Angel and the Gambler',9, 51, 11)
		,('Lightning Strikes Twice',4, 49, 11)
		,('The Clansman',9, 6, 11)
		,('When Two Worlds Collide',6, 13, 11)
		,('The Educated Fool',6, 46, 11)
		,('Don''t Look to the Eyes of a Stranger',8, 11, 11)
		,('Como Estais Amigos',5, 26, 11)
		,('The Wicker Man',4, 35, 12)
		,('Ghost of the Navigator',6, 50, 12)
		,('Brave New World',6, 18, 12)
		,('Blood Brothers',7, 14, 12)
		,('The Mercenary',4, 42, 12)
		,('Dream of Mirrors',9, 21, 12)
		,('The Fallen Angel',4, 0, 12)
		,('The Nomad',9, 6, 12)
		,('Out of the Silent Planet',6, 25, 12)
		,('The Thin Line Between Love and Hate',8, 26, 12)
		,('Wildest Dreams',3, 52, 13)
		,('Rainmaker',3, 48, 13)
		,('No More Lies',7, 21, 13)
		,('Montsegur',5, 50, 13)
		,('Dance of Death',8, 36, 13)
		,('Gates of Tomorrow',5, 12, 13)
		,('New Frontier',5, 4, 13)
		,('Paschendale',8, 27, 13)
		,('Face in the Sand',6, 31, 13)
		,('Age of Innocence',6, 10, 13)
		,('Journeyman',7, 6, 13)
		,('Different World',4, 17, 14)
		,('These Colours Don''t Run',6, 52, 14)
		,('Brighter Than a Thousand Suns',8, 44, 14)
		,('The Pilgrim',5, 7, 14)
		,('The Longest Day',7, 48, 14)
		,('Out of the Shadows',5, 36, 14)
		,('The Reincarnation of Benjamin Breeg',7, 21, 14)
		,('For the Greater Good of God',9, 23, 14)
		,('Lord of Light',7, 25, 14)
		,('The Legacy',9, 20, 14)
		,('Satellite 15... The Final Frontier',8, 40, 15)
		,('El Dorado',6, 49, 15)
		,('Mother of Mercy',5, 20, 15)
		,('Coming Home',5, 52, 15)
		,('The Alchemist',4, 29, 15)
		,('Isle of Avalon',9, 6, 15)
		,('Starblind',7, 48, 15)
		,('The Talisman',9, 3, 15)
		,('The Man Who Would Be King',8, 28, 15)
		,('When the Wild Wind Blows',10, 59, 15)
		,('If Eternity Should Fail',8, 28, 16)
		,('Speed Of Light',5, 1, 16)
		,('The Great Unknown',6, 37, 16)
		,('The Red And The Black',13, 33, 16)
		,('When The River Runs Deep',10, 27, 16)
		,('The Book Of Souls',10, 27, 16)
		,('Death Or Glory',5, 13, 16)
		,('Shadows Of The Valley',7, 32, 16)
		,('Tears Of A Clown',4, 59, 16)
		,('The Man Of Sorrows',6, 28, 16)
		,('Empire Of The Clouds',18, 1, 16)



-- Associative table for albums and songs 
INSERT INTO im_album_song (album_id,song_id)
		-- Iron Maiden
VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8)
		-- Killers 
		,(2,9),(2,10),(2,11),(2,12),(2,13),(2,14),(2,15),(2,16),(2,17),(2,18)
		-- The Number of the Beast
		,(3,19),(3,20),(3,21),(3,22),(3,23),(3,24),(3,25),(3,26)
		-- Piece of Mind
		,(4,27),(4,28),(4,29),(4,30),(4,31),(4,32),(4,33),(4,34),(4,35)
		-- Powerslave
		,(5,36),(5,37),(5,38),(5,39),(5,40),(5,41),(5,42),(5,43)
		-- Somewhere in Time
		,(6,44),(6,45),(6,46),(6,47),(6,48),(6,49),(6,50),(6,51)
		-- Seventh Son of a Seventh Son
		,(7,52),(7,53),(7,54),(7,55),(7,56),(7,57),(7,58),(7,59)
		-- No Prayer for the Dying
		,(8,60),(8,61),(8,62),(8,63),(8,64),(8,65),(8,66),(8,67),(8,68),(8,69)
		-- Fear of the Dark
		,(9,70),(9,71),(9,72),(9,73),(9,74),(9,75),(9,76),(9,77),(9,78),(9,79),(9,80),(9,81)
		-- The X-Factor
		,(10,82),(10,83),(10,84),(10,85),(10,86),(10,87),(10,88),(10,89),(10,90),(10,91),(10,92)
		-- Virtual XI
		,(11,93),(11,94),(11,95),(11,96),(11,97),(11,98),(11,99),(11,100)
		-- Brave New World
		,(12,101),(12,102),(12,103),(12,104),(12,105),(12,106),(12,107),(12,108),(12,109),(12,110)
		-- Dance of Death
		,(13,111),(13,112),(13,113),(13,114),(13,115),(13,116),(13,117),(13,118),(13,119),(13,120),(13,121)
		-- A Matter of Life and Death
		,(14,122),(14,123),(14,124),(14,125),(14,126),(14,127),(14,128),(14,129),(14,130),(14,131)
		-- The Final Frontier
		,(15,132),(15,133),(15,134),(15,135),(15,136),(15,137),(15,138),(15,139),(15,140),(15,141)
		-- The Book of Souls
		,(16,142),(16,143),(16,144),(16,145),(16,146),(16,147),(16,148),(16,149),(16,150),(16,151),(16,152)

-- Producers of albums
INSERT INTO im_producer (producer_name)
VALUES ('Will Malone'),('Martin Birch'),('Steve Harris'),('Nigel Green'),('Kevin Shirley')

-- Recording locations of albums
INSERT INTO im_recording_location (recording_location)
VALUES ('Kingsway Studios'),('Battery Studis'),('Compass Point Studios'),('Wisseloord Studios')
		,('Musicland Studios'),('Barnyard Studios'),('Gullaume Tell Studios'),('Sarm West Studios')
		,('The Cave Studios')

-- Studios that distributed the albums 
INSERT INTO im_studio (studio_name)
VALUES ('EMI (Europe)'),('EMI'),('EMI (EMC 3400)'),('Harvest (North America)'),('Capitol (North America)')
		,('Capitol (US)'),('Epic (US)'),('CMC (North America)'),('BMG (US)'),('CMC (US)'),('Portrait (US)')
		,('Columbia (US)'),('Sanctuary (US)'),('EMI UME'),('Sony (US)'),('Parlophone'),('Sanctuary Copyrights (US)')

-- Associative table for albums and studios
INSERT INTO im_album_studio (album_id,studio_id)
VALUES (1,1), (1,4), (2,2), (2,4), (2,5), (3,3), (3,4), (4,2), (4,5)
		, (5,2), (5,5), (6,2), (6,5), (7,2), (7,6), (8,2), (8,7)
		, (9,2), (9,7), (10,2), (10,8), (11,2), (11,10), (11,9), (12,2), (12,11), (12,12)
		, (13,2), (13,12), (14,2), (14,13), (15,14), (15,15), (16,16), (16,17), (16,9)

-- Associative table for albums and producers
INSERT INTO im_producer_album_list (album_id,producer_id)
VALUES (1,1), (2,2), (3,2), (4,2)
		, (5,2), (6,2), (7,2), (8,2)
		, (9,2), (9,3), (10,3), (10,4), (11,3), (11,4), (12,5), (12,3)
		, (13,5), (13,3), (14,5), (14,3), (15,5), (15,3), (16,5), (16,3)

-- Associative Table for albums and recording locations 
INSERT INTO im_album_recording_location (album_id,recording_location_id)
VALUES (1,1), (2,2), (3,2), (4,3)
		, (5,3), (6,3), (6,4), (7,5), (8,6)
		, (9,6), (10,6), (11,6), (12,7)
		, (13,8), (14,8), (15,3), (15,9), (16,7)

-- Associative table for songs and the band members who contributed to writing them 
INSERT INTO im_member_song (song_id,band_member_id)
		--Iron Maiden
VALUES (1,1), (2,1), (2,8), (3,1), (3,8), (4,1), (5,1), (6,1), (7,2), (8,1)
		-- Killers
		, (9,1), (10,1), (11,1), (12,1), (13,1), (14,1), (15,1), (15,8), (16,1), (17,1), (18,1)
		-- The Number of the Beast
		, (19,1), (20,1), (21,1), (21,3), (22,1), (22,3), (23,1), (24,1), (25,3), (25,10), (26,1)
		-- Piece of Mind
		, (27,1), (28,4), (29,3), (29,4), (30,1), (30,3), (30,4), (31,1), (32,1), (32,2), (33,1), (34,4), (34,3), (35,1)
		-- Powerslave
		, (36,1), (37,3), (37,4), (38,1), (39,4), (40,1), (41,3), (41,4), (42,4), (43,1)
		-- Somewhere in Time
		, (44,1), (45,3), (46,3), (47,1), (48,1), (49,3), (50,2), (50,1), (51,1)
		-- Seventh Son of a Seventh Son
		, (52,3), (52,4), (53,1), (54,3), (54,4), (54,1), (55,3), (55,4), (55,1), (56,1), (57,2), (57,1), (58,1), (59,1), (59,4)
		--No Prayer for the Dying
		, (60,1), (60,4), (61,1), (61,4), (62,1), (63,2), (63,4), (64,2), (64,1), (65,1), (66,1), (66,4), (67,4), (67,3), (68,4), (69,1)
		-- Fear of the Dark
		, (70,4), (70,6), (71,1), (72,1), (73,4), (73,6), (74,1), (75,4), (75,6), (76,1), (77,4), (77,2), (78,1), (78,6), (79,4), (79,2), (80,1), (80,6), (81,1)
		-- The X-Factor
		, (82,1), (83,1), (83,6), (84,11), (84,6), (85,1), (86,11), (86,6), (86,1), (87,1), (87,11), (87,6), (88,1), (89,1), (90,1), (90,11), (90,6), (91,11), (91,6), (91,1), (92,1), (92,6)
		-- Virtual XI
		, (93,1), (93,11), (94,1), (95,2), (95,1), (96,1), (97,2), (97,11), (97,1), (98,1), (99,1), (100,6), (100,11)
		-- Brave New World
		, (101,3), (101,1), (101,4), (102,6), (102,4), (102,1), (103,2), (103,1), (103,4), (104,1), (105,6), (105,1), (106,6), (106,1), (107,3), (107,1), (108,2), (108,1), (109,1), (109,4), (109,1), (110,2), (110,1)
		-- Dance of Death
		, (111,3), (111,1), (112,1), (112,2), (112,4), (113,1), (114,6), (114,1), (114,4), (115,6), (115,1), (116,6), (116,1), (116,4), (117,5), (117,3), (117,4), (118,3), (118,1), (119,3), (119,1), (119,4), (120,2), (120,1), (121,4), (121,1), (121,3)
		-- A Matter of Life and Death
		, (122,3), (122,1), (123,3), (123,1), (123,4), (124,3), (124,1), (124,4), (125,6), (125,1), (126,3), (126,1), (126,4), (127,4), (127,1), (128,2), (128,1), (129,1), (130,3), (130,1), (130,4), (131,1), (131,6)
		-- The Final Frontier
		, (132,3), (132,1), (133,3), (133,1), (133,4), (134,3), (134,1), (135,3), (135,1), (135,4), (136,6), (136,1), (136,4), (137,3), (137,1), (138,3), (138,1), (138,4), (139,6), (139,1), (140,2), (140,1), (141,1)
		-- The Book of Souls
		, (142,4), (143,3), (143,4), (144,3), (144,1), (145,1), (146,3), (146,1), (147,6), (147,1), (148,3), (148,4), (149,6), (149,1), (150,3), (150,1), (151,2), (151,1), (152,4)

