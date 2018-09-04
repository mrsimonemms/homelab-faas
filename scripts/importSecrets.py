import os
from subprocess import call
from yaml import load

file = open("./secrets.yml", "r")

doc = load(file.read())

for name in doc:
  value = doc[name]

  print(str(name) + "=" + str(value))

  os.environ["NAME"] = str(name)
  os.environ["VALUE"] = str(value)

  call([
    "make",
    "destroy-secret"
  ])

  call([
    "make",
    "secret"
  ])
