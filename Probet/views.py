from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render
import sqlite3


def index(request):
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
    return render(request, "frontend/signup.html")


def teams(request):
    # Get all teams from db
    teamId = request.GET["id"]
    connection = sqlite3.connect('db.sqlite3')
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM Team WHERE team_id=?", teamId)
    team = cursor.fetchone()

    if team is None:
        return HttpResponseRedirect("https://media.giphy.com/media/9SJazLPHLS8roFZMwZ/giphy.gif")

    context = {
        "team": team
    }

    connection.commit()  # Required for updating things
    connection.close()
    return render(request, "frontend/team.html", context)


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
