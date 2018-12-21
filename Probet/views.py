from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render
import sqlite3


def index(request):
	# Get all teams from db
	connection = sqlite3.connect('db.sqlite3')
	cursor = connection.cursor()
	cursor.execute("SELECT customer_id, first_name, pmessage FROM Post NATURAL JOIN Customer")
	postList = cursor.fetchall()

	context = {
		"postList": postList
	}

	connection.close()
	return render(request, 'frontend/index.html', context)


def signup(request):
	return render(request, "frontend/signup.html")


def teams(request):
	# Get all teams from db
	connection = sqlite3.connect('db.sqlite3')
	cursor = connection.cursor()
	cursor.execute("SELECT * FROM Team")
	teamList = cursor.fetchall()

	context = {
		"teamList": teamList
	}

	connection.commit()  # Required for updating things
	connection.close()
	return render(request, "frontend/test-teams.html", context)


def customers(request):
	userId = request.GET["id"]
	connection = sqlite3.connect('db.sqlite3')
	cursor = connection.cursor()
	cursor.execute("SELECT * FROM Customer WHERE customer_id=?", userId)
	customer = cursor.fetchone()

	if customer is None:
		return HttpResponseRedirect("https://media.giphy.com/media/9SJazLPHLS8roFZMwZ/giphy.gif")

	context = {
		"customer": customer
	}

	connection.commit()  # Required for updating things
	connection.close()
	return render(request, "frontend/profile.html", context)


def sa(request):
	return HttpResponse("as")


def pdfReports(request):
	return HttpResponseRedirect("http://emre.sulun.ug.bilkent.edu.tr/cs353")
