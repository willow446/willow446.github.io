# main.py
import sys
from bs4 import BeautifulSoup

def replace_tag(src, overwrite):
    with open(src) as src_p:
        src_soup = BeautifulSoup(src_p, 'html.parser')
        with open(overwrite) as overwrite_p:
            ow_soup = BeautifulSoup(overwrite_p, 'html.parser')
            for child in ow_soup.children:
                c_id = child['id']
                c_name = child.name
                target_tag = src_soup.find(id=c_id)
                target_tag.replace_with(child)
                with open(src, "w") as output:
                    output.write(str(src_soup))
                

if __name__ == "__main__":
    replace_tag(sys.argv[1], sys.argv[2])