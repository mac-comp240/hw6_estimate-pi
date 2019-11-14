# Author: Preston Locke

from __future__ import print_function
from googleapiclient.discovery import build
from httplib2 import Http
from oauth2client import file, client, tools
from sys import argv

# Define the permissions to request for this program
# If modifying these scopes, delete the file token.json.
SCOPES = 'https://www.googleapis.com/auth/spreadsheets'

def main():
    if len(argv) != 5:
        return
    
    valuesFile = argv[1]
    testCount = argv[2]
    spreadsheetId = argv[3]
    targetRange = argv[4] # TODO: Maybe just change to a constant

    argv.pop()
    argv.pop()
    argv.pop()
    argv[1] = "--noauth_local_webserver"

    # The file token.json stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    store = file.Storage('token.json')
    creds = store.get()
    if not creds or creds.invalid:
        flow = client.flow_from_clientsecrets('client_id.json', SCOPES)
        args = tools.argparser.parse_args()
        args.noauth_local_webserver = True # Don't open a browser
        creds = tools.run_flow(flow, store, args)

    # Retrieve the Sheets API
    sheet = build('sheets', 'v4', http=creds.authorize(Http())).spreadsheets()

    # Retrieve the values from file
    cols = []
    with open(valuesFile) as f:
        # Each line represents a column on the spreadsheet
        for line in f.readlines():
            values = line.split(' ') # Values are space-separated
            column = []
            for i in range(len(values)):
                # Skip the cells that calculate the Median
                if (i % testCount) == 0 and i != 0:
                    column.append(None)
                if values[i] != '\n':
                    column.append(values[i])
            cols.append(column)
    
    requestBody = {'values': cols, 'majorDimension': 'COLUMNS'}

    sheet.values().update(
        spreadsheetId=spreadsheetId,
        range=targetRange,
        valueInputOption='USER_ENTERED',
        body=requestBody
        ).execute()


if __name__ == '__main__':
    main()
