import webbrowser
import subprocess
# method that will accept a url and call the built in python code to open said url
def open_browser(url):
    webbrowser.open(url)

# this method will take the path to a program and try to open it
def open_program(program_path,folderPath): 
    try:
        subprocess.Popen([program_path, folderPath])       
    except Exception as e:
        print(f"Error opening the program: {e}")

# This code block will only run if the script is executed directly
if __name__ == "__main__":
    # Urls we want to open that will be passed to openBrowser method
    githubUrl = "https://github.com/Rubeno24?tab=repositories"
    chatGptUrl = "https://chat.openai.com/"
    leetcode75 = "https://leetcode.com/studyplan/leetcode-75/"

    # Pass in the url we want to open to that method
    open_browser(leetcode75)
    open_browser(chatGptUrl)
    open_browser(githubUrl)

    # The path to VS Code
    program_path_to_open = r"C:\Users\Ruben Ortega\AppData\Local\Programs\Microsoft VS Code\Code.exe"

    # Path to the folder where our leet code is
    folderPath = r"C:\Users\Ruben Ortega\OneDrive - California State University, Sacramento\Desktop\Leetcode"
    open_program(program_path_to_open,folderPath)

