import requests
from bs4 import BeautifulSoup
import re
import tkinter as tk
from tkinter import messagebox as msgbox

# created by Kassandra LLC - May 21, 2023

# Precompile the regular expression
updated_re = re.compile('Updated')

def get_pricing_info():
    url = 'https://www.stuffrecycling.com/pricing'
    response = requests.get(url)
    soup = BeautifulSoup(response.content, 'lxml')
    title = "*** COPPER & COIL PRICES (per lb) ***"

    # Look for the first h3 tag within a blockquote
    updated_text = soup.find('blockquote').find('h3')
    if updated_text:
        date = updated_text.text.strip()  # Extract the date
    else:
        date = "Date not found"

    # Find the copper section
    copper_section = soup.find(string='Copper (per lb)').find_next('p')

    # Extract the desired items and their prices
    items = ['Bare Bright', 'Copper #1', 'Copper #2', 'CU/AL Radiators Clean', 'CU/AL Radiators Unclean']
    pricing_info = {item: None for item in items}

    for line in copper_section.stripped_strings:
        for item in items:
            if line.startswith(item):
                pricing_info[item] = line.split(' - ')[-1].strip('$')
    return "*** COPPER & COIL PRICES (per lb) ***\n\n" + "✓ Prices Last " + date, pricing_info
   
   
def display_pricing_info():
    date, pricing_info = get_pricing_info()
    msg = f"{date}\n\n"
    for item, price in pricing_info.items():
        msg += f"{price}\n\n"
    msgbox.showinfo("What is Stuff paying?", msg)
    
if __name__ == "__main__":
    root = tk.Tk()
    root.withdraw()

    display_pricing_info()
