strIntArray$="1,20,300,4456,5,656,70,9"
'call printStringIntArray strIntArray$
'strIntArray$="1"
'call printStringIntArray strIntArray$
print strIntArray$
dim intArray(10)
arraySize=0
call stringToIntArray strIntArray$, intArray, arraySize
print intArray(1)
call PrintIntArray intArray, arraySize
end
sub printStringIntArray anArray$
    print "string int array: "; anArray$
    newString$=anArray$
    while len(newString$)<>0
        text$ = upto$(newString$,",")
        intVal = val(text$)
        print intVal
        newString$ = after$(newString$,",")
    wend
    print "Done"
end sub
sub stringToIntArray aString$, byref anOutArray, byref anOutArraySize
    print "string int array: "; anArray$
    newString$=aString$
    i=0
    while len(newString$)<>0
        commaPosition = instr(newString$,",")
        text$ = ""
        intVal = 0
        if commaPosition = 0 then
            text$ = newString$
            intVal = val(text$)
            newString$ = ""
        else
            text$=left$(newString$, commaPosition)
            intVal = val(text$)
            newString$ = mid$(newString$, commaPosition+1)
        end if
        i = i+1
        anOutArray(i)=intVal
        print anOutArray(i)
    wend
    anOutArraySize = i
    print "Done"
end sub
sub PrintIntArray anArray, anArraySize
    print "int array:"
    for i=1 to anArraySize
        print anArray(i)
    next i
end sub
