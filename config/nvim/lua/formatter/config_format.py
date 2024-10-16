from config_formatter import ConfigFormatter
import sys


with open(sys.argv[1], "r") as file:
    formatter = ConfigFormatter()
    formatted = formatter.prettify(file.read())

with open(sys.argv[1], "w") as file:
    file.write(formatted)
