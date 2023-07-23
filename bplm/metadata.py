from bs4 import BeautifulSoup as bs


def getMetaXmlName() -> list:
    xmlName = []
    with open("metadata.xml","r",encoding="utf-8") as f:
        meta = f.read()
    soup = bs(meta,"xml")
    for m in soup.find_all("metadataObjects"):
        xmlName.append(m.find("xmlName").text)
    return xmlName

def sfdcMetaKeyRepo(key: str) -> str:
    sfdcMetaKeys = {
        'XML_TAG' : '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
        'PACKAGE_START' : '<Package xmlns="http://soap.sforce.com/2006/04/metadata">',
        'PACKAGE_END' : '</Package>',
        'TYPES_START': '<types>',
        'TYPES_END': '</types>',
        'MEMBERS_START': '<members>',
        'MEMBERS_END': '</members>',
        'NAME_START': '<name>',
        'NAME_END': '</name>',
        'VERSION_START': '<version>',
        'VERSION_END': '</version>',
        'VERSION': '57.0'
    }
    return sfdcMetaKeys[key]

def createPackage():
    package = ''
    package += sfdcMetaKeyRepo('XML_TAG')+sfdcMetaKeyRepo('PACKAGE_START')
    for member in getMetaXmlName():
        package += sfdcMetaKeyRepo('TYPES_START')+sfdcMetaKeyRepo('MEMBERS_START')+'*'+sfdcMetaKeyRepo('MEMBERS_END')+sfdcMetaKeyRepo('NAME_START')+member+sfdcMetaKeyRepo('NAME_END')+sfdcMetaKeyRepo('TYPES_END')
    package += sfdcMetaKeyRepo('VERSION_START') + sfdcMetaKeyRepo('VERSION') + sfdcMetaKeyRepo('VERSION_END') + sfdcMetaKeyRepo('PACKAGE_END')
    package += sfdcMetaKeyRepo('PACKAGE_END')
    b = bs(package,"xml")
    package = b.prettify()
    with open("package.xml","w",encoding="utf-8") as f:
        f.write(package)