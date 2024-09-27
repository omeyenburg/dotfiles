import sys
import subprocess

length = 5
format = "%s\n%an\n%as\n(%ar)"
separator = " | "

command = [
    "git",
    "log",
    "-n",
    str(length),
    "--pretty=format:" + format,
    "--shortstat",
    *sys.argv[1:],
]

try:
    result = subprocess.run(command, capture_output=True, text=True, check=True)
    lines = list(map(str.strip, result.stdout.replace("\n\n", "\n").splitlines()))

    num_values = format.count("\n") + 2
    length = len(lines) // num_values

    commits = [lines[i * num_values : (i + 1) * num_values] for i in range(length)]
    lengths = list(map(max, zip(*[map(len, c) for c in commits])))

    for commit in commits:
        output = ""
        components = []

        for i, (value, length) in enumerate(zip(commit, lengths)):
            if i == 2:
                year, month, day = value.split("-")
                output += day + "." + month + "." + year
                output += " " * (length + 1 - len(value))
            elif i == 4:
                files, *parts = value.split(", ")
                output += files
                if parts:
                    tup = []
                    for part in parts:
                        if "ins" in part:
                            tup.append("+" + part.split()[0])
                        else:
                            tup.append("-" + part.split()[0])
                    output += " (" + ", ".join(tup) + ")"

            else:
                output += value
                output += " " * (length - len(value))
                output += separator

        print(output.strip())
except subprocess.CalledProcessError as e:
    print("An error occurred: " + e)
