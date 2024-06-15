import random

string = "oskarmeyenburg"
length = 5
iterations = 25

for i in range(iterations):
    s = string
    result = ""
    for i in range(length):
        j = random.randint(0, len(s)-1)
        result += s[j]
        s = s[:j] + s[j+1:]
    print(result)

outputs = """
oyaru
omare
moray
muoke <
kuoba
osmeu
omare
eosur
mysen
guear
guese
seoyu
mayeo
sayego
gebrao
grakey
krybos / krybus <
"""
