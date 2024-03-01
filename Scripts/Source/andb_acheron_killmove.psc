Scriptname andb_acheron_killmove extends Quest

String Property OptionFollowerID = "andb_acheron_killmove_follower" AutoReadonly
String Property OptionSelfID = "andb_acheron_killmove_self" AutoReadonly

Package Property blankPackage Auto
andb_acheron_killmove_ally_1 Property killmoveAlly1Quest Auto
String Property testPIdle Auto

Event OnInit()
	reInit()
EndEvent

Event OnHunterPrideSelect(int aiOptionID, Actor akTarget)
	If (aiOptionID == Acheron.GetOptionID(OptionSelfID))
		If (akTarget == None || akTarget.IsChild())
			return
		EndIf
		Actor Source = Game.GetPlayer()
		ActorBase VicActorBase = akTarget.GetLeveledActorBase()
		If (!VicActorBase.IsEssential() && !VicActorBase.IsProtected())
			KillMove(akTarget, Source, true)
		EndIf
	EndIf

	If (aiOptionID == Acheron.GetOptionID(OptionFollowerID))

		If(!killmoveAlly1Quest.IsStopped())
			killmoveAlly1Quest.Stop()
		EndIf

		If (akTarget == None || akTarget.IsChild())
			return
		EndIf
		ActorBase VicActorBase = akTarget.GetLeveledActorBase()
		If (VicActorBase.IsEssential() || VicActorBase.IsProtected())
			return
		EndIf

		Int Attempts = 10
		Bool Succes = False
		While (!Succes && (Attempts > 0))
			Attempts -= 1
			If killmoveAlly1Quest.IsStopped()
				Succes = True
			Else
				Utility.Wait(0.5)
			Endif
		EndWhile

		If Succes
			killmoveAlly1Quest.Start()
			Attempts = 10
			Succes = False
			While (!Succes && (Attempts > 0))
				Attempts -= 1
				If killmoveAlly1Quest.IsRunning()
					Succes = True
				Else
					Utility.Wait(0.5)
				Endif
			EndWhile
			If Succes
				killmoveAlly1Quest.killTarget(akTarget)
			EndIf
		EndIf

	EndIf
EndEvent

Function reInit()
	deInit()

	If(!Acheron.HasOption(OptionSelfID))
    	; Register option
    	int result = Acheron.AddOption(OptionSelfID, 		"$andb_acheron_killmove_self", "andb_acheron_killmove\\kill1.dds", 		"{\"Target\":{\"IS\":[\"NonEssential\"],\"NOT\":{\"Factions\":[\"0x84D1B|Skyrim.esm\"]}}}")
    	If (result > -1)
			Log("Successfully registered '" + OptionSelfID + "'.")
			If(!Acheron.HasOption(OptionFollowerID))
				; Register option
				result = Acheron.AddOption(OptionFollowerID, 	"$andb_acheron_killmove_follower", "andb_acheron_killmove\\kill2.dds", 	"{\"Target\":{\"IS\":[\"NonEssential\"],\"NOT\":{\"Factions\":[\"0x84D1B|Skyrim.esm\"]}}}")
				If (result > -1)
					Log("Successfully registered '" + OptionFollowerID + "'.")
				Else
					Log("Error on register '" + OptionFollowerID + "'.")
				EndIf
			EndIf
			; Register callback
			Acheron.RegisterForHunterPrideSelect(self)
		Else
			Log("Error on register '" + OptionSelfID + "'.")
    	EndIf
  	EndIf
EndFunction

Function deInit()
	Acheron.UnregisterForHunterPrideSelect(self)

	If(Acheron.HasOption(OptionSelfID))
		if(!Acheron.RemoveOption(OptionSelfID))
			Log("Error on remove '" + OptionSelfID + "'.")
		EndIf
	EndIf
	If(Acheron.HasOption(OptionFollowerID))
		if(!Acheron.RemoveOption(OptionFollowerID))
			Log("Error on remove '" + OptionFollowerID + "'.")
		EndIf
	EndIf
EndFunction

Idle Function getKillMoveIdle(Int LWeaponType, Int RWeaponType, Idle[] Exclude, bool backPreffered = false)
	Idle[] bKillmoves = New Idle[50]
	Idle[] fKillmoves = New Idle[50]
	int bCnt = 0
	int fCnt = 0
	if(RWeaponType == 0); Hand
		if(LWeaponType == 0 || LWeaponType == 9); Hand, Magic spell
			bKillmoves[bCnt] = (Game.GetFormFromFile(0x81B, "Update.esm") As Idle); pa_KillMoveH2HSuplex - Patch_1.5\Paired_H2HKillMoveSuplex.HKX
			bCnt += 1
			fKillmoves[fCnt] = (Game.GetFormFromFile(0x820, "Update.esm") As Idle); pa_KillMoveH2HBodySlam - Patch_1.5\Paired_H2HKillMoveBodySlam.HKX
			fCnt += 1
		EndIf
	EndIf
	if(RWeaponType == 0 || RWeaponType == 9); Hand, Magic spell
		fKillmoves[fCnt] = (Game.GetFormFromFile(0x821, "Update.esm") As Idle); pa_KillMoveH2HKneeThrow - Patch_1.5\Paired_H2HKillMoveKneeThrow.HKX
		fCnt += 1
		if(LWeaponType != 10); Shield
			fKillmoves[fCnt] = (Game.GetFormFromFile(0xF4698, "Skyrim.esm") As Idle); pa_KillMoveH2HSlamA - Paired_H2HKillMoveSlamA.hkx
			fCnt += 1
			fKillmoves[fCnt] = (Game.GetFormFromFile(0xF9958, "Skyrim.esm") As Idle); pa_KillMoveH2HComboA - Paired_H2HKillMoveComboA.hkx
			fCnt += 1
			bKillmoves[bCnt] = (Game.GetFormFromFile(0x815, "Update.esm") As Idle) ; pa_KillMoveH2HSneakNeckBreak - Patch_1.5\Paired_H2HSneakNeckBreak.HKX
			bCnt += 1
			bKillmoves[bCnt] = (Game.GetFormFromFile(0x816, "Update.esm") As Idle); pa_KillMoveH2HSneakSleeper - Patch_1.5\Paired_H2HSneakSleeper.hkx
			bCnt += 1
		EndIf
	EndIf
	if(RWeaponType == 1); 1H sword
		fKillmoves[fCnt] = (Game.GetFormFromFile(0x5570B, "Skyrim.esm") As Idle); pa_KillMoveK - Paired_1HMKillMoveK.hkx
		fCnt += 1
		if(LWeaponType == 0 || RWeaponType == 9); Hand, Magic spell
			fKillmoves[fCnt] = (Game.GetFormFromFile(0xF469E, "Skyrim.esm") As Idle); pa_KillingBlow - Paired_1HMBleedOutKill.hkx
			fCnt += 1
		EndIf
	EndIf
	if(RWeaponType == 1 || RWeaponType == 2); 1H sword, 1H dagger
		fKillmoves[fCnt] = (Game.GetFormFromFile(0xF469B, "Skyrim.esm") As Idle); pa_KillMoveShortB - Paired_1HMKillMoveShortB.hkx
		fCnt += 1
		fKillmoves[fCnt] = (Game.GetFormFromFile(0xF469D, "Skyrim.esm") As Idle); pa_KillMoveShortD - Paired_1HMKillMoveShortD.hkx
		fCnt += 1
		if(LWeaponType == 10); Shield
			fKillmoves[fCnt] = (Game.GetFormFromFile(0x55705, "Skyrim.esm") As Idle); pa_KillMoveE - Paired_1HMKillMoveE.hkx
			fCnt += 1
		Else
			fKillmoves[fCnt] = (Game.GetFormFromFile(0x55708, "Skyrim.esm") As Idle); pa_KillMoveH - Paired_1HMKillMoveH.hkx
			fCnt += 1
			fKillmoves[fCnt] = (Game.GetFormFromFile(0x50DA6, "Skyrim.esm") As Idle); pa_KillMove - Paired_1HMKillMove.hkx
			fCnt += 1
			fKillmoves[fCnt] = (Game.GetFormFromFile(0x5474A, "Skyrim.esm") As Idle); pa_KillMoveD - Paired_1HMKillMoveD.hkx
			fCnt += 1
			fKillmoves[fCnt] =  (Game.GetFormFromFile(0xF469F, "Skyrim.esm") As Idle); pa_KillMoveDualWieldA - paired_1hmkillmovedualwielda.hkx
			fCnt += 1
			fKillmoves[fCnt] = (Game.GetFormFromFile(0xF4679, "Skyrim.esm") As Idle); pa_1HMSneakKillBackA - paired_1hmsneakkillbacka.hkx
			fCnt += 1
			fKillmoves[fCnt] = (Game.GetFormFromFile(0x55709, "Skyrim.esm") As Idle); pa_KillMoveI - Paired_1HMKillMoveI.hkx
			fCnt += 1
			bKillmoves[bCnt] = (Game.GetFormFromFile(0xF465A, "Skyrim.esm") As Idle) ; pa_1HMKillMoveBackStab - Paired_1HMKillMoveBackStab.hkx
			bCnt += 1
			fKillmoves[fCnt] = (Game.GetFormFromFile(0x834, "Update.esm") As Idle); pa_KillMove1HMGrappleStab - Patch_1.5\Paired_1HMKillMoveGrappleStab.HKX
			fCnt += 1
			fKillmoves[fCnt] = (Game.GetFormFromFile(0x835, "Update.esm") As Idle); pa_KillMove1HMRepeatStabDown - Patch_1.5\Paired_1HMKillMoveRepeatStabDown.HKX
			fCnt += 1
			fKillmoves[fCnt] = (Game.GetFormFromFile(0x836, "Update.esm") As Idle); pa_KillMove1HMStabDownChest - Patch_1.5\Paired_1HMKillMoveStabDownChest.HKX
			fCnt += 1
			fKillmoves[fCnt] = (Game.GetFormFromFile(0x837, "Update.esm") As Idle); pa_KillMove1HMStabUpFace - Patch_1.5\Paired_1HMKillMoveStabUpFace.HKX
			fCnt += 1
		EndIf
	EndIf
	if(RWeaponType == 3 || RWeaponType == 4); 1H axe, 1H mace
		if(LWeaponType == 10); Shield
		EndIf
	EndIf
	if(RWeaponType >= 1 && RWeaponType <= 4); 1H
		fKillmoves[fCnt] = (Game.GetFormFromFile(0xF469C, "Skyrim.esm") As Idle); pa_KillMoveShortC - Paired_1HMKillMoveShortC.hkx`
		fCnt += 1
		if(LWeaponType == 10); Shield
			fKillmoves[fCnt] = (Game.GetFormFromFile(0x5570D, "Skyrim.esm") As Idle); pa_KillMoveM - Paired_1HMKillMoveM.hkx
			fCnt += 1
			fKillmoves[fCnt] = (Game.GetFormFromFile(0x55706, "Skyrim.esm") As Idle); pa_KillMoveF - Paired_1HMKillMoveF.hkx
			fCnt += 1
			fKillmoves[fCnt] = (Game.GetFormFromFile(0x5169F, "Skyrim.esm") As Idle); pa_KillMoveB - Paired_1HMKillMoveB.hkx
			fCnt += 1
			fKillmoves[fCnt] = (Game.GetFormFromFile(0x838, "Update.esm") As Idle); pa_KillMoveShieldBashSlash - Patch_1.5\Paired_ShieldKillMoveBashSlash.HKX (shield+1h)
			fCnt += 1
		Else
			fKillmoves[fCnt] = (Game.GetFormFromFile(0xF469A, "Skyrim.esm") As Idle); pa_1HMKillMoveShortA - Paired_1HMKillMove_Short_A.hkx
			fCnt += 1
		EndIf
		if(LWeaponType >= 1 && LWeaponType <= 4); 1H - DW
			fKillmoves[fCnt] = (Game.GetFormFromFile(0x82E, "Update.esm") As Idle); pa_KillMoveDWDualSlash - Patch_1.5\Paired_DWKillMoveDualSlash.HKX
			fCnt += 1
			fKillmoves[fCnt] = (Game.GetFormFromFile(0x82F, "Update.esm") As Idle); pa_KillMoveDWXSlash - Patch_1.5\Paired_DWKillMoveXSlash.HKX
			fCnt += 1
		EndIf
	EndIf
	if(RWeaponType == 5); 2H sword
		fKillmoves[fCnt] = (Game.GetFormFromFile(0xF4687, "Skyrim.esm") As Idle); pa_KillMove2HMStabA - Paired_2HMKillMoveStabA.hkx
		fCnt += 1
		bKillmoves[bCnt] = (Game.GetFormFromFile(0x81E, "Update.esm") As Idle) ; pa_KillMove2HMStabFromBehind - Patch_1.5\Paired_2HMKillMoveStabFromBehind.HKX
		bCnt += 1
		fKillmoves[fCnt] = (Game.GetFormFromFile(0x828, "Update.esm") As Idle); pa_KillMove2HM3Slash - Patch_1.5\Paired_2HMKillMove3Slash.hkx
		fCnt += 1
		fKillmoves[fCnt] = (Game.GetFormFromFile(0x829, "Update.esm") As Idle); pa_KillMove2HMSlash - Patch_1.5\Paired_2HMKillMoveSlash.hkx
		fCnt += 1
		fKillmoves[fCnt] = (Game.GetFormFromFile(0x82A, "Update.esm") As Idle); pa_KillMove2HMUnderSwingLeg - Patch_1.5\Paired_2HMKillMoveUnderSwingLeg.HKX
		fCnt += 1
	EndIf
	if(RWeaponType == 6); 2H axe/mace
		bKillmoves[bCnt] = (Game.GetFormFromFile(0x81D, "Update.esm") As Idle); pa_KillMove2HWHackFromBehind - Patch_1.5\Paired_2HWKillMoveHackFromBehind.HKX
		bCnt += 1
		fKillmoves[fCnt] = (Game.GetFormFromFile(0x824, "Update.esm") As Idle); pa_KillMove2HWChopKick - Patch_1.5\Paired_2HWKillMoveChopKick.HKX
		fCnt += 1
		fKillmoves[fCnt] = (Game.GetFormFromFile(0x825, "Update.esm") As Idle); pa_KillMove2HWHeadButt - Patch_1.5\Paired_2HWKillMoveHeadButt.HKX
		fCnt += 1
	EndIf
	if(RWeaponType == 7); Bow
		
	EndIf
	if(RWeaponType == 8); Staff
		
	EndIf
	;any 
	fKillmoves[fCnt] = (Game.GetFormFromFile(0x108A45, "Skyrim.esm") As Idle); pa_KillMoveJ - Paired_1HMKillMoveJ.hkx
	fCnt += 1

	;Killmoves[] =  (Game.GetFormFromFile(0x2FF92, "Skyrim.esm") As Idle); pa_KillMoveC - ???
	;Killmoves[] = (Game.GetFormFromFile(0x55707, "Skyrim.esm") As Idle); pa_KillMoveG - ???
	;Killmoves[] = (Game.GetFormFromFile(0x5570C, "Skyrim.esm") As Idle); pa_KillMoveL - ???
	;Killmoves[] = (Game.GetFormFromFile(0x96800, "Skyrim.esm") As Idle); pa_KillMoveSneakBackA - ???
	;Killmoves[] =  (Game.GetFormFromFile(0xF4690, "Skyrim.esm") As Idle); pa_2HWKillMoveA - ???
	;Killmoves[] = (Game.GetFormFromFile(0x832, "Update.esm") As Idle); pa_KillMoveShieldBashSlash - ???
	fCnt -= 1
	bCnt -= 1
	Log("getKillMoveIdle fKillmoves[" + fCnt + "]: " + fKillmoves)
	Log("getKillMoveIdle bKillmoves[" + bCnt + "]: " + bKillmoves)
	If(backPreffered)
		Return RandomAnim(bKillmoves, fKillmoves, bCnt, fCnt)
	Else
		Return RandomAnim(fKillmoves, bKillmoves, fCnt, bCnt)
	EndIf
EndFunction

Idle Function RandomAnim(Idle[] firstKillmoves, Idle[] secondKillmoves, Int fCnt, Int sCnt)
	Idle anim = None
	If(fCnt >= 0)
		anim = firstKillmoves[Utility.RandomInt(0,fCnt)]
		Log("RandomAnim first: " + anim)
	EndIf
	If (anim == None && sCnt >= 0)
		anim = secondKillmoves[Utility.RandomInt(0,sCnt)]
		Log("RandomAnim second: " + anim)
	EndIf
	Return anim
EndFunction

Function KillMove(Actor Target, Actor Source, Bool IsPlayer)
	If(testPIdle == "REINIT")
		Log("Re-Initialize")
		reInit()
		testPIdle = ""
	EndIf

	Int Attempts
	
    If(!IsPlayer)
		;ActorUtil.AddPackageOverride(Source, blankPackage, 100, 1)
        ;Source.EvaluatePackage()
        ;Source.SetDontMove(True)
		If(Target.GetDistance(Source) > 128)
			Source.MoveTo(Target, 60 * Math.cos(Target.Z), 60 * Math.sin(Target.Z), 0.0, false)
			Attempts = 10
			While(attempts > 0)
				Attempts = Attempts - 1
				if (!Source.Is3DLoaded()) 
					Log("!Is3DLoaded")
					Utility.Wait(0.2)
				Else
					Attempts = 0
				endif
			EndWhile
		EndIf
		;Utility.Wait(3)
	EndIf
	
	;ActorUtil.AddPackageOverride(Target, blankPackage, 100, 1)
	;Target.EvaluatePackage()
	;Target.SetDontMove(True)

	Float zOffset = Source.GetHeadingAngle(Target)
	Source.SetAngle(0.0, 0.0, Source.GetAngleZ() + zOffset)
	Utility.Wait(0.5)
	If IsPlayer && !Source.IsWeaponDrawn()
		Source.DrawWeapon()
		Float i = 3.0
		While (!Source.IsWeaponDrawn() && (i > 0.0))
			Utility.Wait(0.5)
			i -= 0.5
		EndWhile
	Endif

	bool isBack
	Float Fangle = (Target.GetHeadingAngle(Source))
	If ((Fangle < 110) && (Fangle > -110))
		isBack = False
	Else
		isBack = True
	Endif

	Int LWeaponType = Source.GetEquippedItemType(0)
	Int RWeaponType = Source.GetEquippedItemType(1)

	;Utility.Wait(1)
	Idle[] Exclude = new Idle[5]
	Bool Succes = False
	Attempts = 20

	Idle Killmove = getKillMoveIdle(LWeaponType, RWeaponType, Exclude, isBack)

	If(testPIdle != "")
		Killmove = (Game.GetFormFromFile(HexStrToInt(testPIdle), "Skyrim.esm") As Idle)
		testPIdle = ""
	EndIf

	Log("Kill Target: " + Target + "; Source: " + Source + "(Lw-Rw: " + LWeaponType + "-" + RWeaponType + ")" + "; Angle: " + Fangle + "; isBack: " + isBack + "; anim: " + Killmove)
	
	While (!Succes && (Attempts > 0))
		Attempts -= 1
		If Killmove && Source.PlayIdleWithTarget(Killmove, Target)
			;Debug.Notification("KillMove: <" + Killmove.GetName() + ">")
			Succes = True
			If(!IsPlayer)
				Utility.Wait(5)
			EndIf
			Log("KillMove animation success after " + (50-Attempts) + " attempts")
		Endif
	EndWhile
	
	If !Succes
		;If(Killmove == None)
		;	Debug.Notification("KillMove: <NONE> Failed.")
		;Else
		;	Debug.Notification("KillMove: <" + Killmove.GetName() + "> Failed."); .GetFormID()
		;EndIf
		Log("KillMove animation failed. Fallback")
		Float HP = Target.GetActorValue("Health")
		Target.DamageActorValue("Health", HP - 1.0)
		Debug.SendAnimationEvent(Source, "pa_killmove2HM3Slash")
		Utility.Wait(3.0)
		Attempts = 10
		While (!Target.IsDead() && Attempts > 0)
			Attempts -= 1
			Target.Kill(Source)
			Utility.Wait(0.5)
		EndWhile
	Endif

	If(!IsPlayer)
        ;ActorUtil.RemovePackageOverride(Source, blankPackage)
        ;Source.EvaluatePackage()
        ;Source.SetDontMove(False)
		Debug.SendAnimationEvent(Source, "IdleForceDefaultState")
	EndIf

EndFunction

Function Log(String str)
	Debug.Trace("[HP Killmove] " + str)
EndFunction

; debug IdleAnimation
; setpqv andb_acheron_killmove testPIdle_var "0F4679"
int Function HexStrToInt(string hex) 
	string characters = "0123456789abcdef"

	int[] characterValues = new int[16]
	; 0 - 9
	characterValues[0] = 48 ; 0
	characterValues[1] = 49 ; 1
	characterValues[2] = 50 ; 2
	characterValues[3] = 51 ; 3
	characterValues[4] = 52 ; 4
	characterValues[5] = 53 ; 5
	characterValues[6] = 54 ; 6
	characterValues[7] = 55 ; 7
	characterValues[8] = 56 ; 8
	characterValues[9] = 57 ; 9
	; A - F
	characterValues[10] = 65 ; A
	characterValues[11] = 66 ; B
	characterValues[12] = 67 ; C
	characterValues[13] = 68 ; D
	characterValues[14] = 69 ; E
	characterValues[15] = 70 ; F

	int decimal
	int base = 1

	int index = 5
	while index >= 0
		string character = StringUtil.Substring(hex, index, 1)
		int characterIndex = StringUtil.Find(characters, character)
		int characterValue = characterValues[characterIndex]

		if characterValue >= 48 && characterValue <= 57 ; 0 - 9
			decimal = decimal + (characterValue - 48) * base
			base = base * 16
		elseIf characterValue >= 65 && characterValue <= 70 ; A - F
			decimal = decimal + (characterValue - 55) * base
			base = base * 16
		endIf

		index -= 1
	endWhile
	return decimal
EndFunction