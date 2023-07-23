from metadata import createPackage
from os import path

def test_createpackage():
    createPackage()
    assert(path.exists("package.xml") == True)