import subprocess
import sys
import os

length = 5
format = "%s\t%an\t%as\t(%ar)"
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

# Set git output language
os.environ["LANG"] = "en_GB"

# Run git log command and capture output
try:
    result = subprocess.run(command, capture_output=True, text=True, check=True)
except subprocess.CalledProcessError as e:
    print("An error occurred: " + e)
    sys.exit(1)

lines = list(filter(len, result.stdout.splitlines()))

commits = []
for line in lines:
    if line:
        if line[0].strip():
            commits.append(line.split("\t"))
        else:
            commits[-1].append(line.strip())

# Extract commits
num_values = format.count("\n") + 2
length = len(commits)

# Calculate column length
columns = list(map(max, zip(*[map(len, c + [""]) for c in commits])))

# Print commit history
for commit in commits:
    output = ""

    for i, (value, length) in enumerate(zip(commit, columns)):
        if i == 2:
            # Format date
            year, month, day = value.split("-")
            output += day + "." + month + "." + year
            output += " " * (length + 1 - len(value))
        elif i == 4:
            # Format changes
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
