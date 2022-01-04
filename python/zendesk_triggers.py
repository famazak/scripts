import json
import csv

# random script for parsing some info out of Zendesk triggers data
# https://developer.zendesk.com/api-reference/ticketing/business-rules/triggers/

with open("/Volumes/GoogleDrive/Shared drives/analytics/data/zendesk_triggers.json", "r") as json_file:
    data = json.load(json_file)
    triggers = data["triggers"]

outfile = open("/Volumes/GoogleDrive/Shared drives/analytics/data/out/zendesk_triggers.csv", "w")
csv_file = csv.writer(outfile)
csv_file.writerow(['id', 'title', 'active', 'condition_field', 'condition_value'])
for t in triggers:
    for f in t["conditions"]["any"]:
        id = t["id"]
        title = t["title"]
        active = t["active"]
        field = f["field"]
        brand_id = f["value"]
        csv_file.writerow([id, title, active, field, brand_id])
