#I am So Sorry for What You Are About to Read... I Have Tried My Best to Put a Comment on Everything but ChatGPT is *redacted*
import os
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import os
import requests
dfrom bs4 import BeautifulSoup
import urllib3
import re  # Added for Better Version Detection
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
os.system("title Linux Downloader")
distributions = {
    #Comment Out the Distributions That Don't Need to be Downloaded
    "Ubuntu": "https://releases.ubuntu.com/",
    "Kali": "https://www.kali.org/get-kali/",
    "Debian": "https://www.debian.org/CD/http-ftp/",
    "Fedora": "https://getfedora.org/en/workstation/download/",
    "Pop!_OS": "https://pop.system76.com/"
}

#Enter Output Directory Here. Raw for Windows Paths
output_dir = r"Y:"

#Create New Directory if the Output Directory Does not Exist
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

# Function to download an ISO for Distributions Other Than Pop!_OS, as it has it's Own Function as Seen Below...
def download_iso(name, url, output_path):
    print(f"Fetching {name} ISO...")
    response = requests.get(url, stream=True)
    if response.status_code == 200:
        with open(output_path, "wb") as file:
            for chunk in response.iter_content(chunk_size=8192):
                file.write(chunk)
        print(f"Downloaded {name} ISO to {output_path}")
    else:
        print(f"Failed to Download {name} ISO. Status Code: {response.status_code}")

#Function to Download Ubuntu
def download_ubuntu():
    try:
        ubuntu_base_url = "https://releases.ubuntu.com/"
        response = requests.get(ubuntu_base_url)
        response.raise_for_status()
        soup = BeautifulSoup(response.text, 'html.parser')
        
        version_pattern = re.compile(r'^\d{2}\.\d{2}/$')
        version_links = [link.get('href').rstrip('/') 
                        for link in soup.find_all('a') 
                        if link.get('href') and version_pattern.match(link.get('href'))]
        
        if not version_links:
            raise ValueError("No Valid Ubuntu Version Links Found")
        
        ubuntu_version = max(version_links)
        ubuntu_iso_url = f"{ubuntu_base_url}{ubuntu_version}/ubuntu-{ubuntu_version}-desktop-amd64.iso"
        print(f"Ubuntu URL: {ubuntu_iso_url}")
        output_path = os.path.join(output_dir, "Ubuntu.iso")
        download_iso("Ubuntu", ubuntu_iso_url, output_path)
        os.system(f'curl -d "Downloaded Ubuntu" ntfy.sh/denby_alerts')
    
    except Exception as e:
        print(f"Failed to Download Ubuntu: {e}")

#Function to Download Debian
def download_debian():
    try:
        debian_url = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/"
        response = requests.get(debian_url)
        response.raise_for_status()
        soup = BeautifulSoup(response.text, 'html.parser')
        
        debian_iso = next(link.get('href') for link in soup.find_all('a') 
                        if link.get('href', '').endswith('-amd64-netinst.iso'))
        debian_iso_url = f"{debian_url}{debian_iso}"
        print(f"Debian URL: {debian_iso_url}")
        output_path = os.path.join(output_dir, "Debian.iso")
        download_iso("Debian", debian_iso_url, output_path)
        os.system(f'curl -d "Downloaded Debian" ntfy.sh/denby_alerts')

    except Exception as e:
        print(f"Failed to Download Debian: {e}")

#Function to Download Pop!_OS (I am so Sorry)
def download_pop_os(output_dir):
    base_url = "https://pop.system76.com/"
    options = webdriver.ChromeOptions()
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    driver = webdriver.Chrome(options=options)
    try:
        driver.get(base_url)

        wait = WebDriverWait(driver, 10)
        download_button = wait.until(EC.element_to_be_clickable((By.XPATH, "//button[contains(text(), 'Download')]")))
        download_button.click()

        iso_link_element = wait.until(
            EC.presence_of_element_located((By.XPATH, "//a[contains(@href, '.iso')]"))
        )
        iso_link = iso_link_element.get_attribute("href")

        os.makedirs(output_dir, exist_ok=True)
        iso_path = os.path.join(output_dir, "Pop!_OS.iso")

        print(f"Downloading Pop!_OS ISO")
        response = requests.get(iso_link, stream=True)
        response.raise_for_status()
        
        with open(iso_path, "wb") as f:
            for chunk in response.iter_content(chunk_size=8192):
                f.write(chunk)

        print(f"Downloaded Pop!_OS ISO to {iso_path}")
        os.system(f'curl -d "Downloaded Pop!_OS" ntfy.sh/denby_alerts')
    except Exception as e:
        print(f"Error Occurred: {e}")
    finally:
        driver.quit()

# Function to Scrape ISO URLs
def get_latest_iso_url(name, url):
    global skip
    skip = 0
    print(f"Scraping {name} Download Page...")
    response = requests.get(url)
    soup = BeautifulSoup(response.text, "html.parser")

    #Ubuntu
    if name == "Ubuntu":
        download_ubuntu()

        #Skips the Other Function to Download Other ISOs as it has Already Been Handled
        skip = 1

    #Kali
    elif name == "Kali":
        iso_url = soup.find("a", href=lambda href: href and "amd64.iso" in href).get("href")
        return iso_url

    #Debian
    elif name == "Debian":
        download_debian()
        
        #Skips the Other Function to Download Other ISOs as it has Already Been Handled
        skip = 1

    #Fedora
    elif name == "Fedora":
        iso_url = soup.find("a", href=lambda href: href and "Workstation-Live-x86_64" in href).get("href")
        return iso_url

    #Pop!_OS
    elif name == "Pop!_OS":
        download_pop_os(output_dir)

        #Skips the Other Function to Download Other ISOs as it has Already Been Handled
        skip = 1

    return None

#Main Function to Download ISOs. Runs if Skip != 1.
if __name__ == "__main__":
    for distro, url in distributions.items():
        try:
            iso_url = get_latest_iso_url(distro, url)
            if skip != 1:
                if iso_url:
                    output_path = os.path.join(output_dir, f"{distro.lower().replace(' ', '_').capitalize()}.iso")
                    download_iso(distro, iso_url, output_path)
                    os.system(f'curl -d "Downloaded {distro}" ntfy.sh/denby_alerts')
                else:
                    print(f"Could Not Find ISO URL for {distro}")
        except Exception as e:
            print(f"Error Processing {distro}: {e}")
