import lxml.etree
tree = lxml.etree.parse("/anvil/projects/tdm/data/otc/valu.xml")
tree.xpath("//ns:*", namespaces = {'ns': 'urn:hl7-org:v3'})[0].tag

for e in tree.xpath("//ns:title", namespaces = {'ns': 'urn:hl7-org:v3'}):
    print(e.text)
    
for e in tree.xpath("//ns:document", namespaces = {'ns': 'urn:hl7-org:v3'}):
    for childelement in e.getchildren():
        print(childelement.text)
        
for e in tree.xpath("//ns:document", namespaces = {'ns': 'urn:hl7-org:v3'}):
    for childelement in e.getchildren():
        print(childelement.attrib)
        
tree.xpath("//ns:*[@codeSystem]", namespaces = {'ns': 'urn:hl7-org:v3'})

for e in tree.xpath("//ns:*[@codeSystem and contains(@displayName, 'DOSAGE')]", namespaces = {'ns': 'urn:hl7-org:v3'}):
    print(e.attrib)
