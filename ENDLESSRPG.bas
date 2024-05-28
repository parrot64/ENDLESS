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
global PlayerCurrentHealth
global PlayerMaxHealth
global PlayerLevel
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
    print "you are in the forest."
    seeDummy=0
    seeBushes = 0
    if (randInRange(0, 100) < 20) then
        randomDummy=randInRange(1,3)
        call generateDummy randomDummy
        print "You see "; DummyName$; " Is going."
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
                    print "You met stranger."
                    strangerDiscovered=1
                end if
            end if
        end if
    end if
    print "Choose what to do:"
    print "1. walk around"
    print "2. Go to trader"
    print "3. Info about me"
    if (seeDummy=1) then
        print "4. Attack "; DummyName$
    end if

    if (seeBushes = 1) then
        print "5. Search in bushes"
    end if
    if (castleDiscovered = 1) then
        print "6. Go to castle"
    end if
    if (strangerDiscovered = 1) then
        print "7. Go to stranger and talk to him"
    end if
    input "Action choise:"; actionChoice
    SELECT CASE actionChoice
        CASE 1
            PRINT "You walked around a bit."
        CASE 2
            call SHOP
        CASE 3
            call MyInfo
        CASE 4
            if (seeDummy=1) then
                call BATTLE
            end if
        case 5
            if (seeBushes = 1) then
                call SEARCHINBUSHES
            end if
        case 6
            if (castleDiscovered = 1) then
                call CASTLE
            end if
        case 7
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
    DummyNames$(1) = "Froggit"
    DummySpares(1) = 1
    DummyHappys(1) = 1
    DummyDialogues$(1) = "Ribbit,Ribbit"
    DummyVitalities(1) = 1
    DummyStrengths(1) = 1
    DummyAgilities(1) = 0
    DummyNames$(2) = "Vegetiod"
    DummySpares(2) = 2
    DummyHappys(2) = 1
    DummyDialogues$(2) = "Farmed Locally, Very Locally"
    DummyVitalities(2) = 1
    DummyStrengths(2) = 1
    DummyAgilities(2) = 0
    DummyNames$(3) = "Moldsmal"
    DummySpares(3) = 2
    DummyHappys(3) = 1
    DummyDialogues$(3) = "OK idk what to write here i dont even know what he says"
    DummyVitalities(3) = 1
    DummyStrengths(3) = 1
    DummyAgilities(3) = 0
    DummyNames$(4) = "Anton2012" 'BOSS=)
    DummySpares(4) = 2
    DummyHappys(4) = 1
    DummyDialogues$(4) = "ok this is kinda tought but hey dont give up david :P"
    DummyVitalities(4) = 1
    DummyStrengths(4) = 1
    DummyAgilities(4) = 0
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
    ArmorNames$(2) = "Light shield"
    ArmorPrices(2) = 5
    ArmorDFs(2) = 5
    ArmorNames$(3) = "Medium shield"
    ArmorPrices(3) = 10
    ArmorDFs(3) = 10
    ArmorNames$(4) = "Hard Shield"
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
    WeaponNames$(2) = "Light Weapon"
    WeaponPrices(2) = 5
    WeaponATKs(2) = 5
    WeaponNames$(3) = "Medium Weapon"
    WeaponPrices(3) = 10
    WeaponATKs(3) = 10
    WeaponNames$(4) = "Heavy Weapon"
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
PRINT "(_   |_|  /  \  |_) "
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
        INPUT "Your choise:" ;shopChoice
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
' PRINT " __        _    _ "
' PRINT "(_   |_|  /  \  |_) "
' PRINT "__) |  |  \_/  |   "
' PRINT " ITEMS "
' PRINT " "
' PRINT " "
'     PRINT "HI! Welcome to my shop where you can buy ITEMS, ARMOR and WEAPONS"
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
                    PRINT "Wrong choise"
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
    Print "Congratulations! You just finished this game, and found good ending!"
    Print "Thank you!"
    gameFinish=1
end sub
sub STRANGER
    ' if player has artefact
    if (PlayerInventoryItemsQuantities(7)>0) then
        print "Stranger: Oh! I see you found my artefact! Thank you! For this, I give you a key. This key opens a door of ancient castle."
        print "You has a key from castle now."
        print "You know castle location now."
            print "You went away from stranger"
        PlayerInventoryItemsQuantities(8)=1
        PlayerInventoryItemsQuantities(7)=0
        castleDiscovered=1
    else
        if (PlayerInventoryItemsQuantities(8)>0) then
            Print "I already gave you a key. Why did you come back?"
            print "You went away from stranger"
        else
            print "Stranger: I lost my artefact somewhere in bushes. Could you please find it for me?"
            print "You went away from stranger"
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
            DummySpare=DummySpare=-1
        end if
        if DummyHealth <= 0 then
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
    IF DummySpare>0 THEN
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
