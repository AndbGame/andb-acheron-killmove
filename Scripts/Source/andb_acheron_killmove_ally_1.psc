Scriptname andb_acheron_killmove_ally_1 extends Quest

andb_acheron_killmove Property killmoveQuest Auto
ReferenceAlias Property refTarget Auto
ReferenceAlias Property refAlly Auto

Function killTarget(Actor target)
	If(!IsStageDone(10) && !refTarget.GetReference() && refAlly.GetReference())
		refTarget.ForceRefTo(target)
		GotoState("Started")
		RegisterForSingleUpdate(10)
		setStage(10)
	Else
		Stop()
		killmoveQuest.Log("Error on killTarget by andb_acheron_killmove_ally_1. Already running")
	EndIf
EndFunction

Function ApproachStarted()
	GotoState("ApproachStarted")
EndFunction

Function readyForKill()
EndFunction

Event OnUpdate()
	UnregisterForUpdate()
	GotoState("")
	Stop()
EndEvent

State Started
EndState

State ApproachStarted
	Event OnUpdate()
		readyForKill()
	EndEvent

	Function readyForKill()
		UnregisterForUpdate()
		GotoState("")
		ObjectReference Target = refTarget.GetReference()
		ObjectReference Ally = refAlly.GetReference()
		killmoveQuest.Log("Distance for kill: " + Ally.GetDistance(Target))
		If(Target && Ally && Target.is3DLoaded() && Ally.is3DLoaded() && Ally.GetDistance(Target) < 500)
			killmoveQuest.KillMove(Target as Actor, Ally as Actor, false)
		EndIf
		Stop()
	EndFunction
EndState