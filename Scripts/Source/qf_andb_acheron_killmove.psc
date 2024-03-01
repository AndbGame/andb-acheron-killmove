;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname qf_andb_acheron_killmove Extends Quest Hidden

;BEGIN ALIAS PROPERTY PlayerAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerAlias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE andb_acheron_killmove
Quest __temp = self as Quest
andb_acheron_killmove kmyQuest = __temp as andb_acheron_killmove
;END AUTOCAST
;BEGIN CODE
kmyQuest.Log("stage 0")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE andb_acheron_killmove
Quest __temp = self as Quest
andb_acheron_killmove kmyQuest = __temp as andb_acheron_killmove
;END AUTOCAST
;BEGIN CODE
kmyQuest.Log("stage 1")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN AUTOCAST TYPE andb_acheron_killmove
Quest __temp = self as Quest
andb_acheron_killmove kmyQuest = __temp as andb_acheron_killmove
;END AUTOCAST
;BEGIN CODE
kmyQuest.Log("stage 10: reInit")
kmyQuest.reInit()
Reset()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN AUTOCAST TYPE andb_acheron_killmove
Quest __temp = self as Quest
andb_acheron_killmove kmyQuest = __temp as andb_acheron_killmove
;END AUTOCAST
;BEGIN CODE
kmyQuest.Log("stage 20: deInit")
kmyQuest.deInit()
Reset()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
