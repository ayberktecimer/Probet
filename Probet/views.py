from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render
import sqlite3


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

		cursor2 = connection.cursor()
		cursor2.execute(
			"SELECT H.name, A.name, odd_amount FROM Odd o NATURAL JOIN Game JOIN Team H JOIN Team A Where H.team_id  = home_team_id AND A.team_id = away_team_id AND EXISTS (SELECT odd_amount  FROM Odd o1 WHERE o.odd_type = o1.odd_type AND odd_type = 'MS0' AND o.odd_amount IS NOT NULL)")
		gameList = cursor2.fetchall()

		context = {
			"postList": postList,
			"gameList": gameList
		}

		connection.close()
		return render(request, 'frontend/index.html', context)


def signup(request):
	if request.method == "POST":  # User registration
		connection = sqlite3.connect('db.sqlite3')
		cursor = connection.cursor()

		post = request.POST
		parameters = [post['tckn'], post['name'], post['lastname'], post['email'], post['pass'], post['birthdate']]

		cursor.execute("INSERT INTO Customer VALUES (?, NULL, NULL, NULL, ?, ?, ?, ?, NULL, 0, ?)", parameters)

		connection.commit()
		connection.close()
		return HttpResponse("congrats, you are signed up")

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
	# ID düzeltilecek hep 1 veriyoz, front end kısmında kupon id, ve status
	cursor.execute(
		"SELECT home.name, away.name, odd_type,odd_amount FROM Odd NATURAL JOIN Game INNER JOIN Team home ON home.team_id=home_team_id INNER JOIN Team away ON away.team_id=away_team_id NATURAL JOIN INCLUDES NATURAL JOIN BetSlip WHERE customer_id = 1 AND status = 'waiting' ")
	get_current_slip = cursor.fetchall()

	cursor.execute(
		"SELECT home.name, away.name, odd_type, odd_amount FROM Odd NATURAL JOIN Game INNER JOIN Team home ON home.team_id=home_team_id INNER JOIN Team away ON away.team_id=away_team_id NATURAL JOIN INCLUDES NATURAL JOIN BetSlip WHERE customer_id = 1 AND status != 'waiting' ")
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

	context = {
		"customer": customer,
		"current_slip": get_current_slip,
		"old_slip": get_old_slip,
		"following": followingList,
		"followers": followersList,
		"followingStatus": followingStatus
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


def sa(request):
	return HttpResponse("as")


def pdfReports(request):
	return HttpResponseRedirect("http://emre.sulun.ug.bilkent.edu.tr/cs353")
