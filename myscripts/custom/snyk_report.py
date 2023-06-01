#!/usr/bin/env python
from bs4 import BeautifulSoup
import requests
newFile = open('snyk.report', 'w')

def main():
    with open('snyk.output') as f:
        for line in f:
            r = requests.get(line)
            text = r.text
            soup = BeautifulSoup(text, 'html.parser')
            attrs = soup.find_all('span', class_="vue--badge__text")
            attrsP = soup.find_all('p')
            advice = attrsP[2].text.strip()
            if check_advice(advice):
               status = check_status(attrs)
               output = "%s | %s | %s" %(status, advice, line)
               newFile.write(output)
               print(output)


def check_advice(string):
    # Only patchable
    if ("Upgrade" in string):
        return True

def check_status(blob):
    collection = []
    for item in blob:
        item = item.text.strip()
        collection.append(item)

    if ("low" in collection):
        return "Low"
    elif ("critical" in collection):
        return "Critical"
    elif ("high" in collection):
        return "High"
    else:
        return "Medium"

main()
newFile.close()
