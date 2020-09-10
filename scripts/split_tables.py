#!/usr/bin/env python3
import sys

lines = []
for line in sys.stdin:
    lines.append(line.strip())

nlines = len(lines)
steps = nlines - 4 + 1

i = 0
while i < steps:
    p1, p2, p3, p4 = lines[i], lines[i+1], lines[i+2], lines[i+3]
    if len(p1)>0 and p1[0]=="|":
        if len(p4)>0 and p4[0]=="|":
            if p2=="" and p3=="":
                lines.insert(i+2, '<br />')
                nlines += 1
                steps += 1
    i += 1

print("\n".join(lines))

