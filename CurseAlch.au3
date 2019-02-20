#include <ImageSearch2015.au3>

HotKeySet("{END}", "_Exit")

Dim $aArray[7] = ["0x672824","0x4A1D1A","0x8C3932","0x602622","0x6F2C26","0xD1A177","0x5D4835"]
Global $snarex,$snarey,$enfeeblex,$enfeebley,$alchx,$alchy,$alchmouse = random(2, 8, 1),$alchsleep = random(1000, 3000, 1),$itemx,$itemy,$itemmouse = random(2, 8, 1),$itemsleep = random(1000, 3000, 1),$stunx,$stuny,$stunmouse = random(2, 8, 1),$stunsleep = random(1000, 3500, 1),$monkmouse = random(2, 8, 1)

$ConfirmTarget = @ScriptDir & "\images\confirmMonk.PNG"
$alch = @ScriptDir & "\images\alch.png"
$stun = @ScriptDir & "\images\curse.png"
$item = @ScriptDir & "\images\item.png"
$snare = @ScriptDir & "\images\snare.png"
$enfeeble = @ScriptDir & "\images\weaken.png"
$curse = @ScriptDir & "\images\curse.png"
$weaken = @ScriptDir & "\images\weaken.png"

_FindClient()
_SetActiveClient()
_FindSpellsAndItems()

While 1

   Global $snarex,$snarey,$enfeeblex,$enfeebley,$alchx,$alchy,$alchmouse = random(2, 8, 1),$alchsleep = random(1000, 3000, 1),$itemx,$itemy,$itemmouse = random(2, 8, 1),$itemsleep = random(1000, 3000, 1),$stunx,$stuny,$stunmouse = random(2, 8, 1),$stunsleep = random(1000, 3500, 1),$monkmouse = random(2, 8, 1)

   _FindClient()
   _SetActiveClient()

   If IsArray($aPos) Then

	  ;~ FIND SNARE MAGIC SPELL
	  Do
	  Until _ImageSearchArea ($snare,1,$aPos[0],$aPos[1],$aPos[0]+$aPos[2],$aPos[1]+$aPos[3],$snarex,$snarey,30,0)
		 MouseMove( $alchx + Random(-10.5,10.5,1), $alchy + Random(-10.5,10.5,1), $alchmouse)
		 MouseClick($MOUSE_CLICK_LEFT)

	  ;~ FIND ITEM IN INVETNORY
	  Do
	  Until _ImageSearchArea($item,1,$aPos[0],$aPos[1],$aPos[0]+$aPos[2],$aPos[1]+$aPos[3],$itemx,$itemy,30,0)
		 MouseMove( $itemx + Random(-11,11,1), $itemy + Random(-10.5,10.5,1), $itemmouse)
		 MouseClick($MOUSE_CLICK_LEFT)

	  Sleep(1000)

	  ;~ FIND FEEBLE SPELL AND CLICK
	  Do
	  Until _ImageSearchArea($enfeeble,1,$aPos[0],$aPos[1],$aPos[0]+$aPos[2],$aPos[1]+$aPos[3],$enfeeblex,$enfeebley,30,0)
		 MouseMove( $stunx + Random(-10,10,1), $stuny + Random(-9.5,9.5,1), $stunmouse)
		 MouseClick($MOUSE_CLICK_LEFT)

	  Do
		 $monkPixel = $aArray[Random(0,6)]
;~ 		 _ScreenCapture_Capture("TEST_screen.PNG", $aPos[0],$aPos[1] +35,(($aPos[0]+$aPos[2]) - 250),(($aPos[1]+$aPos[3]) - 165));
		 $monk = PixelSearch($aPos[0],$aPos[1] +35,(($aPos[0]+$aPos[2]) - 250),(($aPos[1]+$aPos[3]) - 165), $monkPixel,5)
		 If IsArray($monk) = 1 Then
			ConsoleWrite("Found Monk Pixel")
			MouseMove($monk[0], $monk[1], $monkmouse)
			Sleep(200)
		 EndIf
;~ 		 _ScreenCapture_Capture("TESTMON_screen.PNG", $aPos[0],$aPos[1] +35,(($aPos[0]+$aPos[2]) - 400),(($aPos[1]+$aPos[3]) - 450));
	  Until IsArray($monk) = 1; And _ImageSearchArea($ConfirmTarget,1,$aPos[0],$aPos[1] +35,(($aPos[0]+$aPos[2]) - 400),(($aPos[1]+$aPos[3]) - 450),$enfeeblex,$enfeebley,25,"0x00FF00") = 1
		 ConsoleWrite("Clicking Monk")
		 MouseClick($MOUSE_CLICK_LEFT)
   EndIf
WEnd



func _Exit()
   Exit 0
EndFunc

Func _FindSpellsAndItems()
   MsgBox($MB_SYSTEMMODAL, "RSAutoswitcher.com - Curse/Alch", "Welcome to RSAutoswitcher.com's Curse/Alch script. Press OK to continue.", 10)
   MsgBox($MB_SYSTEMMODAL, "RSAutoswitcher.com - Curse/Alch", "Starting Find spells", 10)
   Send("{F6}")
;~    MsgBox($MB_SYSTEMMODAL, "Title", "Send F6", 10)

   Do
   Until _ImageSearchArea ($alch,1,$aPos[0],$aPos[1],$aPos[0]+$aPos[2],$aPos[1]+$aPos[3],$alchx,$alchy,30,0)
	  MsgBox($MB_SYSTEMMODAL, "RSAutoswitcher.com - Curse/Alch", "found alch", 10)

   Do
   Until _ImageSearchArea($stun,1,$aPos[0],$aPos[1],$aPos[0]+$aPos[2],$aPos[1]+$aPos[3],$stunx,$stuny,30,0)
	  MsgBox($MB_SYSTEMMODAL, "RSAutoswitcher.com - Curse/Alch", "found curse", 10)
	  Send("{ESC}")

   Do
   Until _ImageSearchArea($item,1,$aPos[0],$aPos[1],$aPos[0]+$aPos[2],$aPos[1]+$aPos[3],$itemx,$itemy,30,0)
	  MsgBox($MB_SYSTEMMODAL, "RSAutoswitcher.com - Curse/Alch", "found item", 10)
	  Send("{F6}")

EndFunc

Func _FindClient()
   Global $rs_window = WinList("[REGEXPTITLE:^(.*?)(OS\-Scape|OSBuddy\sFree|OSBuddy\sGuest|OSBuddy\sPro|Old\sSchool\sRuneScape|RuneLoader|Konduit|SwiftKit|Exilent|Dawntained|Elkoy|SpawnPK|Soulplay|Alora)(.*?)$$]")
   If $rs_window[0][0] >= 1 Then
	  If StringLen($rs_window[1][1]) > 1 Then
		 Global $aPos = WinGetPos($rs_window[1][1])
		 return $aPos
	  EndIf
   EndIf
   return False
EndFunc

Func _SetActiveClient()
   If _elementExists($rs_window, 1) Then
	  If WinActive($rs_window[1][1]) = 0 Then
		  WinActivate($rs_window[1][1])
	   EndIf
   EndIf
EndFunc

Func _elementExists($array, $element)
    If $element > UBound($array)-1 Then Return False ; element is out of the array bounds
    Return True ; element is in array bounds
EndFunc

Func Reset_()
   Send("{F6}")
   MouseClick("left", 565, 275,1,1)
   Send("{UP}")
   Send("{UP down}")
   Sleep(2000)
   Send("{DOWN UP}")
   Send("{UP UP}")
EndFunc
