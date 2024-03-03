import sys

import pyperclip
import requests
from bs4 import BeautifulSoup


def get_text_from_url(url):
    try:
        response = requests.get(url)
        response.raise_for_status()  # Check for errors in the HTTP response
    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")
        sys.exit(1)

    soup = BeautifulSoup(response.text, 'html.parser')
    text_content = soup.get_text(separator='\n', strip=True)
    return text_content

def main():
    if len(sys.argv) != 2:
        print("Usage: python script.py <url>")
        sys.exit(1)

    url = sys.argv[1]
    text_content = get_text_from_url(url)

    pyperclip.copy(text_content)
    print("Text content copied to clipboard.")

if __name__ == "__main__":
    main()
