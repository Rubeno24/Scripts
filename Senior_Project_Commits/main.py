from google.oauth2.service_account import Credentials
from googleapiclient.discovery import build
import requests

# GitHub repository URL for commits
url = "https://api.github.com/repos/nalisonia/CtrlALtElite-/commits"

# Google Sheets details
SPREADSHEET_ID = '1M6wKi0fKXUO3SyQT4-TW4FXvaV5qf0l__zVCSbPUrxY'
RANGE_NAME = 'Sheet1!A1:D300'
SERVICE_ACCOUNT_FILE = 'carbon-storm-423621-g5-bbc3150038cf.json'

def authenticate_sheets():
    scopes = ['https://www.googleapis.com/auth/spreadsheets']
    credentials = Credentials.from_service_account_file(SERVICE_ACCOUNT_FILE, scopes=scopes)
    return build('sheets', 'v4', credentials=credentials).spreadsheets()

def write_to_google_sheets(service, spreadsheet_id, range_name, values):
    body = {'values': values}
    result = service.values().update(
        spreadsheetId=spreadsheet_id, range=range_name,
        valueInputOption='RAW', body=body).execute()
    return result

if __name__ == '__main__':
    try:
        # Get the last 75 commits
        params = {"per_page": 100}
        response = requests.get(url, params=params)
        response.raise_for_status()
        data = response.json()

        commits_by_committer = {}  # Dictionary to store commits by committer name

        for commit in data:
            committer_name = commit["commit"]["committer"]["name"]
            commit_number = commit["sha"][:7]
            commit_message = commit["commit"]["message"]
            commit_date = commit["commit"]["committer"]["date"]

            commit_message_cleaned = commit_message.replace('\n', '')

            # If commit message contains special characters, encode it to prevent UnicodeEncodeError
            commit_info = f"Commit Message: {commit_message_cleaned.encode('utf-8', 'ignore').decode('utf-8')}\n"
            commit_info += f"Commit Number: {commit_number}\n"
            commit_info += f"Commit Date: {commit_date}\n"
            commit_info += "---\n"

            if committer_name not in commits_by_committer:
                commits_by_committer[committer_name] = []
        
            commits_by_committer[committer_name].append(commit_info)

        #Remove entries with committer name "GitHub"
        if "GitHub" in commits_by_committer:
            del commits_by_committer["GitHub"]

        with open("commits_by_committer.txt", "w") as file:
            for committer, commits in commits_by_committer.items():
                file.write(f"Commits by: {committer}\n")
                file.write("-" * 30 + "\n")
                for commit in commits:
                    file.write(commit)
                file.write("\n\n")

        print("Commits separated by committer name and written to commits_by_committer.txt file.")

        # Prepare data for Google Sheets
        values = [["Committer", "Commit Message", "Commit Number", "Commit Date"]]
        for committer, commits in commits_by_committer.items():
            for commit in commits:
                lines = commit.split('\n')
                commit_message = lines[0].replace("Commit Message: ", "")
                commit_number = lines[1].replace("Commit Number: ", "")
                commit_date = lines[2].replace("Commit Date: ", "")
                values.append([committer, commit_message, commit_number, commit_date])

        # Write data to Google Sheets
        service = authenticate_sheets()
        result = write_to_google_sheets(service, SPREADSHEET_ID, RANGE_NAME, values)
        print(f"Google Sheets updated: {result}")

    except requests.exceptions.HTTPError as e:
        print(f"Error retrieving data: {e}")
