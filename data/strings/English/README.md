so the xml root node structure is like this
each id must be unique, to be reffered in another xml tags, stringtable called usually with tag with double dollar like $$123456$$

<stringmods>
    <StringTable>
        <Language name="English">
            <string _locid="603784">Munir</string>

            there is also symbol tag, dunno, but maybe to expose string to the xs programming for ai coding.
            <string _locid="212002" symbol="cStringResourceNameFame">Fame</string>
        </Language>
    </StringTable>
</stringmods>