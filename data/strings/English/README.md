so the xml root node structure is like this
each id must be unique, to be reffered in another xml tags, stringtable called usually with tag with double dollar like $$123456$$

here is ID range that already used by DE.
140000-163011 (unithelpstringy.xml)
120000-121052 (unithelpstringx.xml)
100000-100883 (unithelpstrings.xml)
10670-220057 (stringtabley.xml)
50000-54351 (randomnamestrings.xml)

    <stringmods> -> root node
        <StringTable>
            <Language name="English">
                <string _locid="603784">Munir</string>

                # there is also symbol tag, dunno, but maybe to expose string to the xs programming for ai coding.
                <string _locid="212002" symbol="cStringResourceNameFame">Fame</string>
            </Language>
        </StringTable>
    </stringmods>