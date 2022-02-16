from urllib import request
resp = request.urlopen('https://www.google.com')
print(resp.read())
