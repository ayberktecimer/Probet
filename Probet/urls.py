"""Probet URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.9/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url
from django.contrib import admin

from .views import sa
from .views import index
from .views import signup
from .views import pdfReports
from .views import teams
from .views import customers
from .views import signout
from .views import follow
from .views import unfollow
from .views import suggestion
from .views import writeSuggestion
from .views import createBetSlip
from .views import socialbetting
from .views import searchCustomer
from .views import updateprofile
from .views import postlike
from .views import postcomment

urlpatterns = [
	url(r'^sa$', sa),
	url(r'^admin', admin.site.urls),
	url(r'^signup', signup),
	url(r'^teams', teams),
	url(r'^customers/follow', follow),
	url(r'^customers/unfollow', unfollow),
	url(r'^customers/', customers),
	url(r'^pdf-reports', pdfReports),
	url(r'^signout', signout),
	url(r'^suggestions/new', writeSuggestion),
	url(r'^suggestions', suggestion),
	url(r'^slips/new', createBetSlip),
	url(r'^mainsocialpage', socialbetting),
	url(r'^searchCustomer', searchCustomer),
	url(r'^posts/like', postlike),
	url(r'^comment/new', postcomment),
	url(r'^updateprofilepage',updateprofile),
	url(r'', index)
]
