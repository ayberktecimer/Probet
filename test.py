import sqlite3

connection = sqlite3.connect('db.sqlite3')
cursor = connection.cursor()
cursor.execute(
	"SELECT game_id, start_time, H.league, H.name, A.name, odd_type, odd_amount FROM Odd o NATURAL JOIN Game JOIN Team H JOIN Team A WHERE H.team_id  = home_team_id AND A.team_id = away_team_id;")
games = cursor.fetchall()
gamesAndOdds = {}
for game in games:
	gameId = game[0]
	startTime = game[1]
	league = game[2]
	homeName = game[3]
	awayName = game[4]
	oddType = game[5]
	oddAmount = game[6]

	info = {
		"gameId": gameId,
		"startTime": startTime,
		"league": league,
		"homeName": homeName,
		"awayName": awayName
	}

	if gameId not in gamesAndOdds:
		gamesAndOdds[gameId] = {}
		gamesAndOdds[gameId]["info"] = info
		gamesAndOdds[gameId]["odds"] = {}

	gamesAndOdds[gameId]["odds"][oddType] = oddAmount
