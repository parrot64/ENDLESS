' initialize randomizer, if dont use this function, rnd will always return the same sequence of numbers
rndSeed = time$("seconds") / 86400
randomize rndSeed
' Item Variables
global ItemsSize
ItemsSize = 8 ' this variable should contain total number of all items
global ArmorsSize
ArmorsSize = 4
global WeaponsSize
WeaponsSize = 4
' Player Variables
PlayerGuesses=0
PlayerInputNum=0
global PlayerCurrentHealth
global PlayerMaxHealth
global PlayerLevel
global PlayerKills
global PlayerXP
global PlayerGold
global PlayerCurrentArmor ' an index of current player armor from armors array
global PlayerCurrentWeapon ' an index of current player weapon from weapons array
global PlayerVitality
global PlayerStrength
global PlayerAgility
call initPlayerVariables
' this is an array of items quatities. it has the same size as ItemsSize, the items in this array is quantities of items in player inventory
global PlayerInventoryItemsQuantities
call initPlayerInventory
' Dummy Variables
global DummySpare
global DummyHappy
global DummyName$
global DummyDialogue$
global DummyHealth
global DummyGold
global DummyLevel
global DummyVitality
global DummyStrength
global DummyAgility
global DummyXP
' Game Variables
Num=0'for random miscalenius thing
RandomAns=0
GameRound=1
global strangerDiscovered
strangerDiscovered=0
global castleDiscovered
castleDiscovered=0
global gameFinish
gameFinish=0
'round loop
PRINT " __         __        __   __   __ "
PRINT "|_   |\ |  |  \  |   |_   (_   (_  "
PRINT "|__  | \|  |__/  |__ |__  __)  __) "
CALL waitMilliseconds 300
PRINT " "
PRINT "CREDITS TO:"
PRINT "David Vidal Garcia"
PRINT "Play-Testing"
PRINT " "
CALL waitMilliseconds 300
PRINT "Danil Korotenko Pavlo"
PRINT "Programing help"
PRINT " "
CALL waitMilliseconds 300
PRINT "Anton Korotenko Danilovich"
PRINT "Lead Programer"
CALL waitMilliseconds 1000
do
    print
    print "you are in a forest."
    seeDummy=0
    seeBushes = 0
    if (randInRange(0, 100) < 20) then
        randomDummy=randInRange(1,7)
        call generateDummy randomDummy
        print "You see "; DummyName$; " Is walking around."
        seeDummy=1
    else
        if (randInRange(0, 100) < 20) then
            print "You are near some bushes."
            seeBushes = 1
        else
            if (randInRange(0, 100) < 20) and (castleDiscovered =0) then
                print "You are near ancient castle."
                castleDiscovered = 1
            else
                if (randInRange(0, 100) < 20) and (strangerDiscovered =0) then
                    print "You meet the stranger."
                    strangerDiscovered=1
                end if
            end if
        end if
    end if
    print "Choose what to do:"
    print "1. walk around"
    print "2. Go to trader"
    print "3. Info about me"
    print "4. Save"
    print "5. Load"
    if (seeDummy=1) then
        print "6. Attack "; DummyName$
    end if

    if (seeBushes = 1) then
        print "7. Search in bushes"
    end if
    if (castleDiscovered = 1) then
        print "8. Go to castle"
    end if
    if (strangerDiscovered = 1) then
        print "9. Go to stranger and talk to him"
    end if
    input "Action choice:"; actionChoice
    SELECT CASE actionChoice
        CASE 1
            PRINT "You walked around a bit."
        CASE 2
            call SHOP
        CASE 3
            call MyInfo
        CASE 4
OPEN "C:\Users\Public\Documents\save_file.txt" FOR OUTPUT AS #1
PRINT #1, ItemsSize
PRINT #1, ArmorsSize
PRINT #1, WeaponsSize
PRINT #1, PlayerCurrentHealth
PRINT #1, PlayerMaxHealth
PRINT #1, PlayerLevel
PRINT #1, PlayerXP
PRINT #1, PlayerGold
PRINT #1, PlayerCurrentArmor
PRINT #1, PlayerCurrentWeapon
PRINT #1, PlayerVitality
PRINT #1, PlayerStrength
PRINT #1, PlayerAgility
PRINT #1, PlayerInventoryItemsQuantities
PRINT #1, DummySpare
PRINT #1, DummyHappy
PRINT #1, DummyName$
PRINT #1, DummyDialogue$
PRINT #1, DummyHealth
PRINT #1, DummyGold
PRINT #1, DummyLevel
PRINT #1, DummyVitality
PRINT #1, DummyStrength
PRINT #1, DummyAgility
PRINT #1, DummyXP
PRINT #1, strangerDiscovered
PRINT #1, castleDiscovered
PRINT #1, gameFinish
PRINT #1, PlayerKills
CLOSE #1
        CASE 5
OPEN "C:\Users\Public\Documents\save_file.txt" FOR INPUT AS #1
INPUT #1, ItemsSize
INPUT #1, ArmorsSize
INPUT #1, WeaponsSize
INPUT #1, PlayerCurrentHealth
INPUT #1, PlayerMaxHealth
INPUT #1, PlayerLevel
INPUT #1, PlayerXP
INPUT #1, PlayerGold
INPUT #1, PlayerCurrentArmor
INPUT #1, PlayerCurrentWeapon
INPUT #1, PlayerVitality
INPUT #1, PlayerStrength
INPUT #1, PlayerAgility
INPUT #1, PlayerInventoryItemsQuantities
INPUT #1, DummySpare
INPUT #1, DummyHappy
INPUT #1, DummyName$
INPUT #1, DummyDialogue$
INPUT #1, DummyHealth
INPUT #1, DummyGold
INPUT #1, DummyLevel
INPUT #1, DummyVitality
INPUT #1, DummyStrength
INPUT #1, ummyAgility
INPUT #1, DummyXP
INPUT #1, strangerDiscovered
INPUT #1, castleDiscovered
INPUT #1, gameFinish
INPUT #1, PlayerKills
CLOSE #1
        CASE 6
            if (seeDummy=1) then
                call BATTLE
            end if
        case 7
            if (seeBushes = 1) then
                call SEARCHINBUSHES
            end if
        case 8
            if (castleDiscovered = 1) then
                call CASTLE
            end if
        case 9
            if (strangerDiscovered = 1) then
                call STRANGER
            end if
        CASE ELSE
            PRINT "You walked around a bit."
    END SELECT
    if (gameFinish=1) then
        exit do
    end if
    if PlayerCurrentHealth <= 0 then
        exit do
    end if
LOOP UNTIL TRUE
END
' SUBROUTINES AREA /////////////////////////////////////////////
sub initPlayerVariables
    ' initial values of player variables
    PlayerVitality = 1
    PlayerStrength = 2
    PlayerAgility = 1
    PlayerMaxHealth = calculateMaxHP(PlayerVitality, PlayerStrength)
    PlayerCurrentHealth = PlayerMaxHealth
    PlayerLevel=1
    PlayerXP = 0
    PlayerGold = 0
    PlayerCurrentArmor = 1 'Bandage
    PlayerCurrentWeapon = 1 'Stick
end sub
sub generateDummy aDummyIndex
    DummyNames$(1) = "Temmie"
    DummySpares(1) = 1
    DummyHappys(1) = 1
    DummyDialogues$(1) = "Halo humen!"
    DummyVitalities(1) = 2
    DummyStrengths(1) = 1
    DummyAgilities(1) = 0
    DummyNames$(2) = "Froggit"
    DummySpares(2) = 1
    DummyHappys(2) = 1
    DummyDialogues$(2) = "Ribbit,Ribbit"
    DummyVitalities(2) = 1
    DummyStrengths(2) = 1
    DummyAgilities(2) = 0
    DummyNames$(3) = "Vegetiod"
    DummySpares(3) = 2
    DummyHappys(3) = 1
    DummyDialogues$(3) = "Farmed Locally, Very Locally"
    DummyVitalities(3) = 1
    DummyStrengths(3) = 1
    DummyAgilities(3) = 0
    DummyNames$(4) = "Moldsmal"
    DummySpares(4) = 2
    DummyHappys(4) = 1
    DummyDialogues$(4) = "Blurp blop"
    DummyVitalities(4) = 1
    DummyStrengths(4) = 1
    DummyAgilities(4) = 0
    DummyNames$(5) = "Skeleton"
    DummySpares(5) = 2
    DummyHappys(5) = 1
    DummyDialogues$(5) = "Mwuahaha!"
    DummyVitalities(5) = 1
    DummyStrengths(5) = 2
    DummyAgilities(5) = 0
    DummyNames$(6) = "Skate bug"
    DummySpares(6) = 1
    DummyHappys(6) = 1
    DummyDialogues$(6) = "Im the coolest bug in town!"
    DummyVitalities(6) = 1
    DummyStrengths(6) = 1
    DummyAgilities(6) = 1
    DummyNames$(7) = "Doggo"
    DummySpares(7) = 1
    DummyHappys(7) = 1
    DummyDialogues$(7) = "Meow!"
    DummyVitalities(7) = 1
    DummyStrengths(7) = 2
    DummyAgilities(7) = 0
    DummySpare = DummySpares(aDummyIndex)
    DummyHappy = DummyHappys(aDummyIndex)
    DummyName$ = DummyNames$(aDummyIndex)
    DummyDialogue$ = DummyDialogues$(aDummyIndex)
    levelDiff=1
    minDummyLevel = PlayerLevel-levelDiff
    if (minDummyLevel<1) then minDummyLevel = 1
    DummyLevel = randInRange(minDummyLevel, PlayerLevel+levelDiff)
    DummyVitality = DummyVitalities(aDummyIndex)
    DummyStrength = DummyStrengths(aDummyIndex)
    DummyAgility = DummyAgilities(aDummyIndex)
    if DummyLevel > 1 then
        for i = 1 to DummyLevel
            call levelDummyUp
        next i
    end if
    DummyGold = randInRange(0, DummyLevel)
    DummyXP = DummyVitality + DummyStrength + DummyAgility
    DummyHealth = calculateMaxHP(DummyVitality, DummyStrength)
end sub
sub generateDummyArea1 aDummyIndex
    DummyNames$(1) = "Woshua"
    DummySpares(1) = 1
    DummyHappys(1) = 1
    DummyDialogues$(1) = "i must clens the world..."
    DummyVitalities(1) = 2
    DummyStrengths(1) = 1
    DummyAgilities(1) = 0
    DummyNames$(2) = "glyde"
    DummySpares(2) = 1
    DummyHappys(2) = 1
    DummyDialogues$(2) = "Eh?you forgot to clap."
    DummyVitalities(2) = 1
    DummyStrengths(2) = 1
    DummyAgilities(2) = 0
    DummyNames$(3) = "Moldbygg"
    DummySpares(3) = 2
    DummyHappys(3) = 1
    DummyDialogues$(3) = "Gooh!"
    DummyVitalities(3) = 1
    DummyStrengths(3) = 1
    DummyAgilities(3) = 0
    DummyNames$(4) = "Doodlebug"
    DummySpares(4) = 2
    DummyHappys(4) = 1
    DummyDialogues$(4) = "Yö'ôûâÿ÷   øôæéíÿþ"
    DummyVitalities(4) = 1
    DummyStrengths(4) = 1
    DummyAgilities(4) = 0
    DummyNames$(5) = "Astigmatism"
    DummySpares(5) = 2
    DummyHappys(5) = 1
    DummyDialogues$(5) = "Have you fallen down?you cant look at it.you cant look at it.you cant look at it"
    DummyVitalities(5) = 1
    DummyStrengths(5) = 2
    DummyAgilities(5) = 0
    DummyNames$(6) = "Glad dummy"
    DummySpares(6) = 1
    DummyHappys(6) = 1
    DummyDialogues$(6) = "I'm so happy:)"
    DummyVitalities(6) = 1
    DummyStrengths(6) = 1
    DummyAgilities(6) = 1
    DummyNames$(6) = "Catty"
    DummySpares(6) = 1
    DummyHappys(6) = 1
    DummyDialogues$(6) = "Woof!"
    DummyVitalities(6) = 1
    DummyStrengths(6) = 2
    DummyAgilities(6) = 0
    DummySpare = DummySpares(aDummyIndex)
    DummyHappy = DummyHappys(aDummyIndex)
    DummyName$ = DummyNames$(aDummyIndex)
    DummyDialogue$ = DummyDialogues$(aDummyIndex)
    levelDiff=1
    minDummyLevel = PlayerLevel-levelDiff
    if (minDummyLevel<1) then minDummyLevel = 1
    DummyLevel = randInRange(minDummyLevel, PlayerLevel+levelDiff)
    DummyVitality = DummyVitalities(aDummyIndex)
    DummyStrength = DummyStrengths(aDummyIndex)
    DummyAgility = DummyAgilities(aDummyIndex)
    if DummyLevel > 1 then
        for i = 1 to DummyLevel
            call levelDummyUp
        next i
    end if
    DummyGold = randInRange(0, DummyLevel)
    DummyXP = DummyVitality + DummyStrength + DummyAgility
    DummyHealth = calculateMaxHP(DummyVitality, DummyStrength)
    end sub
' INVENTORY, ITEMS, ARMOR, WEAPONS
sub initPlayerInventory
    PlayerInventoryItemsQuantities(1) = int(rnd(1)*5)   '"Crab Apple"
    PlayerInventoryItemsQuantities(2) = int(rnd(1)*4)   '"Sea Tea"
    PlayerInventoryItemsQuantities(3) = 1               '"Cinnamon-Buttersctotch Pie"
    PlayerInventoryItemsQuantities(4) = int(rnd(1)*2)   '"Monster Candy"
    PlayerInventoryItemsQuantities(5) = int(rnd(1)*7)   '"Spider Donut"
    PlayerInventoryItemsQuantities(6) = 0               'some berries
    PlayerInventoryItemsQuantities(7) = 0               ' artefact
    PlayerInventoryItemsQuantities(8) = 0               ' key
end sub
sub loadItem anItemIndex, byref anItemName$, byref anItemHP, byref anItemPrice
    ItemsNames$(1) = "Crab Apple"
    ItemsPrices(1) = 5
    ItemsHPs(1) = 5
    ItemsNames$(2) = "Sea Tea"
    ItemsPrices(2) = 5
    ItemsHPs(2) = 8
    ItemsNames$(3) = "Cinnamon-Buttersctotch Pie"
    ItemsPrices(3) = 5
    ItemsHPs(3) = 21
    ItemsNames$(4) = "Monster Candy"
    ItemsPrices(4) = 5
    ItemsHPs(4) = 5
    ItemsNames$(5) = "Spider Donut"
    ItemsPrices(5) = 5
    ItemsHPs(5) = 11
    ItemsNames$(6) = "Some berries."
    ItemsPrices(6) = 0
    ItemsHPs(6) = 5
    ItemsNames$(7) = "A strange artefact. You don't know what it is, and what it is for."
    ItemsPrices(7) = 0
    ItemsHPs(7) = 0
    ItemsNames$(8) = "A key from ancient castle."
    ItemsPrices(8) = 0
    ItemsHPs(8) = 0
' fill output arguments
    anItemName$ = ItemsNames$(anItemIndex)
    anItemHP = ItemsHPs(anItemIndex)
    anItemPrice = ItemsPrices(anItemIndex)
end sub
sub loadArmor anArmorIndex, byref anArmorName$, byref anArmorDF, byref anArmorPrice
    ArmorNames$(1) = "Nothing"'"Bandage"
    ArmorPrices(1) = 0 '1
    ArmorDFs(1) = 0 '1
    ArmorNames$(2) = "Bandana"
    ArmorPrices(2) = 5
    ArmorDFs(2) = 5
    ArmorNames$(3) = "Jackpot Jacket"
    ArmorPrices(3) = 10
    ArmorDFs(3) = 10
    ArmorNames$(4) = "Royal Armor"
    ArmorPrices(4) = 15
    ArmorDFs(4) = 15
' fill output arguments
    anArmorName$ = ArmorNames$(anArmorIndex)
    anArmorDF = ArmorDFs(anArmorIndex)
    anArmorPrice = ArmorPrices(anArmorIndex)
end sub
sub loadWeapon aWeaponIndex, byref aWeaponName$, byref aWeaponATK, byref aWeaponPrice
    WeaponNames$(1) = "Nothing"'"Stick"
    WeaponPrices(1) = 0 '1
    WeaponATKs(1) = 0 '2
    WeaponNames$(2) = "Toy Knife"
    WeaponPrices(2) = 5
    WeaponATKs(2) = 5
    WeaponNames$(3) = "Krystal bat"
    WeaponPrices(3) = 10
    WeaponATKs(3) = 10
    WeaponNames$(4) = "Real Knife"
    WeaponPrices(4) = 15
    WeaponATKs(4) = 15
' fill output arguments
    aWeaponName$ = WeaponNames$(aWeaponIndex)
    aWeaponATK = WeaponATKs(aWeaponIndex)
    aWeaponPrice = WeaponPrices(aWeaponIndex)
end sub
' service subs and funcs/////////////////////////////////////////////////
sub waitMilliseconds aMillisecondsDelay
    ms = time$("milliseconds")
    msNow = ms
    msDiff = msNow - ms
    do
        msNow = time$("milliseconds")
        msDiff = msNow - ms
    loop until msDiff >= aMillisecondsDelay
end sub
function randInRange(aRangeMin, aRangeMax)
    randInRange = int(rnd(1)*((aRangeMax+1) - aRangeMin))+aRangeMin
end function
function calculateMaxHP(aVitality, aStrength)
    calculateMaxHP = 10 + (aVitality * 5) + aStrength
end function
function levelXP() '(aLevel)
    levelXP = 10 * PlayerLevel' aLevel
end function
function maxATK(aStrength)
    maxATK = aStrength
end function
function minATK(aStrength)
    atk=int(aStrength / 2)
    if (atk<1) then atk = 1
    minATK = atk
end function
function maxDF(anAgility)
    maxDF = anAgility
end function
function minDF(anAgility)
    minDF = int(anAgility/2)
end function
function maxPlayerATK()
    weaponName$=""
    weaponATK=0
    weaponPrice=0
    call loadWeapon PlayerCurrentWeapon, weaponName$, weaponATK, weaponPrice
    maxPlayerATK = maxATK(PlayerStrength) + weaponATK
end function
function minPlayerATK()
    weaponName$=""
    weaponATK=0
    weaponPrice=0
    call loadWeapon PlayerCurrentWeapon, weaponName$, weaponATK, weaponPrice
    minPlayerATK = minATK(PlayerStrength) + weaponATK
end function
function maxPlayerDF()
    armorName$=""
    armorDF=0
    armorPrice=0
    call loadArmor PlayerCurrentArmor, armorName$, armorDF, armorPrice
    maxPlayerDF = maxDF(PlayerAgility) + armorDF
end function
function minPlayerDF()
    armorName$=""
    armorDF=0
    armorPrice=0
    call loadArmor PlayerCurrentArmor, armorName$, armorDF, armorPrice
    minPlayerDF = minDF(PlayerAgility) + armorDF
end function
function maxDummyATK()
    maxDummyATK = maxATK(DummyStrength)
end function
function minDummyATK()
    minDummyATK = minATK(DummyStrength)
end function
function maxDummyDF()
    maxDummyDF = maxDF(DummyAgility)
end function
function minDummyDF()
    minDummyDF = minDF(DummyAgility)
end function
sub printPlayerArmor
    armorName$=""
    armorDF=0
    armorPrice=0
    call loadArmor PlayerCurrentArmor, armorName$, armorDF, armorPrice
    PRINT "Your current armor: "; armorName$; ". It DF: "; armorDF
end sub
sub printPlayerWeapon
    weaponName$=""
    weaponATK=0
    weaponPrice=0
    call loadWeapon PlayerCurrentWeapon, weaponName$, weaponATK, weaponPrice
end sub
sub levelDummyUp
    skill = DummyVitality + DummyStrength + DummyAgility
    upgrade = randInRange(0, skill-1)
    if (upgrade < DummyStrength) then
        DummyStrength = DummyStrength + 1
    else
        if upgrade < DummyStrength + DummyAgility then
            DummyAgility = DummyAgility + 1
        else
            if upgrade < DummyStrength + DummyAgility + DummyVitality then
                DummyVitality = DummyVitality + 1
            end if
        end if
    end if
end sub
sub levelPlayerUp
    skill = PlayerVitality + PlayerStrength + PlayerAgility
    upgrade = randInRange(0, skill)
    if (upgrade < PlayerStrength) then
        PlayerStrength = PlayerStrength + 1
        print "Strength + 1"
    else
        if upgrade < PlayerStrength + PlayerAgility then
            DummyAgility = DummyAgility + 1
            print "Agility + 1"
        else
            if upgrade < PlayerStrength + DummyAgility + PlayerVitality then
                PlayerVitality = PlayerVitality + 1
                print "Vitality + 1"
            end if
        end if
    end if
end sub
'////////////////////////////////////////////////////////////////////////
' SHOP
sub SHOP
PRINT " __        _    _ "
PRINT "(_  |__|  / \  |_) "
PRINT "__) |  |  \_/  |   "
PRINT " "
PRINT " "
PRINT " "
    PRINT "HI! Welcome to my shop where you can buy ITEMS, ARMOR and WEAPONS"
    do
        PRINT "Your gold: "; PlayerGold
        PRINT
        PRINT "What would you like to buy?"
        PRINT "1. ITEMS"
        PRINT "2. ARMOR"
        PRINT "3. WEAPONS"
        PRINT "0. exit shop"
        INPUT "Your choice:" ;shopChoice
        SELECT CASE shopChoice
            CASE 1
                call SHOPITEMS
            CASE 2
                call SHOPARMOR
            CASE 3
                call SHOPWEAPONS
            CASE 0
                exit do
            CASE ELSE
                PRINT "Invalid choice. Please enter a number from the menu."
        END SELECT
    loop until true
end sub
sub SHOPITEMS
    do
        PRINT "Your gold: "; PlayerGold
        PRINT
        PRINT "ITEMS:"
        for itemIndex = 1 to ItemsSize
            itemName$=""
            itemHP=0
            itemPrice=0
            call loadItem itemIndex, itemName$, itemHP, itemPrice
            if (itemPrice > 0) then
                PRINT itemIndex; ". "; itemName$;
                PRINT ". You have: "; PlayerInventoryItemsQuantities(itemIndex);
                PRINT ". It gives "; itemHP; " HP. It costs: "; itemPrice
            end if
        next itemIndex
        PRINT "0. back"
        INPUT "Choose item to buy:" ;itemChoice
        if (itemChoice=0) then
            exit do
        else
            if (itemChoise > ItemsSize) then
                Print "Wrong choise"
            else
                itemName$=""
                itemHP=0
                itemPrice=0
                call loadItem itemChoice, itemName$, itemHP, itemPrice
                IF ( PlayerGold >= itemPrice ) THEN
                    PlayerInventoryItemsQuantities(itemChoice)=PlayerInventoryItemsQuantities(itemChoice)+1
                    PlayerGold = PlayerGold - itemPrice
                ELSE
                    PRINT "You don't have enough gold"
                end if
            end if
        end if
    loop until true
end sub
sub SHOPARMOR
    do
        PRINT "Your gold: "; PlayerGold
        PRINT
        call printPlayerArmor
        PRINT "Your current armor: "; armorName$; ". It DF: "; armorDF
        PRINT
        PRINT "ARMORS:"
        for armorIndex = 1 to ArmorsSize
            armorName$=""
            armorDF=0
            armorPrice=0
            call loadArmor armorIndex, armorName$, armorDF, armorPrice
            PRINT armorIndex; ". "; armorName$;
            PRINT ". DF: "; armorDF;
            PRINT ". Price "; armorPrice
        next armorIndex
        PRINT "0. back"
        INPUT "Choose armor to buy:" ;armorChoice
        if (armorChoice=0) then
            exit do
        else
            if (armorChoice=PlayerCurrentArmor) then
                PRINT "You already equipped this armor"
            else
                if (armorChoice > ArmorsSize) then
                    PRINT "Wrong choice"
                else
                    armorName$=""
                    armorDF=0
                    armorPrice=0
                    call loadArmor armorChoice, armorName$, armorDF, armorPrice
                    IF ( PlayerGold >= armorPrice ) THEN
                        PlayerCurrentArmor = armorChoice
                        PlayerGold = PlayerGold - armorPrice
                    ELSE
                        PRINT "You don't have enough gold"
                    end if
                end if
            end if
        end if
    loop until true
end sub
sub SHOPWEAPONS
    do
        PRINT "Your gold: "; PlayerGold
        PRINT
        call printPlayerWeapon
        PRINT
        PRINT "WEAPONS:"
        for weaponIndex = 1 to WeaponsSize
            weaponName$=""
            weaponATK=0
            weaponPrice=0
            call loadWeapon weaponIndex, weaponName$, weaponATK, weaponPrice
            PRINT weaponIndex; ". "; weaponName$;
            PRINT ". ATK: "; weaponATK;
            PRINT ". Price "; weaponPrice
        next weaponIndex
        PRINT "0. back"
        INPUT "Choose weapon to buy:" ;weaponChoice
        if (weaponChoice=0) then
            exit do
        else
            if (weaponChoice=PlayerCurrentWeapon) then
                PRINT "You already equipped this weapon"
            else
                if (weaponChoice > WeaponsSize) then
                    PRINT "Wrong choise"
                else
                    weaponName$=""
                    weaponATK=0
                    weaponPrice=0
                    call loadWeapon weaponChoice, weaponName$, weaponATK, weaponPrice
                    IF ( PlayerGold >= weaponPrice ) THEN
                        PlayerCurrentWeapon = weaponChoice
                        PlayerGold = PlayerGold - weaponPrice
                    ELSE
                        PRINT "You don't have enough gold"
                    end if
                end if
            end if
        end if
    loop until true
end sub
' ////////////////////////////////////////////////////////////////////////
sub SEARCHINBUSHES
    print "You searched in bushes."
    if (randInRange(0, 100) < 20) and (PlayerInventoryItemsQuantities(7)=0) then
        print "You found strange artefact."
        ' add artefac to to inventory
        PlayerInventoryItemsQuantities(7)=1
    else
        if (randInRange(0, 100) < 50) then
            print "You found some berries."
            PlayerInventoryItemsQuantities(6)=PlayerInventoryItemsQuantities(6)+1
        else
            print "You found nothing and went away."
        end if
    end if
    print
end sub
sub CASTLE
    print "You are near the ancient castle."
    print "You see a big door. The door is definitely requires a key."
    print "Choose waht to do:"
    print "1. Walk away"
    if (PlayerInventoryItemsQuantities(8)=1) then
        print "2. Use the key for the door of the castle"
    end if
    INPUT "You choise:" ;actionChoice
    SELECT CASE actionChoice
        CASE 1
            PRINT "You walked away."
        CASE 2
            call FINALINCASTLE
        CASE ELSE
            PRINT "You walked away."
    END SELECT
    print
end sub
sub FINALINCASTLE
    if PlayerKills>=20 then
        print "well youve killed everyone so theres no one to murder"
        print "so the only thing i can do is FIGHT you"
        call printWithDelay "Pasta lavista"
        DummyNames$ = "Anton"
        DummySpare = 2
        DummyHappy = 999
        DummyDialogues$ = "I am the one who knows Victoria's secret..."
        DummyVitality = 1
        DummyStrength = 4
        DummyAgility = 1
        call BATTLE
    else
        if Playerkills<=3 then
            Print "Congratulations! You just finished this game, and found the good ending!"
            Print "Thank you!"
            gameFinish=1
        end if
    end if
end sub
sub STRANGER
    castleDiscovered=1
    if PlayerKills>=20 then
        if (PlayerInventoryItemsQuantities(7)=0) then
            PRINT "Stranger:H-hey!i s-see that you've got a lot of kills!"
            PRINT "H-Hey no need t-to be angry how i-i-i uhh give you the key right away!"
            PRINT "Y-yes,yes ill d-do it for free!"
            print "..."
            PlayerInventoryItemsQuantities(8)=1
            print "you walked away"
        else
            PRINT "Stranger:oh i see t-that you've got a lot of kills!"
            print "uh hey h-how about you give me the artifact a-and i will give you the k-key?"
            print "h-how does that sound?"
            print "..."
            PlayerInventoryItemsQuantities(8)=1
            PlayerInventoryItemsQuantities(7)=0
        end if
                    if (PlayerInventoryItemsQuantities(8)>0) then
                Print "I-i already gave you t-the key. W-why did you come back?"
                print "Well ill just accept my fate..."
                CALL waitMilliseconds 300
                print "..."
                CALL waitMilliseconds 300
                print "..."
                print "YOU WON!"
                PRINT "well we didn't gain any XP..."
                PRINT "but we can always gain more"
                CALL waitMilliseconds 100
                PlayerKills=PlayerKills+1
            else
                print "Stranger: I lost my artefact somewhere in bushes. Could you please find it for me?"
                print "You went away from stranger"
            end if
    else
        ' if player has artefact
        if (PlayerInventoryItemsQuantities(7)>0) then
            print "Stranger: Oh! I see you found my artefact! Thank you! For this, I give you a key. This key opens a door of ancient castle."
            print "You have a key from castle now."
            print "You know castle location now."
            print "You went away from stranger"
            PlayerInventoryItemsQuantities(8)=1
            PlayerInventoryItemsQuantities(7)=0
            castleDiscovered=1
        else
            if (PlayerInventoryItemsQuantities(8)>0) then
                Print "I already gave you a key. Why did you come back?"
                print "Hmmm how about we play a game?"
                print "1.Yes"
                print "2.No"
                INPUT "Chioce:"; choice
                SELECT CASE choice
                CASE 1
                PRINT "Ok so let me tell you the rules"
                print "You get 4 tries to guess the number im thinking of"
                print "if you win you'll get 25 gold"
                print "but if you loose i'll take 40 gold from you"
                CALL Game
                CASE 2
                PRINT "Oh well"
                print "You went away from the stranger"
                CASE ELSE
            PRINT "NULL_NAN"
    END SELECT
            else
                print "Stranger: I lost my artefact somewhere in bushes. Could you please find it for me?"
                print "You went away from stranger"
            end if
        end if
    end if
    print
end sub
sub BATTLE
    PRINT DummyName$; " HAS APEARED!"
    print DummyName$ ;"'s Health: "; DummyHealth
    print "your health: "; PlayerCurrentHealth; "/"; PlayerMaxHealth
    ' fighting loop
    DO
        'each time we print menu
        PRINT "1. FIGHT"
        PRINT "2. ACT"
        PRINT "3. ITEM"
        PRINT "4. MERCY"
        print "5. Info about me"
        print "6. Info about "; DummyName$
        PRINT DummyName$; ": " ;DummyDialogue$
        INPUT "Action:" ;actionChoice
        SELECT CASE actionChoice
            CASE 1
                call FIGHT
            CASE 2
                call ACT
            CASE 3
                call ITEM
            CASE 4
                call MERCY
            CASE 5
                call MyInfo
            CASE 6
                call DummyInfo
            CASE ELSE
                PRINT "Invalid choice. Please enter a number from the menu."
        END SELECT
        if PlayerCurrentHealth <= 0 then
            Print "You loose"
            exit do
        end if
        if DummyHappy = 0 then
            PRINT DummyName$; " is smiling"
        end if
        if DummyHealth <= 0 then
        PlayerKills=PlayerKills+1
            PlayerXP=PlayerXP+DummyXP
            PlayerGold = PlayerGold + DummyGold
            PRINT "YOU WON!"
            PRINT "you got " ;DummyXP; " XP"
            PRINT "and " ;DummyGold; " GOLD"
            PRINT "your total XP: " ; PlayerXP; " / "; levelXP()
            PRINT "your total gold: " ; PlayerGold
            ' check for level up
            levelsToUp = int(PlayerXP / levelXP())
            if (levelsToUp>0) then
                for i = 1 to levelsToUp
                    print "Level up!"
                    PlayerLevel = PlayerLevel + 1
                    call levelPlayerUp
                next i
            end if
            GameRound = GameRound + 1
            ' go to the next round
            exit do
        end if
        IF DummySpare=0 THEN
            PlayerXP=PlayerXP+int(rnd(1)*2)
            obtainedGold = int(rnd(1)*10)
            PlayerGold = PlayerGold + obtainedGold
            PRINT "YOU WON!"
            PRINT DummyName$
            PRINT "you got " ;PlayerXP; " XP"
            PRINT "and " ;obtainedGold; " GOLD"
            PRINT "your total gold " ; PlayerGold
            GameRound = GameRound + 1
            exit do
        end if
    LOOP UNTIL TRUE
end sub
' FIGHT ACT ITEM MERCY
sub FIGHT
    dummyDF=randInRange(minDummyDF(), maxDummyDF())
    RandomDamage=randInRange(minPlayerATK(), maxPlayerATK()) - dummyDF
    if RandomDamage<0 then
        RandomDamage=0
    end if
    PRINT DummyName$;" took "; RandomDamage; " damege!"
    DummyHealth=DummyHealth - RandomDamage
    PRINT DummyName$;"'s Health:"; DummyHealth
    playerDF=randInRange(minPlayerDF(), maxPlayerDF())
    RandomDamage=randInRange(minDummyATK(), maxDummyATK()) - playerDF
    RandomDamage=RandomDamage-armorDF
    if RandomDamage<0 then
        RandomDamage=0
    end if
    PRINT "You got "; RandomDamage ; " damage!"
    PlayerCurrentHealth=PlayerCurrentHealth-RandomDamage
    PRINT "Your Health: "; PlayerCurrentHealth; "/"; PlayerMaxHealth
    print
end sub
sub ACT
    armorName$=""
    armorDF=0
    armorPrice=0
    call loadArmor PlayerCurrentArmor, armorName$, armorDF, armorPrice
    PRINT "you complement " ;DummyName$
    PRINT "It seems flattered"
    DummyHappy = DummyHappy - 1
    RandomDamage=int(rnd(1)*5)
    PRINT "You got "; RandomDamage ; " damage!"
    RandomDamage=RandomDamage-armorDF
    if RandomDamage<0 then
        RandomDamage=0
    end if
    PlayerCurrentHealth=PlayerCurrentHealth-RandomDamage
    PRINT "Your Health: "; PlayerCurrentHealth
    print
end sub
sub ITEM
    PRINT "CHOSE ITEM"
    for itemIndex = 1 to ItemsSize
        itemName$=""
        itemHP=0
        itemPrice=0
        call loadItem itemIndex, itemName$, itemHP, itemPrice
        IF (PlayerInventoryItemsQuantities(itemIndex)>0) and (itemHP>0) THEN
            PRINT itemIndex; ". "; PlayerInventoryItemsQuantities(itemIndex); " "; itemName$; " gives "; itemHP; " HP"
        end if
    next itemIndex
    print "0. Exit"
    do
        INPUT "Choose Item:" ;itemChoice
        if (itemChoice=0) then
            exit do
        else
            itemName$=""
            itemHP=0
            itemPrice=0
            call loadItem itemChoice, itemName$, itemHP, itemPrice
            IF PlayerInventoryItemsQuantities(itemChoice)>0 THEN
                PlayerCurrentHealth = PlayerCurrentHealth + itemHP
                PRINT "Your Health ";PlayerCurrentHealth
                PlayerInventoryItemsQuantities(itemChoice)=PlayerInventoryItemsQuantities(itemChoice)-1
                exit do
            ELSE
                PRINT "you ran out of this item"
            end if
        end if
    loop until true
    print
end sub
sub MERCY
    IF DummyHappy>0 THEN
        armorName$=""
        armorDF=0
        armorPrice=0
        call loadArmor PlayerCurrentArmor, armorName$, armorDF, armorPrice
        PRINT DummyName$; " is too angry to be spared"
        RandomDamage=int(rnd(1)*5)
        PRINT "You got "; RandomDamage; " damage!"
        RandomDamage=RandomDamage-armorDF
        if RandomDamage<0 then
            RandomDamage=0
        end if
        PlayerCurrentHealth=PlayerCurrentHealth-RandomDamage
        PRINT "Your Health "; PlayerCurrentHealth
        print
        else
        IF DummyHappy=0 then
                    DummySpare=DummySpare=-1
    end if
    end if
end sub
sub MyInfo
    print "Your health: "; PlayerCurrentHealth; "/"; PlayerMaxHealth
    print "Level: "; PlayerLevel; " EXP: "; PlayerXP; "/"; levelXP()
    print "Vitality (affects max HP):           "; PlayerVitality
    print "Strength (affects ATK and max HP):   "; PlayerStrength
    print "Agility (affects DF):                "; PlayerAgility
    print "ATK: "; minPlayerATK(); "-"; maxPlayerATK()
    print "DF: "; minPlayerDF(); "-"; maxPlayerDF()
    print "Gold: "; PlayerGold
    call printPlayerArmor
    call printPlayerWeapon
    print "Your items:"
    for itemIndex = 1 to ItemsSize
        itemName$=""
        itemHP=0
        itemPrice=0
        IF PlayerInventoryItemsQuantities(itemIndex)>0 THEN
            call loadItem itemIndex, itemName$, itemHP, itemPrice
            PRINT PlayerInventoryItemsQuantities(itemIndex); " "; itemName$; ". It gives "; itemHP; " HP."
        end if
    next itemIndex
    print
end sub
sub DummyInfo
    print DummyName$
    print "HP: "; DummyHealth
    print "Level: "; DummyLevel; " XP: "; DummyXP
    print "ATK: "; minDummyATK(); "-"; maxDummyATK()
    print "DF: "; minDummyDF(); "-"; maxDummyDF()
    print "Gold: "; DummyGold
    print
end sub
sub Quiz
end sub
sub Game
PlayerGuesses=4
    PRINT "Welcome to the funny number game!"
    RandomAns=int(rnd(1)*10)
    DO
        INPUT "select a number from 1 to 10!:" ; PlayerInputNum
        IF PlayerInputNum>RandomAns THEN
            PRINT "Your number is too big"
            PlayerGuesses=PlayerGuesses-1
        end IF
        IF PlayerInputNum<RandomAns THEN
            PRINT "Your number is too small"
            PlayerGuesses=PlayerGuesses-1
        end IF
        IF PlayerGuesses<=0 then
        print "STRANGER:"
        PRINT "Welp you win some you loose some but today i won"
        PlayerGold=PlayerGold-40
        PlayerGuesses=4
        END IF
    LOOP UNTIL PlayerInputNum=RandomAns
    PRINT "CONGRATULATIONS!YOU WON!"
    PlayerGold=PlayerGold+25
end sub
sub printWithDelay stringToPrint$
    for i=0 to len(stringToPrint$)
        print mid$(stringToPrint$, i, 1);
        call waitSecond
    next i
end sub
sub waitSecond
    seconds = time$("seconds")
    secondsNow = seconds
    secondsDiff = secondsNow - seconds
    do
        secondsNow = time$("seconds")
        secondsDiff = secondsNow - seconds
    loop until secondsDiff >= 1
end sub
