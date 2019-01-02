import json
from django.http import HttpResponse, HttpResponseRedirect, JsonResponse
from django.shortcuts import render
from datetime import datetime
import sqlite3
import itertools


def index(request):
	if 'tckn' in request.session:
		print("We have a user here: " + request.session['tckn'])
	if request.method == "POST":
		post = request.POST
		tckn = post["tckn"]
		password = post["password"]
		connection = sqlite3.connect('db.sqlite3')
		cursor = connection.cursor()
		parameters = [tckn, password]
		cursor.execute("SELECT customer_id FROM Customer WHERE customer_id=? AND password=?", parameters)
		auth = cursor.fetchone()
		cursor.execute("SELECT * FROM Editor WHERE editor_id=?", [tckn])
		checkEditor = cursor.fetchone()

		if auth:
			request.session['tckn'] = tckn
		if checkEditor:
			request.session['isEditor'] = True

		return HttpResponseRedirect("/")

	else:
		# Get all teams from db
		connection = sqlite3.connect('db.sqlite3')
		cursor = connection.cursor()
		cursor.execute("SELECT customer_id, first_name, pmessage FROM Post NATURAL JOIN Customer")
		postList = cursor.fetchall()

		context = {
			"postList": postList,
			"gamesAndOdds": getGamesAndOdds()
		}

		connection.close()
		return render(request, 'frontend/index.html', context)


def signup(request):
	if request.method == "POST":  # User registration
		connection = sqlite3.connect('db.sqlite3')
		cursor = connection.cursor()

		post = request.POST
		parameters = [post['tckn'], post['name'], post['lastname'], post['email'], post['pass'], post['birthdate']]

		try:
			cursor.execute("INSERT INTO Customer VALUES (?, NULL, NULL, NULL, ?, ?, ?, ?, NULL, 0, ?)", parameters)
		except sqlite3.IntegrityError:
			return HttpResponse("TCKN already exists!", status=409)

		connection.commit()
		connection.close()
		return HttpResponse("congrats, you are signed up <a href='/'>Sign in</a>")

	else:  # GET request
		return render(request, "frontend/signup.html")


def signout(request):
	request.session.flush()
	return HttpResponseRedirect("/")


def teams(request):
	if "id" in request.GET:
		teamId = request.GET["id"]
		connection = sqlite3.connect('db.sqlite3')
		cursor = connection.cursor()
		cursor.execute("SELECT * FROM Team WHERE team_id=?", [teamId])
		team = cursor.fetchone()

		if team is None:
			return HttpResponseRedirect("https://media.giphy.com/media/9SJazLPHLS8roFZMwZ/giphy.gif")

		context = {
			"team": team
		}

		connection.commit()  # Required for updating things
		connection.close()
		return render(request, "frontend/team.html", context)
	else:
		connection = sqlite3.connect('db.sqlite3')
		cursor = connection.cursor()
		cursor.execute("SELECT * FROM Team")
		teamList = cursor.fetchall()

		context = {
			"teamList": teamList
		}
		connection.commit()  # Required for updating things
		connection.close()
		return render(request, "frontend/allTeams.html", context)


def customers(request):
	userId = request.GET["id"]
	connection = sqlite3.connect('db.sqlite3')
	cursor = connection.cursor()
	cursor.execute("SELECT * FROM Customer WHERE customer_id=?",
				   [userId])  # https://stackoverflow.com/a/16856730/5964489
	customer = cursor.fetchone()

	cursor.execute(
		"SELECT home.name, away.name, odd_type,odd_amount FROM Odd NATURAL JOIN Game INNER JOIN Team home ON home.team_id=home_team_id INNER JOIN Team away ON away.team_id=away_team_id NATURAL JOIN INCLUDES NATURAL JOIN BetSlip WHERE customer_id = ? AND status = 'waiting' ",
		[userId])
	get_current_slip = cursor.fetchall()

	cursor.execute(
		"SELECT home.name, away.name, odd_type, odd_amount FROM Odd NATURAL JOIN Game INNER JOIN Team home ON home.team_id=home_team_id INNER JOIN Team away ON away.team_id=away_team_id NATURAL JOIN INCLUDES NATURAL JOIN BetSlip WHERE customer_id = ? AND status != 'waiting' ",
		[userId])
	get_old_slip = cursor.fetchall()
	if customer is None:
		return HttpResponseRedirect("https://media.giphy.com/media/9SJazLPHLS8roFZMwZ/giphy.gif")

	cursor.execute(
		"SELECT customer2_id, first_name FROM Follows INNER JOIN Customer ON Follows.customer2_id = Customer.customer_id WHERE Follows.customer_id=?",
		[userId])
	followingList = cursor.fetchall()
	cursor.execute("SELECT customer_id, first_name FROM Follows NATURAL JOIN Customer WHERE customer2_id=?", [userId])
	followersList = cursor.fetchall()

	if 'tckn' in request.session and request.session['tckn'] == userId:
		followingStatus = 2  # User views her own page

	elif 'tckn' in request.session:
		cursor.execute("SELECT * FROM Follows WHERE customer_id=? AND customer2_id=?",
					   [request.session['tckn'], userId])
		if cursor.fetchone():
			followingStatus = 1  # User views a profile that is already following
		else:
			followingStatus = 0
	else:
		followingStatus = 0  # User views a stranger

	cursor.execute(uninterestedLeaguesSql(), [userId, userId])
	uninterestedLeagues = cursor.fetchall()

	context = {
		"customer": customer,
		"current_slip": get_current_slip,
		"old_slip": get_old_slip,
		"following": followingList,
		"followers": followersList,
		"followingStatus": followingStatus,
		"uninterestedLeagues": uninterestedLeagues
	}

	connection.commit()  # Required for updating things
	connection.close()
	return render(request, "frontend/profile.html", context)


def follow(request):
	if 'tckn' not in request.session:
		return HttpResponseRedirect("/")  # Unauthorized user
	else:
		loggedInUserId = request.session['tckn']
		desiredUserId = request.GET['id']
		connection = sqlite3.connect('db.sqlite3')
		cursor = connection.cursor()

		cursor.execute("INSERT INTO Follows VALUES (?,?)", [loggedInUserId, desiredUserId])

		connection.commit()  # Required for updating things
		connection.close()
		return HttpResponseRedirect("/customers/?id=" + desiredUserId)


def unfollow(request):
	if 'tckn' not in request.session:
		return HttpResponseRedirect("/")  # Unauthorized user
	else:
		loggedInUserId = request.session['tckn']
		unwantedUserId = request.GET['id']
		connection = sqlite3.connect('db.sqlite3')
		cursor = connection.cursor()

		cursor.execute("DELETE FROM Follows WHERE customer_id=? AND customer2_id=?", [loggedInUserId, unwantedUserId])

		connection.commit()  # Required for updating things
		connection.close()
		return HttpResponseRedirect("/customers/?id=" + unwantedUserId)


def suggestion(request):
	connection = sqlite3.connect('db.sqlite3')
	cursor = connection.cursor()
	cursor.execute(
		"SELECT game_id, editor_id, text FROM Suggestion NATURAL JOIN Suggests")  # TODO: game details can be added with joins
	suggestionList = cursor.fetchall()
	context = {
		"suggestionList": suggestionList
	}
	connection.commit()  # Required for updating things
	connection.close()
	return render(request, "frontend/allSuggestions.html", context)


def writeSuggestion(request):
	if 'isEditor' not in request.session:
		return HttpResponse("Only editors can write suggestions")
	elif request.POST:
		form = request.POST
		editorId = request.session['tckn']
		gameId = form['gameID']
		suggestion = form['suggestion']

		connection = sqlite3.connect('db.sqlite3')
		cursor = connection.cursor()
		cursor.execute("INSERT INTO Suggestion VALUES (NULL, ?, current_date)", [suggestion])
		cursor.execute("INSERT INTO Suggests VALUES (?, last_insert_rowid(), ?)", [gameId, editorId])
		connection.commit()  # Required for updating things
		connection.close()
		return HttpResponseRedirect("/suggestions")

	else:
		return render(request, "frontend/writeSuggestion.html")


def convertTimeStamp(timestamp):
	return datetime.utcfromtimestamp(timestamp).strftime('%d.%m.%Y %H:%M')


def getGamesAndOdds():
	connection = sqlite3.connect('db.sqlite3')
	cursor = connection.cursor()
	cursor.execute(
		"SELECT game_id, start_time, H.league, H.name, A.name, odd_type, odd_amount FROM Odd o NATURAL JOIN Game JOIN Team H JOIN Team A WHERE H.team_id  = home_team_id AND A.team_id = away_team_id;")
	games = cursor.fetchall()
	gamesAndOdds = {}
	for game in games:
		gameId = game[0]
		startTime = convertTimeStamp(game[1])
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

	return gamesAndOdds


def createBetSlip(request):
	slip = json.loads(request.body.decode("utf-8"))

	if 'customerId' not in slip or slip['customerId'] is None:
		return HttpResponse(status=403)
	else:
		customerId = slip['customerId']
		betAmount = slip['betAmount']
		games = slip['games']
		numberOfGames = len(games)

		connection = sqlite3.connect('db.sqlite3')
		cursor = connection.cursor()
		cursor.execute("INSERT INTO BetSlip VALUES (NULL, ?, ?, ?, current_date, 'waiting');",
					   [customerId, betAmount, numberOfGames])

		for game in games:
			cursor.execute("INSERT INTO Includes VALUES (?, ?, ?, last_insert_rowid());",
						   [game['gameId'], game['oddType'], customerId])

		connection.commit()
		connection.close()

		return HttpResponse(status=200)


def sa(request):
	return HttpResponse("as")


def pdfReports(request):
	return HttpResponseRedirect("http://emre.sulun.ug.bilkent.edu.tr/cs353")


def socialbetting(request):
	connection = sqlite3.connect('db.sqlite3')
	cursor = connection.cursor()
	cursor.execute("SELECT * FROM Post NATURAL JOIN Customer")
	posts = cursor.fetchall()
	cursor.execute(
		"SELECT COUNT(*) FROM Post INNER JOIN Post_like ON Post.post_id = Post_like.post_id GROUP BY Post.post_id")
	likeCount = cursor.fetchall()
	mylist = itertools.zip_longest(posts, likeCount)
	context = {
		"posts": mylist
	}

	connection.close()
	return render(request, "frontend/mainSocialPage.html", context)


def searchCustomer(request):
	minRank = request.GET['minRank']
	maxRank = request.GET['maxRank']

	connection = sqlite3.connect('db.sqlite3')
	cursor = connection.cursor()
	cursor.execute("SELECT first_name, last_name, profile_pic, customer_id FROM Customer WHERE rank >= ? AND rank <= ?",
				   [minRank, maxRank])

	sqlResults = cursor.fetchall()

	resultList = []
	for customer in sqlResults:
		resultList.append({
			'id': customer[3],
			'firstName': customer[0]
		})

	connection.close()
	return JsonResponse(resultList, safe=False)


def uninterestedLeaguesSql():
	return "WITH customerAndFriends AS (SELECT customer2_id AS customer_id FROM Follows " \
		   "WHERE customer_id = ? UNION SELECT customer_id FROM Customer " \
		   "WHERE customer_id = ?), playedLeagues AS (SELECT DISTINCT H.league " \
		   "FROM (customerAndFriends NATURAL JOIN Includes NATURAL JOIN Game " \
		   "INNER JOIN Team H ON H.team_id = game.home_team_id INNER JOIN Team A " \
		   "ON A.team_id = Game.away_team_id)) SELECT DISTINCT league FROM Team WHERE league NOT IN playedLeagues"
