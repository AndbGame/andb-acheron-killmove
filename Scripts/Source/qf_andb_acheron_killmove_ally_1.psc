;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 101
Scriptname qf_andb_acheron_killmove_ally_1 Extends Quest Hidden

;BEGIN ALIAS PROPERTY PlayerAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerAlias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE andb_acheron_killmove_ally_1
Quest __temp = self as Quest
andb_acheron_killmove_ally_1 kmyQuest = __temp as andb_acheron_killmove_ally_1
;END AUTOCAST
;BEGIN CODE
kmyQuest.killmoveQuest.Log("killmove_ally_1: stage 0")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN AUTOCAST TYPE andb_acheron_killmove_ally_1
Quest __temp = self as Quest
andb_acheron_killmove_ally_1 kmyQuest = __temp as andb_acheron_killmove_ally_1
;END AUTOCAST
;BEGIN CODE
kmyQuest.killmoveQuest.Log("killmove_ally_1: stage 10; Start scene")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN AUTOCAST TYPE andb_acheron_killmove_ally_1
Quest __temp = self as Quest
andb_acheron_killmove_ally_1 kmyQuest = __temp as andb_acheron_killmove_ally_1
;END AUTOCAST
;BEGIN CODE
kmyQuest.killmoveQuest.Log("killmove_ally_1: stage 20; Scene Start Approach")
kmyQuest.ApproachStarted()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_100
Function Fragment_100()
;BEGIN AUTOCAST TYPE andb_acheron_killmove_ally_1
Quest __temp = self as Quest
andb_acheron_killmove_ally_1 kmyQuest = __temp as andb_acheron_killmove_ally_1
;END AUTOCAST
;BEGIN CODE
kmyQuest.killmoveQuest.Log("killmove_ally_1: stage 100; Scene Start kill")
kmyQuest.readyForKill()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
