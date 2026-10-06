-- ========== Tactician Enhanced CharacterEffectDefs Overhaul Begin ==========

function OnMsg.DataLoaded()
-- ========== TE Perk-Specialization Overhaul ==========
  --Teacher
  local param0 = table.find_value(CharacterEffectDefs.Teacher.Parameters, "Name", "squad_exp_bonus")
  param0.Value = 25 -- Default 10
  
  --Ambidextrous
  local param1 = table.find_value(CharacterEffectDefs.Ambidextrous.Parameters, "Name", "PenaltyReduction")
  param1.Value = 25 -- Default 15
  
  --AutoWeapons
  local param2 = table.find_value(CharacterEffectDefs.AutoWeapons.Parameters, "Name", "automatics_penalty_reduction")
  param2.Value = 50 -- Default 50
  
  --CQCTraining
  local param3 = table.find_value(CharacterEffectDefs.CQCTraining.Parameters, "Name", "cqc_bonus_max")
  param3.Value = 45 -- Default 20
  local param4 = table.find_value(CharacterEffectDefs.CQCTraining.Parameters, "Name", "cqc_bonus_loss_per_tile")
  param4.Value = 3 -- Default 2
  
  --HeavyWeaponsTraining
  local param5 = table.find_value(CharacterEffectDefs.HeavyWeaponsTraining.Parameters, "Name", "ap_cost_reduction")
  param5.Value = 2 -- Default 1
  local param6 = table.find_value(CharacterEffectDefs.HeavyWeaponsTraining.Parameters, "Name", "min_ap_cost")
  param6.Value = 1 -- Default 1
  
  --MartialArts
  local param7 = table.find_value(CharacterEffectDefs.MartialArts.Parameters, "Name", "hit")
  param7.Value = 50 -- Default 15
  local param8 = table.find_value(CharacterEffectDefs.MartialArts.Parameters, "Name", "defense")
  param8.Value = 50 -- Default 15
  
  --MrFixit
  local param9 = table.find_value(CharacterEffectDefs.MrFixit.Parameters, "Name", "mrfixit_bonus")
  param9.Value = 50 -- Default 15
  local param10 = table.find_value(CharacterEffectDefs.MrFixit.Parameters, "Name", "mrfixit_ap")
  param10.Value = 1 -- Default 1
  
  --NightOps
  local param11 = table.find_value(CharacterEffectDefs.NightOps.Parameters, "Name", "night_vision_penalty_reduction")
  param11.Value = 12 -- Default 50 (less is better!) -- !!!Do NOT Change this one!!! (TE Core Logic)
  local param12 = table.find_value(CharacterEffectDefs.NightOps.Parameters, "Name", "night_acc_penalty_reduction")
  param12.Value = 50 -- Default 66
  
  --Stealthy
  local param13 = table.find_value(CharacterEffectDefs.Stealthy.Parameters, "Name", "stealthy_detection")
  param13.Value = 0 -- Default 20 -- !!!Do NOT Change this one!!! (TE Core Logic)
  local param14 = table.find_value(CharacterEffectDefs.Stealthy.Parameters, "Name", "stealthkill")
  param14.Value = 15 -- Default 10
  local param15 = table.find_value(CharacterEffectDefs.Stealthy.Parameters, "Name", "stealthkill_minchance")
  param15.Value = 33 -- Default 30
  
  --Throwing
  local param16 = table.find_value(CharacterEffectDefs.Throwing.Parameters, "Name", "RangeIncrease")
  param16.Value = 4 -- Default 3
  local param17 = table.find_value(CharacterEffectDefs.Throwing.Parameters, "Name", "FirstThrowCostReduction")
  param17.Value = 4 -- Default 3
  
-- ========== TE Perk-Personality Overhaul ==========
  --Negotiator
  local param18 = table.find_value(CharacterEffectDefs.Negotiator.Parameters, "Name", "discountPercent")
  param18.Value = 33 -- Default 20
  
-- ========== TE Perk-Quirk Overhaul ==========
  --Hemophobic
  local param19 = table.find_value(CharacterEffectDefs.Hemophobic.Parameters, "Name", "procChance")
  param19.Value = 25 -- Default 20
  
  --Loner
  local param20 = table.find_value(CharacterEffectDefs.Loner.Parameters, "Name", "loner_radius")
  param20.Value = 25 -- Default 25
  
  --OldDog
  local param21 = table.find_value(CharacterEffectDefs.OldDog.Parameters, "Name", "old_dog_XP_bonus")
  param21.Value = 50 -- Default 10
  
  --Optimist
  local param22 = table.find_value(CharacterEffectDefs.Optimist.Parameters, "Name", "procChance")
  param22.Value = 25 -- Default 10
  
  --Pessimist
  local param23 = table.find_value(CharacterEffectDefs.Pessimist.Parameters, "Name", "procChance")
  param23.Value = 25 -- Default 10
  
  --Psycho
  local param24 = table.find_value(CharacterEffectDefs.Psycho.Parameters, "Name", "procChance")
  param24.Value = 5 -- Default 3
  
  --Spiritual
  local param25 = table.find_value(CharacterEffectDefs.Spiritual.Parameters, "Name", "minAccuracy")
  param25.Value = 5 -- Default 3
  
-- ========== TE Perk-Personal Overhaul ==========
  --Bloodthirst
  local param26 = table.find_value(CharacterEffectDefs.Bloodthirst.Parameters, "Name", "damageMod")
  param26.Value = 50 -- Default 20

  --BuildingConfidence
  local param27 = table.find_value(CharacterEffectDefs.BuildingConfidence.Parameters, "Name", "turnToProc")
  param27.Value = 1 -- Default 2
  local param28 = table.find_value(CharacterEffectDefs.BuildingConfidence.Parameters, "Name", "chanceToProc")
  param28.Value = 100 -- Default 50

  --BunsPerk
  local param29 = table.find_value(CharacterEffectDefs.BunsPerk.Parameters, "Name", "CtHBonus")
  param29.Value = 25 -- Default 10

  --DangerClose
  local param30 = table.find_value(CharacterEffectDefs.DangerClose.Parameters, "Name", "damageMod")
  param30.Value = 50 -- Default 40
  local param31 = table.find_value(CharacterEffectDefs.DangerClose.Parameters, "Name", "rangeThreshold")
  param31.Value = 5 -- Default 5
  
  --DesignerExplosives
  local param32 = table.find_value(CharacterEffectDefs.DesignerExplosives.Parameters, "Name", "hoursToProduce")
  param32.Value = 72 -- Default 168
  local param33 = table.find_value(CharacterEffectDefs.DesignerExplosives.Parameters, "Name", "amountToProduce")
  param33.Value = 3 -- Default 2
  
  --Drunk
  local param34 = table.find_value(CharacterEffectDefs.Drunk.Parameters, "Name", "melee_damage_mod")
  param34.Value = 50 -- Default 40
  
  --EyesOnTheBack
  local param35 = table.find_value(CharacterEffectDefs.EyesOnTheBack.Parameters, "Name", "cone_angle")
  param35.Value = 360 -- Default 360
  
  --FleetingShadow
  local param36 = table.find_value(CharacterEffectDefs.FleetingShadow.Parameters, "Name", "gritOnStealthKill")
  param36.Value = 25 -- Default 10
  
  --Focused
  local param37 = table.find_value(CharacterEffectDefs.Focused.Parameters, "Name", "bonus_damage")
  param37.Value = 33 -- Default 25
  local param38 = table.find_value(CharacterEffectDefs.Focused.Parameters, "Name", "gritGain")
  param38.Value = 25 -- Default 15
  
  --GloryHog
  local param39 = table.find_value(CharacterEffectDefs.GloryHog.Parameters, "Name", "temp_hp")
  param39.Value = 25 -- Default 15
  
  --HawksEye
  local param40 = table.find_value(CharacterEffectDefs.HawksEye.Parameters, "Name", "pindownCostOverwrite")
  param40.Value = 1 -- Default 1

  --KillingWind
  local param41 = table.find_value(CharacterEffectDefs.KillingWind.Parameters, "Name", "gritPerEnemyHit")
  param41.Value = 15 -- Default 8

  --MakeThemBleed
  local param42 = table.find_value(CharacterEffectDefs.MakeThemBleed.Parameters, "Name", "damagePerBleed")
  param42.Value = 20 -- Default 10
  local param43 = table.find_value(CharacterEffectDefs.MakeThemBleed.Parameters, "Name", "maxStacks")
  param43.Value = 5 -- Default 5

  --NaturalHealing
  local param44 = table.find_value(CharacterEffectDefs.NaturalHealing.Parameters, "Name", "hoursToProduce")
  param44.Value = 24 -- Default 48
  local param45 = table.find_value(CharacterEffectDefs.NaturalHealing.Parameters, "Name", "amountToProduce")
  param45.Value = 2 -- Default 1

  --Nazdarovya
  local param46 = table.find_value(CharacterEffectDefs.Nazdarovya.Parameters, "Name", "temphpdrunk")
  param46.Value = 45 -- Default 25

  --SecondStoryMan
  local param47 = table.find_value(CharacterEffectDefs.SecondStoryMan.Parameters, "Name", "critChance")
  param47.Value = 50 -- Default 50

  --ShoulderToShoulder
  local param48 = table.find_value(CharacterEffectDefs.ShoulderToShoulder.Parameters, "Name", "tempHp")
  param48.Value = 25 -- Default 15

  --SidneyPerk
  local param49 = table.find_value(CharacterEffectDefs.SidneyPerk.Parameters, "Name", "APBuff")
  param49.Value = 3 -- Default 2

  --TagTeam
  local param50 = table.find_value(CharacterEffectDefs.TagTeam.Parameters, "Name", "accuracyBonus")
  param50.Value = 50 -- Default 15

  --TheGrim
  local param51 = table.find_value(CharacterEffectDefs.TheGrim.Parameters, "Name", "fearAoE")
  param51.Value = 10 -- Default 8

  --WeGotThis
  local param52 = table.find_value(CharacterEffectDefs.WeGotThis.Parameters, "Name", "tempHp")
  param52.Value = 25 -- Default 10

  --WeaponPersonalization
  local param53 = table.find_value(CharacterEffectDefs.WeaponPersonalization.Parameters, "Name", "baseDamageBonus")
  param53.Value = 15 -- Default 10
  local param54 = table.find_value(CharacterEffectDefs.WeaponPersonalization.Parameters, "Name", "critChanceBonus")
  param54.Value = 15 -- Default 15
  local param55 = table.find_value(CharacterEffectDefs.WeaponPersonalization.Parameters, "Name", "conditionPerHour")
  param55.Value = 5 -- Default 1

  --YouSeeIgor
  local param56 = table.find_value(CharacterEffectDefs.YouSeeIgor.Parameters, "Name", "APRestore")
  param56.Value = 3 -- Default 3

-- ========== TE Perk-Health Overhaul ==========
  --OptimalPerformance
  local param57 = table.find_value(CharacterEffectDefs.OptimalPerformance.Parameters, "Name", "temp_HP_on_melee")
  param57.Value = 20 -- Default = 15
  
  --BeefedUp
  local param58 = table.find_value(CharacterEffectDefs.BeefedUp.Parameters, "Name", "bonus_health")
  param58.Value = 25 -- Default = 20
  
  --HitTheDeck
  local param59 = table.find_value(CharacterEffectDefs.HitTheDeck.Parameters, "Name", "explosiveLessDamage")
  param59.Value = 25 -- Default = 20
  
  --Berserker
  local param60 = table.find_value(CharacterEffectDefs.Berserker.Parameters, "Name", "damageBonus")
  param60.Value = 20 -- Default = 10
  
  --Shatterhand
  local param61 = table.find_value(CharacterEffectDefs.Shatterhand.Parameters, "Name", "hp_loss_percent")
  param61.Value = 0 -- Default = 15
  local param62 = table.find_value(CharacterEffectDefs.Shatterhand.Parameters, "Name", "penaltyPerRetaliation")
  param62.Value = 0 -- Default = 20
  
  --TrueGrit
  local param63 = table.find_value(CharacterEffectDefs.TrueGrit.Parameters, "Name", "outOfCoverGrit")
  param63.Value = 25 -- Default = 15
  local param64 = table.find_value(CharacterEffectDefs.TrueGrit.Parameters, "Name", "nextToEnemyGrit")
  param64.Value = 25 -- Default = 15
  
  --HoldPosition
  local param65 = table.find_value(CharacterEffectDefs.HoldPosition.Parameters, "Name", "percentHealth")
  param65.Value = 66 -- Default 50
  
  --Hardened
  local param66 = table.find_value(CharacterEffectDefs.Hardened.Parameters, "Name", "maxReservedAP")
  param66.Value = 9 -- Default 3
  local param67 = table.find_value(CharacterEffectDefs.Hardened.Parameters, "Name", "tempHPperAP")
  param67.Value = 5 -- Default 5
  
  --BattleFocus
  local param68 = table.find_value(CharacterEffectDefs.BattleFocus.Parameters, "Name", "battleFocusAP")
  param68.Value = 3 -- Default 2
  
-- ========== TE Perk-Agility Overhaul ==========
  --Flanker
  local param69 = table.find_value(CharacterEffectDefs.Flanker.Parameters, "Name", "damageBonus")
  param69.Value = 33 -- Default 15
  
  --SteadyBreathing
  local param70 = table.find_value(CharacterEffectDefs.SteadyBreathing.Parameters, "Name", "freeMoveBonusAp")
  param70.Value = 4 -- Default 3
  
  --RelentlessAdvance
  local param71 = table.find_value(CharacterEffectDefs.RelentlessAdvance.Parameters, "Name", "free_move_mult")
  param71.Value = 2 -- Default 2
  
  --DeathFromAbove
  local param72 = table.find_value(CharacterEffectDefs.DeathFromAbove.Parameters, "Name", "highground_cth_bonus")
  param72.Value = 20 -- Default 10
  local param73 = table.find_value(CharacterEffectDefs.DeathFromAbove.Parameters, "Name", "vertical_cost_modifier")
  param73.Value = -40 -- Default -20
  
  --LuckyStreak
  local param74 = table.find_value(CharacterEffectDefs.LuckyStreak.Parameters, "Name", "crits_number")
  param74.Value = 2 -- Default 2
  
  --ColdHeart
  local param75 = table.find_value(CharacterEffectDefs.ColdHeart.Parameters, "Name", "crit_bonus")
  param75.Value = 50 -- Default 50
  
  --SingularPurpose
  local param76 = table.find_value(CharacterEffectDefs.SingularPurpose.Parameters, "Name", "damageBonus")
  param76.Value = 33 -- Default 30
  
-- ========== TE Perk-Dexterity Overhaul ==========
  --Untraceable
  local param77 = table.find_value(CharacterEffectDefs.Untraceable.Parameters, "Name", "enemy_detection_reduction")
  param77.Value = 90 -- Default 30
  local param78 = table.find_value(CharacterEffectDefs.Untraceable.Parameters, "Name", "stealth_damage")
  param78.Value = 33 -- Default 20

  --Deadeye
  local param79 = table.find_value(CharacterEffectDefs.Deadeye.Parameters, "Name", "crit_per_aim")
  param79.Value = 5 -- Default 5

  --Counterfire
  local param80 = table.find_value(CharacterEffectDefs.Counterfire.Parameters, "Name", "hitsRequired")
  param80.Value = 2 -- Default 2

  --Hotblood
  local param81 = table.find_value(CharacterEffectDefs.Hotblood.Parameters, "Name", "baseChance")
  param81.Value = 100 -- Default = 50
  local param82 = table.find_value(CharacterEffectDefs.Hotblood.Parameters, "Name", "penaltyPerRetaliation")
  param82.Value = 0 -- Default = 20
  
  --Infiltrator
  local param83 = table.find_value(CharacterEffectDefs.Infiltrator.Parameters, "Name", "stealthkill_chance")
  param83.Value = 15 -- Default 10
  
  --Instagib
  local param84 = table.find_value(CharacterEffectDefs.Instagib.Parameters, "Name", "marksmanshipPercent")
  param84.Value = 50 -- Default 33
  local param85 = table.find_value(CharacterEffectDefs.Instagib.Parameters, "Name", "bonusAims")
  param85.Value = 2 -- Default 2
  
  --Virtuoso
  local param86 = table.find_value(CharacterEffectDefs.Virtuoso.Parameters, "Name", "virtuosoStealthKillChance")
  param86.Value = 60 -- Default 15
  
-- ========== TE Perk-Strength Overhaul ==========
  --TakeAim
  local param87 = table.find_value(CharacterEffectDefs.TakeAim.Parameters, "Name", "chanceToHitBonus")
  param87.Value = 15 -- Default = 10

  --BloodlustPerk
  local param88 = table.find_value(CharacterEffectDefs.BloodlustPerk.Parameters, "Name", "Str_to_bonus_dmg_conversion")
  param88.Value = 50 -- Default = 50

  --InstantAutopsy
  local param89 = table.find_value(CharacterEffectDefs.InstantAutopsy.Parameters, "Name", "crit_bonus")
  param89.Value = 50 -- Default = 30

  --CollateralDamage
  local param90 = table.find_value(CharacterEffectDefs.CollateralDamage.Parameters, "Name", "enemyDamageMod")
  param90.Value = 25 -- Default = 15
  local param91 = table.find_value(CharacterEffectDefs.CollateralDamage.Parameters, "Name", "objectDamageMod")
  param91.Value = 50 -- Default = 30

-- ========== TE Perk-Wisdom Overhaul ==========
  --Savior
  local param92 = table.find_value(CharacterEffectDefs.Savior.Parameters, "Name", "bandageBonus")
  param92.Value = 50 -- Default = 30

  --LastWarning
  local param93 = table.find_value(CharacterEffectDefs.LastWarning.Parameters, "Name", "panic_chance")
  param93.Value = 33 -- Default = 15

  --LeadFromTheFront
  local param94 = table.find_value(CharacterEffectDefs.LeadFromTheFront.Parameters, "Name", "moraleBonus")
  param94.Value = 1 -- Default = 1
  local param95 = table.find_value(CharacterEffectDefs.LeadFromTheFront.Parameters, "Name", "damageTreshold")
  param95.Value = 50 -- Default = 50

  --ShockAndAwe
  local param96 = table.find_value(CharacterEffectDefs.ShockAndAwe.Parameters, "Name", "highMoraledmgBuff")
  param96.Value = 25 -- Default = 10

  --Caretaker
  local param97 = table.find_value(CharacterEffectDefs.Caretaker.Parameters, "Name", "medicalPercent")
  param97.Value = 45 -- Default = 33

-- ========== TE Perk-NPC Overhaul ==========
  --Enfilade
  local param98 = table.find_value(CharacterEffectDefs.Enfilade.Parameters, "Name", "damage_bonus")
  param98.Value = 50 -- Default 30
  
  --LightningReactionNPC
  local param99 = table.find_value(CharacterEffectDefs.LightningReactionNPC.Parameters, "Name", "chance")
  param99.Value = 100 -- Default 50

  --NaturalCamouflage
  local param100 = table.find_value(CharacterEffectDefs.NaturalCamouflage.Parameters, "Name", "sight_mod")
  param100.Value = 0 -- Default -40 -- !!!Do NOT Change this one!!! (JA2 Core Logic)

  --OverwatchExpert
  local param101 = table.find_value(CharacterEffectDefs.OverwatchExpert.Parameters, "Name", "bonusAttacks")
  param101.Value = 2 -- Default 1

  --SharpInstincts
  local param102 = table.find_value(CharacterEffectDefs.SharpInstincts.Parameters, "Name", "tempHP")
  param102.Value = 20 -- Default 15

  --SixthSense
  local param103 = table.find_value(CharacterEffectDefs.SixthSense.Parameters, "Name", "tempHitPoints")
  param103.Value = 20 -- Default 15

  --StealthKillDefense
  local param104 = table.find_value(CharacterEffectDefs.StealthKillDefense.Parameters, "Name", "kill_chance_mod")
  param104.Value = 45 -- Default 40

-- ========== TE Buff/Debuff Overhaul ==========
  
  --Bleeding
  local param105 = table.find_value(CharacterEffectDefs.Bleeding.Parameters, "Name", "DamagePerTurn")
  param105.Value = 15 -- Default 5
  local param106 = table.find_value(CharacterEffectDefs.Bleeding.Parameters, "Name", "APLoss")
  param106.Value = -2 -- Default -1
  local param107 = table.find_value(CharacterEffectDefs.Bleeding.Parameters, "Name", "cth_penalty")
  param107.Value = -15 -- Default -10
  
  --BleedingOut
  local param108 = table.find_value(CharacterEffectDefs.BleedingOut.Parameters, "Name", "add_penalty")
  param108.Value = 0 -- Default -20
  
  --Burning
  local param109 = table.find_value(CharacterEffectDefs.Burning.Parameters, "Name", "damage")
  param109.Value = 25 -- Default 15
  
  --Choking
  local param110 = table.find_value(CharacterEffectDefs.Choking.Parameters, "Name", "damage")
  param110.Value = 45 -- Default 30
  
  --Exhausted
  local param111 = table.find_value(CharacterEffectDefs.Exhausted.Parameters, "Name", "ap_loss")
  param111.Value = -4 -- Default -3
  local param112 = table.find_value(CharacterEffectDefs.Exhausted.Parameters, "Name", "duration")
  param112.Value = 12 -- Default 12
  
  --Flanked
  local param113 = table.find_value(CharacterEffectDefs.Flanked.Parameters, "Name", "bonus")
  param113.Value = 25 -- Default 20

  --Heroic
  local param114 = table.find_value(CharacterEffectDefs.Heroic.Parameters, "Name", "ap_gain")
  param114.Value = 5 -- Default 5
  local param115 = table.find_value(CharacterEffectDefs.Heroic.Parameters, "Name", "bonus_cth")
  param115.Value = 15 -- Default 10
  
  --Hidden
  local param116 = table.find_value(CharacterEffectDefs.Hidden.Parameters, "Name", "ap_cost_modifier")
  param116.Value = 50 -- Default 30 -- !!!Do NOT Change this one!!! (JA2 Core Logic)

  --Inaccurate
  local param117 = table.find_value(CharacterEffectDefs.Inaccurate.Parameters, "Name", "accuracy_modifier")
  param117.Value = -45 -- Default -20

  --Inspired
  local param118 = table.find_value(CharacterEffectDefs.Inspired.Parameters, "Name", "bonus")
  param118.Value = 5 -- Default 4

  --Mobile
  local param119 = table.find_value(CharacterEffectDefs.Mobile.Parameters, "Name", "move_ap_modifier")
  param119.Value = 50 -- Default 50

  --Protected
  local param120 = table.find_value(CharacterEffectDefs.Protected.Parameters, "Name", "base_chance")
  param120.Value = 100 -- Default 80
  local param121 = table.find_value(CharacterEffectDefs.Protected.Parameters, "Name", "max_ap_carried")
  param121.Value = 5 -- Default 5

  --Slowed
  local param122 = table.find_value(CharacterEffectDefs.Slowed.Parameters, "Name", "move_ap_modifier")
  param122.Value = 150 -- Default 300

  --Suppressed
  local param123 = table.find_value(CharacterEffectDefs.Suppressed.Parameters, "Name", "ap_loss")
  param123.Value = -5 -- Default -4

  --Stimmed
  local param124 = table.find_value(CharacterEffectDefs.Stimmed.Parameters, "Name", "apGain")
  param124.Value = 5 -- Default 4

  --Tired
  local param125 = table.find_value(CharacterEffectDefs.Tired.Parameters, "Name", "ap_loss")
  param125.Value = -2 -- Default -1
  local param126 = table.find_value(CharacterEffectDefs.Tired.Parameters, "Name", "duration")
  param126.Value = 12 -- Default 12

  --Unconscious
  local param127 = table.find_value(CharacterEffectDefs.Unconscious.Parameters, "Name", "recovery_delay_turns")
  param127.Value = 3 -- Default 2
  local param128 = table.find_value(CharacterEffectDefs.Unconscious.Parameters, "Name", "recovery_delay_seconds")
  param128.Value = 15 -- Default 10

  --Unwell
  local param129 = table.find_value(CharacterEffectDefs.Unwell.Parameters, "Name", "range_cth_mod")
  param129.Value = -40 -- Default -20

  --WellRested
  local param130 = table.find_value(CharacterEffectDefs.WellRested.Parameters, "Name", "ap_gain")
  param130.Value = 2 -- Default 1

  --Perk-Specialization
  CharacterEffectDefs.Teacher:PostLoad()
  CharacterEffectDefs.Ambidextrous:PostLoad()
  CharacterEffectDefs.AutoWeapons:PostLoad()
  CharacterEffectDefs.CQCTraining:PostLoad()
  CharacterEffectDefs.HeavyWeaponsTraining:PostLoad()
  CharacterEffectDefs.MartialArts:PostLoad()
  CharacterEffectDefs.MrFixit:PostLoad()
  CharacterEffectDefs.NightOps:PostLoad()
  CharacterEffectDefs.Stealthy:PostLoad()
  CharacterEffectDefs.Throwing:PostLoad()
  --Perk-Quirk
  CharacterEffectDefs.Hemophobic:PostLoad()
  CharacterEffectDefs.Loner:PostLoad()
  CharacterEffectDefs.OldDog:PostLoad()
  CharacterEffectDefs.Optimist:PostLoad()
  CharacterEffectDefs.Pessimist:PostLoad()
  CharacterEffectDefs.Psycho:PostLoad()
  CharacterEffectDefs.Spiritual:PostLoad()
  --Perk-Personality
  CharacterEffectDefs.Negotiator:PostLoad()
  --Perk-Personal
  CharacterEffectDefs.Bloodthirst:PostLoad()
  CharacterEffectDefs.BuildingConfidence:PostLoad()
  CharacterEffectDefs.BunsPerk:PostLoad()
  CharacterEffectDefs.DangerClose:PostLoad()
  CharacterEffectDefs.DesignerExplosives:PostLoad()
  CharacterEffectDefs.Drunk:PostLoad()
  CharacterEffectDefs.EyesOnTheBack:PostLoad()
  CharacterEffectDefs.FleetingShadow:PostLoad()
  CharacterEffectDefs.Focused:PostLoad()
  CharacterEffectDefs.GloryHog:PostLoad()
  CharacterEffectDefs.HawksEye:PostLoad()
  CharacterEffectDefs.KillingWind:PostLoad()
  CharacterEffectDefs.MakeThemBleed:PostLoad()
  CharacterEffectDefs.NaturalHealing:PostLoad()
  CharacterEffectDefs.Nazdarovya:PostLoad()
  CharacterEffectDefs.SecondStoryMan:PostLoad()
  CharacterEffectDefs.ShoulderToShoulder:PostLoad()
  CharacterEffectDefs.SidneyPerk:PostLoad()
  CharacterEffectDefs.TagTeam:PostLoad()
  CharacterEffectDefs.TheGrim:PostLoad()
  CharacterEffectDefs.WeGotThis:PostLoad()
  CharacterEffectDefs.WeaponPersonalization:PostLoad()
  CharacterEffectDefs.YouSeeIgor:PostLoad()
  --Perk-Health
  CharacterEffectDefs.OptimalPerformance:PostLoad()
  CharacterEffectDefs.BeefedUp:PostLoad()
  CharacterEffectDefs.HitTheDeck:PostLoad()
  CharacterEffectDefs.Berserker:PostLoad()
  CharacterEffectDefs.Shatterhand:PostLoad()
  CharacterEffectDefs.TrueGrit:PostLoad()
  CharacterEffectDefs.HoldPosition:PostLoad()
  CharacterEffectDefs.Hardened:PostLoad()
  CharacterEffectDefs.BattleFocus:PostLoad()
  --Perk-Agility
  CharacterEffectDefs.Flanker:PostLoad()
  CharacterEffectDefs.SteadyBreathing:PostLoad()
  CharacterEffectDefs.RelentlessAdvance:PostLoad()
  CharacterEffectDefs.DeathFromAbove:PostLoad()
  CharacterEffectDefs.LuckyStreak:PostLoad()
  CharacterEffectDefs.ColdHeart:PostLoad()
  CharacterEffectDefs.SingularPurpose:PostLoad()
  --Perk-Dexterity
  CharacterEffectDefs.Untraceable:PostLoad()
  CharacterEffectDefs.Deadeye:PostLoad()
  CharacterEffectDefs.Counterfire:PostLoad()
  CharacterEffectDefs.Hotblood:PostLoad()
  CharacterEffectDefs.Infiltrator:PostLoad()
  CharacterEffectDefs.Instagib:PostLoad()
  CharacterEffectDefs.Virtuoso:PostLoad()
  --Perk-Strength
  CharacterEffectDefs.TakeAim:PostLoad()
  CharacterEffectDefs.BloodlustPerk:PostLoad()
  CharacterEffectDefs.InstantAutopsy:PostLoad()
  CharacterEffectDefs.CollateralDamage:PostLoad()
  --Perk-Wisdom
  CharacterEffectDefs.Savior:PostLoad()
  CharacterEffectDefs.LastWarning:PostLoad()
  CharacterEffectDefs.LeadFromTheFront:PostLoad()
  CharacterEffectDefs.ShockAndAwe:PostLoad()
  CharacterEffectDefs.Caretaker:PostLoad()
  --Perk-NPC
  CharacterEffectDefs.Enfilade:PostLoad()
  CharacterEffectDefs.LightningReactionNPC:PostLoad()
  CharacterEffectDefs.NaturalCamouflage:PostLoad()
  CharacterEffectDefs.OverwatchExpert:PostLoad()
  CharacterEffectDefs.SharpInstincts:PostLoad()
  CharacterEffectDefs.SixthSense:PostLoad()
  CharacterEffectDefs.StealthKillDefense:PostLoad()
  --Buff/Debuff
  CharacterEffectDefs.Bleeding:PostLoad()
  CharacterEffectDefs.BleedingOut:PostLoad()
  CharacterEffectDefs.Burning:PostLoad()
  CharacterEffectDefs.Choking:PostLoad()
  CharacterEffectDefs.Exhausted:PostLoad()
  CharacterEffectDefs.Flanked:PostLoad()
  CharacterEffectDefs.Heroic:PostLoad()
  CharacterEffectDefs.Hidden:PostLoad()
  CharacterEffectDefs.Inaccurate:PostLoad()
  CharacterEffectDefs.Inspired:PostLoad()
  CharacterEffectDefs.Mobile:PostLoad()
  CharacterEffectDefs.Protected:PostLoad()
  CharacterEffectDefs.Slowed:PostLoad()
  CharacterEffectDefs.Suppressed:PostLoad()
  CharacterEffectDefs.Stimmed:PostLoad()
  CharacterEffectDefs.Tired:PostLoad()
  CharacterEffectDefs.Unconscious:PostLoad()
  CharacterEffectDefs.Unwell:PostLoad()
  CharacterEffectDefs.WellRested:PostLoad()
end


--IroncladPerk Fixed! --weapon:IsCumbersome() CanUseIroncladPerk!
function Unit:CanUseIroncladPerk()
	local canUse = HasPerk(self, "Ironclad") or self:HasStatusEffect("TacticalEnemy") or self:HasStatusEffect("TestEffects")
    
--	if canUse then
--		local weapons = self:GetHandheldItems()
--		for _, weapon in ipairs(weapons) do
--			if weapon:IsCumbersome() then
--				canUse = false
--				break
--			end
--		end
--	end
	
	return canUse
end


-- ========== GENERATED BY CharacterEffectCompositeDef Editor DO NOT EDIT MANUALLY! ========== -- These are [Tactician Enhanced] CORE Effects and DO NOT EDIT MANUALLY! [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE & JA2 Core Logic)

UndefineClass('Unaware')
DefineClass.Unaware = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "CharacterEffect",
	Conditions = {
		PlaceObj('CheckExpression', {
			Expression = function (self, obj) return not obj.team or not obj.team.neutral end,
		}),
	},
	DisplayName = T(947052613991, --[[CharacterEffectCompositeDef Unaware DisplayName]] "Unaware"),
	Description = T(306118386349, --[[CharacterEffectCompositeDef Unaware Description]] "This character is not aware there are enemies in the Sector but will be alerted by noise or visuals of enemies. Very susceptible to <em>Stealth Kill</em> attempts made by sneaking characters."),
	OnAdded = function (self, obj)
		obj:AddStatusEffect("GlobalSightRange") -- TE Global Visibility Overhaul! [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE Core Logic)
		obj:RemoveStatusEffect("Suspicious")
		obj:RemoveStatusEffect("Surprised")
		Msg("UnitAwarenessChanged", obj)
		if not g_Combat then
			obj:AddStatusEffect("HighAlert") -- AI Stay HighAlert! [!MUST HAVE!] -- !!!Do NOT Change this one!!! (JA2 Core Logic)
		end
	end,
	OnRemoved = function (self, obj)
		obj:RemoveStatusEffect("Distracted")
		obj:RemoveStatusEffect("EnemyFullAlert")
		obj:RemoveStatusEffect("HighAlert")
		Msg("UnitAwarenessChanged", obj)
		if g_Combat then
			g_Combat.end_combat_pending = false
		end
	end,
	Icon = "UI/Hud/Status effects/unaware",
	Shown = true,
}

UndefineClass('Hidden')
DefineClass.Hidden = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "CharacterEffect",
	DisplayName = T(529131675951, --[[CharacterEffectCompositeDef Hidden DisplayName]] "Hidden"),
	Description = T(298232269359, --[[CharacterEffectCompositeDef Hidden Description]] "This character is harder to detect by enemies. Allows <em>Stealth Kill</em> attacks against enemies."),
	OnAdded = function (self, obj)
		if g_Combat then
			obj:AddStatusEffect("GlobalCombatConcealed") -- Combat Concealed Statically while Sneaking [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE + JA2 Core Logic)
		end
		-- remove unit from Revealed tables (visible until end of turn mechanic, NOT Revealed status) [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE + JA2 Core Logic)
		for team, tbl in pairs(g_RevealedUnits) do
			table.remove_value(tbl, obj)
		end
		Msg("UnitStealthChanged", obj) -- this will invalidate visibility and apply the removed reveals automatically [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE + JA2 Core Logic)
		obj:AddStatusEffectImmunity("FreeMove", self.class) -- [Hidden] will invalidate FreeMove ability automatically [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE + JA2 Core Logic)
	end,
	OnRemoved = function (self, obj)
		if g_Combat then
			-- check if visible to any enemies
			for _, team in ipairs(g_Teams) do
				if team:IsEnemySide(obj.team) and HasVisibilityTo(team, obj) then				
					obj:RevealTo(team)
				end
			end
			obj:AddStatusEffect("Revealed") -- this reveals visibility automatically [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE + JA2 Core Logic)
			obj:AddStatusEffect("GlobalVisualContact") -- this reveals visibility automatically [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE + JA2 Core Logic)
			obj:RemoveStatusEffect("GlobalCombatConcealed") -- this will invalidate Concealed and apply the removed Sneaking automatically [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE + JA2 Core Logic)
		end
		Msg("UnitStealthChanged", obj)
		obj:RemoveStatusEffectImmunity("FreeMove", self.class) -- this will restore FreeMove ability automatically [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE + JA2 Core Logic)
	end,
	Icon = "UI/Hud/Status effects/hidden",
	RemoveOnSatViewTravel = true,
	Shown = true,
	HasFloatingText = true,
}

UndefineClass('Darkness')
DefineClass.Darkness = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "CharacterEffect",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnUnitEnterMapVisual",
			Handler = function (self, target)
				target:SetHighlightReason("darkness", false) -- DO NOT Highlight Mercs under darkness PLEASE! [!MUST HAVE!] -- !!!Do NOT Change this one!!! (TE + JA2 Core Logic)
			end,
		}),
	},
	DisplayName = T(770333565093, --[[CharacterEffectCompositeDef Darkness DisplayName]] "In Darkness"),
	Description = "",
	OnAdded = function (self, obj)
		if IsKindOf(obj, "Unit") then
			obj:SetHighlightReason("darkness", false)
		end
	end,
	OnRemoved = function (self, obj)
		if IsKindOf(obj, "Unit") then
			obj:SetHighlightReason("darkness", nil)
		end
	end,
	Icon = "UI/Hud/Status effects/darkness",
}

UndefineClass('Protected')
DefineClass.Protected = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "CharacterEffect",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcStartTurnAP",
			Handler = function (self, target, value)
				value = value + (self:ResolveValue("ap_carried") or 0) -- can be nil if added out of combat
				target:RemoveStatusEffect(self.class) -- remove immediately to unblock AP gain
				return value
			end,
		}),
	},
	DisplayName = T(569020076106, --[[CharacterEffectCompositeDef Protected DisplayName]] "Taking cover"),
	Description = T(682670978880, --[[CharacterEffectCompositeDef Protected Description]] "While coming from the <em>other side</em> of the <em>Cover</em> attacks against this unit have a high chance to become <em>Grazing hits</em> and the targeted body part is selected automatically."),
	OnAdded = function (self, obj)
		if g_Combat or g_StartingCombat or g_TestingSaveLoadSystem then
			obj:RemoveStatusEffect("FreeMove")
			local ap_carry = (not obj:HasStatusEffect("RelentlessAdvance") and Min(self:ResolveValue("max_ap_carried")*const.Scale.AP, obj.ActionPoints)) or (obj:HasStatusEffect("RelentlessAdvance") and Max(self:ResolveValue("max_ap_carried")*const.Scale.AP, 5*const.Scale.AP)) -- New RelentlessAdvance Perk effect!
			self:SetParameter("ap_carried", ap_carry)
			if not obj.infinite_ap then
				obj.ActionPoints = 0
			end
			ObjModified(obj)
		end
		UpdateTakeCoverAction()
	end,
	OnRemoved = function (self, obj)
		UpdateTakeCoverAction()
	end,
	type = "Buff",
	Icon = "UI/Hud/Status effects/protected",
	RemoveOnEndCombat = true,
	Shown = true,
	HasFloatingText = true,
}

UndefineClass('Flanked')
DefineClass.Flanked = {
	__parents = { "StatusEffect" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "StatusEffect",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcDamageAndEffects",
			Handler = function (self, target, attacker, attack_target, action, weapon, attack_args, hit, data)
				if target == attack_target then
					local flankBonus = self:ResolveValue("bonus")
					data.base_damage = MulDivRound(data.base_damage, 100 + flankBonus, 100)
					data.breakdown[#data.breakdown + 1] = { name = self.DisplayName, value = flankBonus }
				end
			end,
		}),
	},
	DisplayName = T(529722665638, --[[CharacterEffectCompositeDef Flanked DisplayName]] "Flanked"),
	Description = T(938831848548, --[[CharacterEffectCompositeDef Flanked Description]] "Threatened from both sides. Attacks against this character have <em>+<percent(bonus)> increased damage</em>."),
	OnAdded = function (self, obj)
		if not obj:IsMerc() and IsNetPlayerTurn() then
			PlayVoiceResponse(obj, "AIFlanked")
		end
	end,
	type = "Debuff",
	Icon = "UI/Hud/Status effects/flanked",
	RemoveOnEndCombat = true,
	dontRemoveOnDeath = true, -- Allow New Flanker Perk work properly!
	Shown = true,
}

UndefineClass('Suppressed')
DefineClass.Suppressed = {
	__parents = { "StatusEffect" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "StatusEffect",
	msg_reactions = {},
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcStartTurnAP",
			Handler = function (self, target, value)
				return value + self:ResolveValue("ap_loss") * const.Scale.AP
			end,
		}),
	},
	DisplayName = T(741267773678, --[[CharacterEffectCompositeDef Suppressed DisplayName]] "Suppressed"),
	Description = T(748124520136, --[[CharacterEffectCompositeDef Suppressed Description]] "Penalty of <em><ap_loss> is applied to your maximum AP</em> for this turn. This character cannot <em>Flank</em> enemies."),
	AddEffectText = T(882347159665, --[[CharacterEffectCompositeDef Suppressed AddEffectText]] "<em><DisplayName></em> is suppressed"),
	OnAdded = function (self, obj)
		obj:ConsumeAP(-self:ResolveValue("ap_loss") * const.Scale.AP)
		obj:TakeSuppressionFire() -- [Suppressed] will force obj ToProneStance!
	end,
	type = "Debuff",
	lifetime = "Until End of Turn",
	Icon = "UI/Hud/Status effects/suppressed",
	RemoveOnEndCombat = true,
	Shown = true,
	HasFloatingText = true,
}

--BloodStains issue fixed!
UndefineClass('Wounded')
DefineClass.Wounded = {
	__parents = { "StatusEffect" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "StatusEffect",
	msg_reactions = {},
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnStatusEffectAdded",
			Handler = function (self, target, id, stacks)
				if self.class == id then
					-- handle add/remove stacks
					RecalcMaxHitPoints(target)
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnStatusEffectRemoved",
			Handler = function (self, target, id, stacks_remaining)
				if self.class == id and stacks_remaining > 0 then
					-- handle add/remove stacks
					RecalcMaxHitPoints(target)	
				end
			end,
		}),
	},
	DisplayName = T(646181611891, --[[CharacterEffectCompositeDef Wounded DisplayName]] "Wounded"),
	Description = T(625596846196, --[[CharacterEffectCompositeDef Wounded Description]] "Maximum <em>HP reduced by <MaxHpReductionPerStack></em> per wound. Cured by the <em>Treat Wounds</em> Operation in the Sat View.\n\n<if(IsGameRuleActive('HeavyWounds'))>Wounds also progressively impair <em>Accuracy</em> and <em>Free Move</em> due to the Heavy Wounds game rule.</if>"),
	OnAdded = function (self, obj)
		RecalcMaxHitPoints(obj)
		
		if not IsKindOf(obj, "Unit") then
			return
		end
		
		if not obj:HasStainType("Blood") then
			local spot = obj:GetEffectValue("wounded_stain_spot")
			if spot then
				obj:AddStain("Blood", spot) -- Fix missing BloodStains!
			end
		end
		
		if not obj.wounded_this_turn and GameState.Heat then
			if not RollSkillCheck(obj, "Health") then
				obj:ChangeTired(1)
			end
		end
		local attackObj = obj.hit_this_turn and obj.hit_this_turn[#obj.hit_this_turn]
		local friendlyFire = attackObj and attackObj.team and obj.team and attackObj.team :IsAllySide(obj.team)
		local effect = obj:GetStatusEffect("Wounded")
		if effect.stacks >= 4 and obj:IsMerc() and not friendlyFire then
			PlayVoiceResponse(obj, "SeriouslyWounded")
		elseif not friendlyFire then
			PlayVoiceResponse(obj, "Wounded")
		end
		obj.wounded_this_turn = true
	end,
	OnRemoved = function (self, obj)
		RecalcMaxHitPoints(obj)		
	end,
	type = "Debuff",
	Icon = "UI/Hud/Status effects/wounded",
	max_stacks = 999,
	Shown = true,
	ShownSatelliteView = true,
}

UndefineClass('BeingBandaged')
DefineClass.BeingBandaged = {
	__parents = { "StatusEffect" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "StatusEffect",
	OnAdded = function (self, obj)
		ObjModified(obj)
	end,
	OnRemoved = function (self, obj)
		if obj:IsMerc() then obj:SetSide("player1") end -- [Bandaged] Mercs will SetSide("player1")
		obj:RemoveStatusEffect("BleedingOut") -- this will invalidate [BleedingOut]
		obj:RemoveStatusEffect("Unconscious") -- this will invalidate [Unconscious]
		ObjModified(obj)
	end,
	RemoveOnSatViewTravel = true,
}

UndefineClass('BleedingOut')
DefineClass.BleedingOut = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "CharacterEffect",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnEndTurn",
			Handler = function (self, target)
				if not IsInCombat() then return end
				if not RollSkillCheck(target, "Health", nil, target.downed_check_penalty) then
					CombatLog("important", T{290150299208, "<em><LogName></em> has <em>bled out</em>", target})
					target:TakeDirectDamage(target:GetTotalHitPoints())
				else
					target.downed_check_penalty = target.downed_check_penalty + self:ResolveValue("add_penalty")
					CombatLog("short", T{333799512710, "<em><LogName></em> is <em>bleeding</em>", target})
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCheckForceMinSight",
			Handler = function (self, target, observer, other, step_pos, darkness)
				if target == observer then
					return true -- [BleedingOut] will invalidate Visibility!
				end
			end,
		}),
	},
	Conditions = {
		PlaceObj('CombatIsActive', {}),
	},
	DisplayName = T(833314215129, --[[CharacterEffectCompositeDef BleedingOut DisplayName]] "Downed"),
	Description = T(588355193847, --[[CharacterEffectCompositeDef BleedingOut Description]] "This character is in <em>Critical condition</em> and will bleed out unless treated with the <em>Bandage</em> action. The character remains alive if a successful check against Health is made next turn."),
	Icon = "UI/Hud/Status effects/bleedingout",
	Shown = true,
}

UndefineClass('Unconscious')
DefineClass.Unconscious = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "CharacterEffect",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnBeginTurn",
			Handler = function (self, target)
				local recovery_turn = self:ResolveValue("recovery_turn")
				local stabilized = target:GetStatusEffect("Stabilized")
				local rally = stabilized and stabilized:ResolveValue("stabilized")
				if not rally and not target:IsDowned() and g_Combat and g_Combat.current_turn >= recovery_turn then -- [Unconscious] cannot self.rally without a medic if target:IsDowned()!
					rally = RollSkillCheck(target, "Health", 50)
				end
				if rally and target:IsDowned() then
					target:SetCommand("DownedRally")
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCheckForceMinSight",
			Handler = function (self, target, observer, other, step_pos, darkness)
				if target == observer then
					return true -- [Unconscious] will invalidate Visibility!
				end
			end,
		}),
--		PlaceObj('UnitReaction', {
--			Event = "OnExplorationTick",
--			Handler = function (self, target)
--				local recovery = self:ResolveValue("recovery_time") 
--				if not target:IsDead() and GameTime() >= recovery then
--					target:SetTired(const.utExhausted)
--					target:SetCommand("DownedRally")
--				end
--			end,
--		}),
	},
	DisplayName = T(132204403941, --[[CharacterEffectCompositeDef Unconscious DisplayName]] "Unconscious"),
	Description = T(801008446056, --[[CharacterEffectCompositeDef Unconscious Description]] "Unconscious and unable to take any action. "),
	AddEffectText = T(964785237678, --[[CharacterEffectCompositeDef Unconscious AddEffectText]] "<em><DisplayName></em> is unconscious"),
	RemoveEffectText = T(208147554823, --[[CharacterEffectCompositeDef Unconscious RemoveEffectText]] "<em><DisplayName></em> regained consciousness"),
	OnAdded = function (self, obj)
		self:SetParameter("recovery_turn", (g_Combat and g_Combat.current_turn or 1) + self:ResolveValue("recovery_delay_turns"))
		self:SetParameter("recovery_time", GameTime() + self:ResolveValue("recovery_delay_seconds") * 1000)
		obj:AddStatusEffectImmunity("Surprised", self.class)
		CreateGameTimeThread(obj.SetCommandIfNotDead, obj, obj.command == "GetDowned" and "Downed" or "KnockDown")
	end,
	OnRemoved = function (self, obj)
		obj:RemoveStatusEffectImmunity("Surprised", self.class)
		if obj.command == "Downed" then
			obj:SetCommand("DownedRally")
		else
			obj:SetTired(Min(obj.Tiredness, const.utExhausted))
		end
	end,
	Icon = "UI/Hud/Status effects/unconscious",
	Shown = true,
	ShownSatelliteView = true,
	HasFloatingText = true,
}

UndefineClass('Bloodthirst')
DefineClass.Bloodthirst = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "CharacterEffect",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcBaseDamage", -- Bloodthirst Increase ALL BaseDamage!
			Handler = function (self, target, weapon, attack_target, data)
				local damageBonus = self:ResolveValue("damageMod")
						
				data.modifier = data.modifier + damageBonus
				data.breakdown[#data.breakdown + 1] = { name = self.DisplayName, value = damageBonus }
			end,
		}),
	},
	DisplayName = T(664271538492, --[[CharacterEffectCompositeDef Bloodthirst DisplayName]] "Bloodthirst"),
	Description = T(616307363329, --[[CharacterEffectCompositeDef Bloodthirst Description]] "Deal <em><percent(damageMod)> more Damage</em> until the end of the battle."),
	Icon = "UI/Hud/Status effects/bloodthirst",
	RemoveOnEndCombat = true,
	Shown = true,
	HasFloatingText = true,
}

UndefineClass('ZombiePerk')
DefineClass.ZombiePerk = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnDamageDone",
			Handler = function (self, target, attack_target, dmg, hit_descr)
				if target and (attack_target ~= nil and target:IsOnEnemySide(attack_target)) and IsKindOf(attack_target, "Unit") then
					local armourItems = attack_target:GetEquipedArmour()
					local weapon = target:GetActiveWeapons("Firearm")
					for _, item in ipairs(armourItems) do
						if (item.Repairable and item.Condition > 0) and not hit_descr.weapon then
							item.Condition = 0 -- B.O.W. MeleeStrike WILL DESTROY ALL Armour!
						end
					end
				end
			end,
		}),
	},
	DisplayName = T(725879214066, --[[CharacterEffectCompositeDef ZombiePerk DisplayName]] "Infected"),
	Description = T(141568768521, --[[CharacterEffectCompositeDef ZombiePerk Description]] "Immune to Suppressed, Bleeding, Inaccurate, and Flanked."),
	OnAdded = function (self, obj)
		obj:AddStatusEffectImmunity("Suppressed", self.class)
		obj:AddStatusEffectImmunity("Bleeding", self.class)
		obj:AddStatusEffectImmunity("Inaccurate", self.class)
		obj:AddStatusEffectImmunity("Flanked", self.class)
		obj:AddStatusEffectImmunity("SuppressionChangeStance", self.class)
		obj:AddStatusEffectImmunity("FreeMove", self.class) -- B.O.W. invaliad Effect!
		obj:AddStatusEffectImmunity("TacticalEnemy", self.class) -- B.O.W. invaliad Effect!
		obj:AddStatusEffectImmunity("EnemyFullAlert", self.class) -- B.O.W. invaliad Effect!
		obj:AddStatusEffectImmunity("EnemyCQCReaction", self.class) -- B.O.W. invaliad Effect!
		obj:AddStatusEffectImmunity("EnemyBioInfection", self.class) -- B.O.W. Never Infected!
		obj:AddStatusEffectImmunity("Exhausted", self.class) -- B.O.W. Never Exhausted! [!MUST HAVE!]
		obj:AddStatusEffectImmunity("Tired", self.class) -- B.O.W. Never Tired! [!MUST HAVE!]
		obj:AddStatusEffectImmunity("Blinded", self.class) -- B.O.W. Never Blinded!
		obj:AddStatusEffectImmunity("Choking", self.class) -- B.O.W. Never Choking!
		obj:AddStatusEffectImmunity("Panicked", self.class) -- B.O.W. Never Panicked!
		obj:AddStatusEffectImmunity("DangerClose", self.class) -- B.O.W. invaliad Perk!
		obj:AddStatusEffectImmunity("CQCTraining", self.class) -- B.O.W. invaliad Perk!
		obj:AddStatusEffectImmunity("Throwing", self.class) -- B.O.W. invaliad Perk!
		obj:AddStatusEffectImmunity("BreachAndClear", self.class) -- B.O.W. invaliad Perk!
		obj:AddStatusEffect('Bloodthirst') -- B.O.W. Bloodthirst Effect!
	end,
	OnRemoved = function (self, obj)
		obj:RemoveStatusEffectImmunity("Suppressed", self.class)
		obj:RemoveStatusEffectImmunity("Bleeding", self.class)
		obj:RemoveStatusEffectImmunity("Inaccurate", self.class)
		obj:RemoveStatusEffectImmunity("Flanked", self.class)
		obj:RemoveStatusEffectImmunity("SuppressionChangeStance", self.class)
		obj:RemoveStatusEffectImmunity("FreeMove", self.class)
		obj:RemoveStatusEffectImmunity("TacticalEnemy", self.class)
		obj:RemoveStatusEffectImmunity("EnemyFullAlert", self.class)
		obj:RemoveStatusEffectImmunity("EnemyCQCReaction", self.class)
		obj:RemoveStatusEffectImmunity("EnemyBioInfection", self.class)
		obj:RemoveStatusEffectImmunity("Exhausted", self.class)
		obj:RemoveStatusEffectImmunity("Tired", self.class)
		obj:RemoveStatusEffectImmunity("Blinded", self.class)
		obj:RemoveStatusEffectImmunity("Choking", self.class)
		obj:RemoveStatusEffectImmunity("Panicked", self.class)
		obj:RemoveStatusEffectImmunity("DangerClose", self.class)
		obj:RemoveStatusEffectImmunity("CQCTraining", self.class)
		obj:RemoveStatusEffectImmunity("Throwing", self.class)
		obj:RemoveStatusEffectImmunity("BreachAndClear", self.class)
		obj:RemoveStatusEffect("Bloodthirst")
	end,
	Icon = "UI/Hud/Status effects/stabilized",
	Shown = true,
}

UndefineClass('YouSeeIgor')
DefineClass.YouSeeIgor = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnUnitKill",
			Handler = function (self, target, killedUnits)
				target:GainAP(self:ResolveValue("APRestore") * const.Scale.AP) -- Regain maximum <em><APRestore> AP</em> after all <em>killedUnits</em> (NOT EACH KILL -- WAS WAY TOO OP)!
			end,
		}),
	},
	DisplayName = T(532826806041, --[[CharacterEffectCompositeDef YouSeeIgor DisplayName]] "You see, Igor..."),
	Description = T(364645895305, --[[CharacterEffectCompositeDef YouSeeIgor Description]] "Regain <em><APRestore> AP</em> after each <em>kill</em>."),
	Icon = "UI/Icons/Perks/YouSeeIgor",
	Tier = "Personal",
}

UndefineClass('MartialArts')
DefineClass.MartialArts = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcChanceToHit",
			Handler = function (self, target, attacker, action, attack_target, weapon1, weapon2, data)
				if not (action and action.ActionType == "Melee Attack") then return end
				
				local text = T{776394275735, "Perk: <name>", name = self.DisplayName}
				local textParry = T{30072476861004, "Parry: Melee attacks become <em>Grazing</em>"} -- New MartialArts Parry effect!
				if target == attack_target and IsKindOf(target, "Unit") and target.species ~= "Human" then
					text = T(767817302327, "Perk: Animal Reflexes")
				end
				
				if target == attacker then
					ApplyCthModifier_Add(self, data, self:ResolveValue("hit"), text)
				end
				if target == attack_target then
					ApplyCthModifier_Add(self, data, -self:ResolveValue("defense"), textParry)
				end
			end,
		}),
	},
	DisplayName = T(578858751307, --[[CharacterEffectCompositeDef MartialArts DisplayName]] "Martial Arts"),
	Description = T(270864369186, --[[CharacterEffectCompositeDef MartialArts Description]] "Improved <em>Accuracy</em> with <em>Melee Attacks</em>.\n\nImproved <em>Defense</em> against <em>Melee Attacks</em>."),
	Icon = "UI/Icons/Perks/MartialArts",
	Tier = "Specialization",
}

UndefineClass('MeleeTraining')
DefineClass.MeleeTraining = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcDamageAndEffects",
			Handler = function (self, target, attacker, attack_target, action, weapon, attack_args, hit, data)
				if target == attacker and (attack_target ~= nil and attacker:IsOnEnemySide(attack_target)) and IsKindOf(attack_target, "Unit") then
					if (action and action.ActionType == "Melee Attack") and (attack_args and attack_args.opportunity_attack_type) then
						data.base_damage = Max(attack_target:GetTotalHitPoints(), 125) + Max(const.Combat.MaxGrit, 45) -- Melee OpportunityAttack will trigger insta-kill!
					end
				end
			end,
		}),
	},
	DisplayName = T(312828750760, --[[CharacterEffectCompositeDef MeleeTraining DisplayName]] "Hand-to-Hand"),
	Description = T(917292006439, --[[CharacterEffectCompositeDef MeleeTraining Description]] "Make an <GameTerm('Interrupt')> <em>Melee Attack</em> when an enemy in <em>melee range</em> attacks or tries to move away during the enemy turn."),
	Icon = "UI/Icons/Perks/MeleeTraining",
	Tier = "Specialization",
}

UndefineClass('OptimalPerformance')
DefineClass.OptimalPerformance = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnUnitAttack",
			Handler = function (self, target, attacker, action, attack_target, results, attack_args)
				if target == attacker and (action.ActionType == "Melee Attack" or (IsKindOf(results.weapon, "Firearm") and attacker:IsAdjacentTo(attack_target))) and IsKindOf(attack_target, "Unit") and not results.miss then -- Firearms can also enjoy OptimalPerformance!
					attacker:ApplyTempHitPoints(self:ResolveValue("temp_HP_on_melee"))
				end
			end,
		}),
	},
	DisplayName = T(935000833692, --[[CharacterEffectCompositeDef OptimalPerformance DisplayName]] "Full Body Contact"),
	Description = T(946942648822, --[[CharacterEffectCompositeDef OptimalPerformance Description]] "Gain <em><temp_HP_on_melee></em> <GameTerm('Grit')> on a successful <em>Melee Attack</em>."),
	Icon = "UI/Icons/Perks/OptimalPerformance",
	Tier = "Bronze",
	Stat = "Health",
	StatValue = 70,
}

UndefineClass('BeefedUp')
DefineClass.BeefedUp = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	DisplayName = T(877823816296, --[[CharacterEffectCompositeDef BeefedUp DisplayName]] "Beefed Up"),
	Description = T(885436226092, --[[CharacterEffectCompositeDef BeefedUp Description]] "Max <em>HP</em> increased by <em><percent(bonus_health)></em>."),
	OnAdded = function (self, obj)
		obj:AddStatusEffectImmunity("Knockdown", self.class) -- [BeefedUp] will invalidate [Knockdown] automatically
		obj:AddStatusEffectImmunity("Tired", self.class) -- [BeefedUp] will invalidate [Tired] automatically
		RecalcMaxHitPoints(obj)
	end,
	OnRemoved = function (self, obj)
		obj:RemoveStatusEffectImmunity("Knockdown", self.class) -- this will restore [Knockdown] automatically
		obj:RemoveStatusEffectImmunity("Tired", self.class) -- this will restore [Tired] automatically
		RecalcMaxHitPoints(obj)
	end,
	Icon = "UI/Icons/Perks/Fitness",
	Tier = "Bronze",
	Stat = "Health",
	StatValue = 70,
}

UndefineClass('SwiftStrike')
DefineClass.SwiftStrike = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnUnitAttack",
			Handler = function (self, target, attacker, action, attack_target, results, attack_args)
				if target == attacker and action.ActionType == "Melee Attack" and IsKindOf(attack_target, "Unit") and not results.miss then
					if g_Combat then
						attacker:AddStatusEffect("FreeMove")
					elseif g_StartingCombat then
						attacker:AddStatusEffect("FreeMoveOnCombatStart")		
					end
					self:SetParameter("SwiftStrike_activated", true)
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCombatEnd",
			Handler = function (self, target)
				self:SetParameter("SwiftStrike_activated", false)
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcStartTurnAP",
			Handler = function (self, target, value)
				if self:ResolveValue("SwiftStrike_activated") then
					return value + 2 * const.Scale.AP -- New SwiftStrike APBuff!
				end
			end,
		}),
	},
	DisplayName = T(441368229605, --[[CharacterEffectCompositeDef SwiftStrike DisplayName]] "Hit and Run"),
	Description = T(931499226151, --[[CharacterEffectCompositeDef SwiftStrike Description]] "Gain <GameTerm('FreeMove')> after making a <em>Melee Attack</em>."),
	Icon = "UI/Icons/Perks/SwiftStrike",
	Tier = "Bronze",
	Stat = "Agility",
	StatValue = 70,
}

UndefineClass('Flanker')
DefineClass.Flanker = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcDamageAndEffects",
			Handler = function (self, target, attacker, attack_target, action, weapon, attack_args, hit, data)
				if target == attacker and IsKindOf(attack_target, "Unit") and attack_target:HasStatusEffect("Flanked") then
					local damageBonus = self:ResolveValue("damageBonus")
					data.base_damage = MulDivRound(data.base_damage, 100 + damageBonus, 100)
					data.breakdown[#data.breakdown + 1] = { name = self.DisplayName, value = damageBonus }
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnUnitAttack",
			Handler = function (self, target, attacker, action, attack_target, results, attack_args)
				if target == attacker and IsKindOf(attack_target, "Unit") and attack_target:HasStatusEffect("Flanked") and HasVisibilityTo(attack_target, attacker) and not results.miss then -- Flanker will also refresh FreeMove!
					if g_Combat then
						attacker:AddStatusEffect("FreeMove")
					elseif g_StartingCombat then
						attacker:AddStatusEffect("FreeMoveOnCombatStart")		
					end
				end
			end,
		}),
	},
	DisplayName = T(238393129994, --[[CharacterEffectCompositeDef Flanker DisplayName]] "Flanker"),
	Description = T(644752752416, --[[CharacterEffectCompositeDef Flanker Description]] "Deal <em><percent(damageBonus)></em> more <em>Damage</em> against <GameTerm('Flanked')> enemies."),
	Icon = "UI/Icons/Perks/Flanker",
	Tier = "Bronze",
	Stat = "Agility",
	StatValue = 70,
}

UndefineClass('SteadyBreathing')
DefineClass.SteadyBreathing = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcFreeMove",
			Handler = function (self, target, data)
				local armourItems = target:GetEquipedArmour()
				for _, item in ipairs(armourItems) do
					if item.PenetrationClass > 2 then
						return
					end
				end
				data.add = data.add + self:ResolveValue("freeMoveBonusAp")
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcMoveModifier",
			Handler = function (self, target, value, action)
				local weapon = target:GetActiveWeapons()
				if action.id == "Move" then
					if IsKindOfClasses(weapon, "SubmachineGun", "Pistol", "Revolver", "MeleeWeapon") or not weapon then -- SteadyBreathing will also increase movement range (SMG, Handgun, Melee, Unarmed)!
						return value - 20
					end
				end
			end,
		}),
	},
	DisplayName = T(169594503293, --[[CharacterEffectCompositeDef SteadyBreathing DisplayName]] "Fast Runner"),
	Description = T(727749516634, --[[CharacterEffectCompositeDef SteadyBreathing Description]] "Increased <GameTerm('FreeMove')> <em>Range</em> when wearing <em>Light Armor</em> or not wearing any Armor."),
	Icon = "UI/Icons/Perks/SteadyBreathing",
	Tier = "Bronze",
	Stat = "Agility",
	StatValue = 70,
}

UndefineClass('OpportunisticKiller')
DefineClass.OpportunisticKiller = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnUnitAttack",
			Handler = function (self, target, attacker, action, attack_target, results, attack_args)
				if target == attacker and attack_args and attack_args.opportunity_attack_type then -- OpportunisticKiller works with ALL opportunity_attack_type (NOT just OverwatchAttacks)!
					self:SetParameter("OpportunisticKiller_charged", true)
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnBeginTurn",
			Handler = function (self, target)
				if not self:ResolveValue("OpportunisticKiller_charged") then return end
				
				local weapon1, weapon2 = target:GetActiveWeapons()
				if IsKindOf(weapon1, "Firearm") then
					target:ReloadWeapon(weapon1)
				end
				if IsKindOf(weapon2, "Firearm") then
					target:ReloadWeapon(weapon2)
				end
				
				self:SetParameter("OpportunisticKiller_charged", false)
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcCritChance",
			Handler = function (self, target, attacker, attack_target, action, weapon, data)
				if target == attacker then
					-- treat attacks equally (allow crits on opportunity attacks)
					data.opportunity_attack = false
				end
			end,
		}),
	},
	DisplayName = T(132879109293, --[[CharacterEffectCompositeDef OpportunisticKiller DisplayName]] "Opportunistic Killer"),
	Description = T(770924869822, --[[CharacterEffectCompositeDef OpportunisticKiller Description]] "Enables <GameTerm('Crits')> with <GameTerm('Interrupt')> attacks.\n\n<em>Automatic reload</em> if <GameTerm('Overwatch')> was used last turn."),
	Icon = "UI/Icons/Perks/OpportunisticKiller",
	Tier = "Bronze",
	Stat = "Dexterity",
	StatValue = 70,
}

UndefineClass('Deadeye')
DefineClass.Deadeye = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcCritChance",
			Handler = function (self, target, attacker, attack_target, action, weapon, data)
				data.crit_per_aim = data.crit_per_aim + self:ResolveValue("crit_per_aim")
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcChanceToHit",
			Handler = function (self, target, attacker, action, attack_target, weapon1, weapon2, data)
				if target == attacker and action.id == "SingleShot" then -- Deadeye will also buff SingleShot CTH!
					ApplyCthModifier_Add(self, data, 10)
				end
			end,
		}),
	},
	DisplayName = T(333539797050, --[[CharacterEffectCompositeDef Deadeye DisplayName]] "Deadeye"),
	Description = T(923228420877, --[[CharacterEffectCompositeDef Deadeye Description]] "Gain <em><percent(crit_per_aim)></em> extra <GameTerm('Crit')> chance per <GameTerm('Aim')>."),
	Icon = "UI/Icons/Perks/Deadeye",
	Tier = "Bronze",
	Stat = "Dexterity",
	StatValue = 70,
}

UndefineClass('BreachAndClear')
DefineClass.BreachAndClear = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnUnitAttackResolved",
			Handler = function (self, target, attacker, attack_target, action, attack_args, results, can_retaliate, combat_starting)
				if target == attacker and IsKindOfClasses(results.weapon, "Grenade", "Shotgun") and action.ActionType == "Ranged Attack" then
					if g_Combat then
						attacker:AddStatusEffect("FreeMove")
					elseif g_StartingCombat or combat_starting then
						attacker:AddStatusEffect("FreeMoveOnCombatStart")
					end
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcAPCost",
			Handler = function (self, target, current_ap, action, weapon, aim)
				if IsKindOfClasses(weapon, "Grenade", "Shotgun") and action.ActionType == "Ranged Attack" then -- BreachAndClear will also reduce AP!
					return Max(1 * const.Scale.AP, current_ap - 2 * const.Scale.AP)
				end
			end,
		}),
	},
	DisplayName = T(609540599823, --[[CharacterEffectCompositeDef BreachAndClear DisplayName]] "Breach and Clear"),
	Description = T(853841959476, --[[CharacterEffectCompositeDef BreachAndClear Description]] "Gain <GameTerm('FreeMove')> after throwing <em>Grenades</em> or making <em>Shotgun</em> attacks."),
	Icon = "UI/Icons/Perks/BreachAndClear",
	Tier = "Bronze",
	Stat = "Strength",
	StatValue = 70,
}

UndefineClass('BloodlustPerk')
DefineClass.BloodlustPerk = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnBeginTurn",
			Handler = function (self, target)
				self:SetParameter("BloodlustPerk_target", false)
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnUnitAttack",
			Handler = function (self, target, attacker, action, attack_target, results, attack_args)
				if target == attacker then
					if (action.ActionType ~= "Melee Attack" and not IsKindOf(results.weapon, "Shotgun")) or not IsKindOf(attack_target, "Unit") then
						self:SetParameter("BloodlustPerk_target", false)
					else
						self:SetParameter("BloodlustPerk_target", attack_target.handle)
					end
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcDamageAndEffects",
			Handler = function (self, target, attacker, attack_target, action, weapon, attack_args, hit, data)
				if target == attacker and action then
					local last_target = self:ResolveValue("BloodlustPerk_target")
					if (action.ActionType == "Melee Attack" or IsKindOf(weapon, "Shotgun")) and last_target and IsKindOf(attack_target, "Unit") and attack_target.handle ~= last_target then -- Shotguns also enjoy BloodlustPerk!
						local bonus = MulDivRound(attacker.Strength, self:ResolveValue("Str_to_bonus_dmg_conversion"), 100)
						data.base_damage = MulDivRound(data.base_damage, 100 + bonus, 100)
						data.breakdown[#data.breakdown + 1] = { name = self.DisplayName, value = bonus }
					end
				end
			end,
		}),
	},
	DisplayName = T(700118302261, --[[CharacterEffectCompositeDef BloodlustPerk DisplayName]] "Killing Spree"),
	Description = T(419165368911, --[[CharacterEffectCompositeDef BloodlustPerk Description]] "Subsequent <em>Melee Attacks</em> against <em>different targets</em> during the same turn deal <em><percent(StatPercent('Strength', Str_to_bonus_dmg_conversion))></em> extra <em>Damage</em> (based on Strength)."),
	Icon = "UI/Icons/Perks/BloodlustPerk",
	Tier = "Bronze",
	Stat = "Strength",
	StatValue = 70,
}

UndefineClass('Savior')
DefineClass.Savior = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcHealAmount",
			Handler = function (self, target, patient, medic, medkit, data)
				if target == medic then
					data.heal_percent = data.heal_percent + self:ResolveValue("bandageBonus")
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnUnitBandaged",
			Handler = function (self, target, healer, patient, hp_restored)
				self:SetParameter("Savior_activated", true)
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCombatEnd",
			Handler = function (self, target)
				self:SetParameter("Savior_activated", false)
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcStartTurnAP",
			Handler = function (self, target, value)
				if self:ResolveValue("Savior_activated") then
					return value + 2 * const.Scale.AP -- New Savior APBuff!
				end
			end,
		}),
	},
	DisplayName = T(322598238789, --[[CharacterEffectCompositeDef Savior DisplayName]] "Savior"),
	Description = T(665496332016, --[[CharacterEffectCompositeDef Savior Description]] "Restore <em><percent(bandageBonus)></em> more <em>HP</em> when using <em>Bandage</em>."),
	Icon = "UI/Icons/Perks/Savior",
	Tier = "Bronze",
	Stat = "Wisdom",
	StatValue = 70,
}

UndefineClass('CancelShot')
DefineClass.CancelShot = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "CharacterEffect",
	OnAdded = function (self, obj)
		obj:InterruptPreparedAttack()
		obj:ActivatePerk("MeleeTraining")
		obj:RemoveStatusEffect("GlobalReconnaissance") -- Cancel Reconnaissance Overwatch!
		obj:RemoveStatusEffect("BandageInCombat")
		obj:RemoveStatusEffect("CancelShot")
		obj:UpdateMeleeTrainingVisual()
	end,
}

UndefineClass('Hobbler')
DefineClass.Hobbler = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcDamageAndEffects",
			Handler = function (self, target, attacker, attack_target, action, weapon, attack_args, hit, data)
				if target ~= attacker then return end
				
				if IsKindOf(attack_target, "Unit") and (attack_target.species ~= "Human" or attack_args.target_spot_group == "Arms" or attack_args.target_spot_group == "Legs") then
					data.effects[#data.effects + 1] = "Bleeding" -- Hobbler adds Bleeding effect (Animal, Arms, Legs)!
				end
				data.ignore_body_part_damage.Arms = true
				data.ignore_body_part_damage.Legs = true
			end,
		}),
	},
	DisplayName = T(314220589449, --[[CharacterEffectCompositeDef Hobbler DisplayName]] "Arterial Shot"),
	Description = T(562754701434, --[[CharacterEffectCompositeDef Hobbler Description]] "No <em>Damage Penalty</em> for <em>Arms</em> and <em>Legs</em> shots."),
	Icon = "UI/Icons/Perks/Hobbler",
	Tier = "Bronze",
	Stat = "Wisdom",
	StatValue = 70,
}

UndefineClass('Counterfire')
DefineClass.Counterfire = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnUnitAttack",
			Handler = function (self, target, attacker, action, attack_target, results, attack_args)
				if target == attacker and (attack_target ~= nil and attacker:IsOnEnemySide(attack_target)) and IsKindOf(attack_target, "Unit") then
					if attack_args and attack_args.opportunity_attack_type and action.ActionType == "Ranged Attack" and not results.miss then -- Counterfire works with all opportunity_attack_type (NOT just OverwatchAttacks)!
						local count = self:ResolveValue("counter") + 1
						if count >= self:ResolveValue("hitsRequired") then
							target:AddStatusEffect("Inspired")
							count = 0
						end
						self:SetParameter("counter", count)
						self:SetParameter("Counterfire_activated", true)
					elseif results.miss then
						self:SetParameter("Counterfire_activated", false)
					end
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnBeginTurn",
			Handler = function (self, target)
				self:SetParameter("counter", 0)
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCombatEnd",
			Handler = function (self, target)
				self:SetParameter("Counterfire_activated", false)
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcStartTurnAP",
			Handler = function (self, target, value)
				if self:ResolveValue("Counterfire_activated") then
					return value + 2 * const.Scale.AP -- New Counterfire APBuff!
				end
			end,
		}),
	},
	DisplayName = T(680739063564, --[[CharacterEffectCompositeDef Counterfire DisplayName]] "Fire Routine"),
	Description = T(857967049165, --[[CharacterEffectCompositeDef Counterfire Description]] "Become <GameTerm('Inspired')> after you land <em><hitsRequired> hits</em> while in <GameTerm('Overwatch')>."),
	OnAdded = function (self, obj)
		self:SetParameter("counter", 0)
	end,
	Icon = "UI/Icons/Perks/Counterfire",
	Tier = "Silver",
	Stat = "Dexterity",
	StatValue = 80,
}

UndefineClass('InstantAutopsy')
DefineClass.InstantAutopsy = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcCritChance",
			Handler = function (self, target, attacker, attack_target, action, weapon, data)
				if target == attacker and attacker:IsPointBlankRange(attack_target) then
					data.crit_chance = data.crit_chance + self:ResolveValue("crit_bonus")
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcChanceToHit",
			Handler = function (self, target, attacker, action, attack_target, weapon1, weapon2, data)
				if target == attacker and attacker:IsPointBlankRange(attack_target) and (action.id == "BuckshotBurst" or action.id == "Buckshot" or action.id == "CancelShotCone") then -- InstantAutopsy will also buff Shotguns CTH!
					ApplyCthModifier_Add(self, data, 25)
				end
			end,
		}),
	},
	DisplayName = T(949686340874, --[[CharacterEffectCompositeDef InstantAutopsy DisplayName]] "Shock Assault"),
	Description = T(925081303703, --[[CharacterEffectCompositeDef InstantAutopsy Description]] "Gain <em><percent(crit_bonus)></em> extra <GameTerm('Crit')> chance with melee weapons and firearms in <GameTerm('PointBlankRange')>."),
	Icon = "UI/Icons/Perks/InstantAutopsy",
	Tier = "Silver",
	Stat = "Strength",
	StatValue = 80,
}

UndefineClass('HardBlow')
DefineClass.HardBlow = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcChanceToHit",
			Handler = function (self, target, attacker, action, attack_target, weapon1, weapon2, data)
				if target == attacker and action and action.ActionType == "Melee Attack" then -- HardBlow will also buff Melee CTH!
					ApplyCthModifier_Add(self, data, 25)
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcDamageAndEffects",
			Handler = function (self, target, attacker, attack_target, action, weapon, attack_args, hit, data)
				if action and action.ActionType == "Melee Attack" then
					data.effects[#data.effects + 1] = "CancelShot"
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCheckInterruptAttackAvailable",
			Handler = function (self, target, target_unit, action)
				return action and action.ActionType ~= "Melee Attack"
			end,
		}),
	},
	DisplayName = T(373820313755, --[[CharacterEffectCompositeDef HardBlow DisplayName]] "Sudden Strike"),
	Description = T(854979683764, --[[CharacterEffectCompositeDef HardBlow Description]] "Does not trigger <GameTerm('Interrupt')> attacks while making <em>Melee Attacks</em>.\n\nCancel <GameTerm('Overwatch')> and <GameTerm('PinDown')> with successful <em>Melee Attacks</em>.\n"),
	Icon = "UI/Icons/Perks/HardBlow",
	Tier = "Silver",
	Stat = "Strength",
	StatValue = 80,
}

UndefineClass('StressManagement')
DefineClass.StressManagement = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnStatusEffectAdded",
			Handler = function (self, target, id, stacks)
				if CharacterEffectDefs[id].type == "Debuff" and not self:ResolveValue("StressManagement_activated") then
					target:AddStatusEffect("Inspired") -- always become <GameTerm('Inspired')> after suffering a <em>negative effect</em>!
					--self:SetParameter("StressManagement_activated", true)
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCombatEnd",
			Handler = function (self, target)
				self:SetParameter("StressManagement_activated", false)
			end,
		}),
	},
	DisplayName = T(578724057231, --[[CharacterEffectCompositeDef StressManagement DisplayName]] "Stress Management"),
	Description = T(957117254898, --[[CharacterEffectCompositeDef StressManagement Description]] "Become <GameTerm('Inspired')> after suffering a <em>negative effect</em> for the <em>first time</em> in combat."),
	OnAdded = function (self, obj)
		obj:AddStatusEffectImmunity("Suppressed", self.class) -- StressManagement will invalidate Suppressed automatically
	end,
	OnRemoved = function (self, obj)
		obj:RemoveStatusEffectImmunity("Suppressed", self.class) -- this will restore Suppressed automatically
	end,
	Icon = "UI/Icons/Perks/StressManagement",
	Tier = "Silver",
	Stat = "Wisdom",
	StatValue = 80,
}

UndefineClass('LeadFromTheFront')
DefineClass.LeadFromTheFront = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnUnitAttack",
			Handler = function (self, target, attacker, action, attack_target, results, attack_args)
				if attacker == target and IsKindOf(attack_target, "Unit") and results.total_damage and results.total_damage >= self:ResolveValue("damageTreshold") then
					if attacker.team:IsPlayerControlled() and not self:ResolveValue("LeadFromTheFront_applied") then
						attacker.team:ChangeMorale(self:ResolveValue("moraleBonus"), self.DisplayName)
						self:SetParameter("LeadFromTheFront_applied", true)
					end
					for _, unit in ipairs(g_Units) do
						if unit ~= attacker and unit.team:IsAllySide(attacker.team) and DivRound(unit:GetDist(attacker), const.SlabSizeX) < 16 then -- LeadFromTheFront will invalidate nearby teammates Panicked & Suppressed automatically!
							unit:RemoveStatusEffect("Panicked")
							unit:RemoveStatusEffect("Suppressed")
						end
					end
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnBeginTurn",
			Handler = function (self, target)
				self:SetParameter("LeadFromTheFront_applied", false)
			end,
		}),
	},
	DisplayName = T(589057792592, --[[CharacterEffectCompositeDef LeadFromTheFront DisplayName]] "Inspiring Strike"),
	Description = T(142399887488, --[[CharacterEffectCompositeDef LeadFromTheFront Description]] "Increase <GameTerm('Morale')> when you deal more than <em><damageTreshold> Damage</em> with a <em>single attack</em>.\n\nOnce per turn."),
	Icon = "UI/Icons/Perks/SquadLeadership",
	Tier = "Silver",
	Stat = "Wisdom",
	StatValue = 80,
}

UndefineClass('BattleFocus')
DefineClass.BattleFocus = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnUnitAttackResolved",
			Handler = function (self, target, attacker, attack_target, action, attack_args, results, can_retaliate, combat_starting)
				if target == attacker and (attack_target ~= nil and attacker:IsOnEnemySide(attack_target)) and IsKindOf(attack_target, "Unit") then
				    local weapon = attacker:GetActiveWeapons()
					if IsKindOf(results.weapon, "AssaultRifle") and (results.total_damage and results.total_damage >= 50) then -- BattleFocus will be Inspired if AssaultRifle total_damage >= 50!
						attacker:AddStatusEffect("Inspired")
					end
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnDamageTaken",
			Handler = function (self, target, attacker, dmg, hit_descr)
				self:SetParameter("BattleFocus_activated", true)
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCombatEnd",
			Handler = function (self, target)
				self:SetParameter("BattleFocus_activated", false)
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcStartTurnAP",
			Handler = function (self, target, value)
				if self:ResolveValue("BattleFocus_activated") then
					return value + self:ResolveValue("battleFocusAP") * const.Scale.AP
				end
			end,
		}),
	},
	DisplayName = T(822626767198, --[[CharacterEffectCompositeDef BattleFocus DisplayName]] "Battle Focus"),
	Description = T(235322784555, --[[CharacterEffectCompositeDef BattleFocus Description]] "Gain <em><battleFocusAP></em> <em>AP</em> when <em>hit</em> by an enemy for the <em>first</em> time.\n\nEnds at the end of combat."),
	Icon = "UI/Icons/Perks/BattleFocus",
	Tier = "Gold",
	Stat = "Health",
	StatValue = 90,
}

UndefineClass('LuckyStreak')
DefineClass.LuckyStreak = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnBeginTurn",
			Handler = function (self, target)
				if not self:ResolveValue("LuckyStreak_charged") then return end
				
				local weapon1, weapon2 = target:GetActiveWeapons() -- LuckyStreak will also ReloadWeapon!
				if IsKindOf(weapon1, "Firearm") then
					target:ReloadWeapon(weapon1)
				end
				if IsKindOf(weapon2, "Firearm") then
					target:ReloadWeapon(weapon2)
				end
				
				self:SetParameter("LuckyStreak_charged", false)
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnEndTurn",
			Handler = function (self, target)
				self:SetParameter("streak", 0)
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnUnitAttack",
			Handler = function (self, target, attacker, action, attack_target, results, attack_args)
				if target == attacker and results.crit and IsKindOf(attack_target, "Unit") then
					local streak = self:ResolveValue("streak") + 1
					if streak >= self:ResolveValue("crits_number") then
						streak = 0
						target:AddStatusEffect("Inspired")
						self:SetParameter("LuckyStreak_charged", true)
					end
					self:SetParameter("streak", streak)
				end
			end,
		}),
	},
	DisplayName = T(838318520600, --[[CharacterEffectCompositeDef LuckyStreak DisplayName]] "Lucky Streak"),
	Description = T(350209296951, --[[CharacterEffectCompositeDef LuckyStreak Description]] "Become <GameTerm('Inspired')> when you make <em><crits_number></em> <GameTerm('Crits')> in the <em>same</em> turn."),
	OnAdded = function (self, obj)
		self:SetParameter("streak", 0)
	end,
	Icon = "UI/Icons/Perks/LuckyStreak",
	Tier = "Gold",
	Stat = "Agility",
	StatValue = 90,
}

UndefineClass('ColdHeart')
DefineClass.ColdHeart = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcDamageAndEffects",
			Handler = function (self, target, attacker, attack_target, action, weapon, attack_args, hit, data)
				if target == attacker and IsKindOf(attack_target, "Unit") then
					if attack_target.species ~= "Human" or attack_args.target_spot_group == "Torso" then -- ColdHeart will also buff base_damage against Animal & Torso!
						data.base_damage = MulDivRound(data.base_damage, 100 + self:ResolveValue("crit_bonus"), 100)
						data.breakdown[#data.breakdown + 1] = { name = self.DisplayName, value = self:ResolveValue("crit_bonus") }
					end
					data.critical_damage = data.critical_damage + self:ResolveValue("crit_bonus")
				end
			end,
		}),
	},
	DisplayName = T(926942274160, --[[CharacterEffectCompositeDef ColdHeart DisplayName]] "Anatomical Precision"),
	Description = T(145102598829, --[[CharacterEffectCompositeDef ColdHeart Description]] "Deal <em><percent(crit_bonus)></em> more <GameTerm('Crit')> <em>Damage</em>."),
	Icon = "UI/Icons/Perks/ColdHeart",
	Tier = "Gold",
	Stat = "Agility",
	StatValue = 90,
}

UndefineClass('Killzone')
DefineClass.Killzone = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcOverwatchAttacks",
			Handler = function (self, target, value, action, args)
				return value + 1 -- Max OverwatchAttacks + 1!
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcMinAimActions",
			Handler = function (self, target, value, attacker, attack_target, action, weapon)
				if target == attacker and (g_Overwatch[attacker] or g_Pindown[attacker]) and IsKindOfClasses(weapon, "SubmachineGun", "Pistol", "Revolver") then
					return value + 3 -- SMG & Handgun OverwatchAttacks IsFullyAimedShots!
				end
			end,
		}),
	},
	DisplayName = T(367495003009, --[[CharacterEffectCompositeDef Killzone DisplayName]] "Killzone"),
	Description = T(994948330470, --[[CharacterEffectCompositeDef Killzone Description]] "Make a bonus <em>Attack</em> when making any <GameTerm('Interrupt')> attack."),
	Icon = "UI/Icons/Perks/Killzone",
	Tier = "Gold",
	Stat = "Dexterity",
	StatValue = 90,
}

UndefineClass('Virtuoso')
DefineClass.Virtuoso = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcStealthKillChance",
			Handler = function (self, target, value, attacker, attack_target, weapon, target_spot_group, aim)
				if target == attacker and IsFullyAimedAttack(aim) then
					return value + self:ResolveValue("virtuosoStealthKillChance")
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnUnitKill",
			Handler = function (self, target, killedUnits)
				if target:HasStatusEffect("Hidden") then
					target:AddStatusEffect("Inspired") -- Inspired on successful StealthKills!
				end
			end,
		}),
	},
	DisplayName = T(273806123408, --[[CharacterEffectCompositeDef Virtuoso DisplayName]] "Assassination"),
	Description = T(368382559050, --[[CharacterEffectCompositeDef Virtuoso Description]] "Increased chance for <GameTerm('StealthKills')> for attacks with 3+ Aim levels made while <GameTerm('Sneaking')>."),
	Icon = "UI/Icons/Perks/Virtuoso",
	Tier = "Gold",
	Stat = "Dexterity",
	StatValue = 90,
}

UndefineClass('BloodScent')
DefineClass.BloodScent = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcMinAimActions",
			Handler = function (self, target, value, attacker, attack_target, action, weapon)
				if target == attacker and (IsKindOf(weapon, "MeleeWeapon") or not weapon) then
					return value + 3 -- Melee x3 Auto-FullyAimedStrike!!!
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcMaxAimActions",
			Handler = function (self, target, value, attacker, attack_target, action, weapon)
				if target == attacker and (IsKindOf(weapon, "MeleeWeapon") or not weapon) then
					return value + 2 -- Melee +2 MaxAimActions!!!
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcCritChance",
			Handler = function (self, target, attacker, attack_target, action, weapon, data)
				if target == attacker and (IsKindOf(weapon, "MeleeWeapon") or not weapon) and not attack_target:HasStatusEffect("MartialArts") then
					data.guaranteed_crit = true
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcDamageAndEffects",
			Handler = function (self, target, attacker, attack_target, action, weapon, attack_args, hit, data)
				if target == attacker and (IsKindOf(weapon, "MeleeWeapon") or not weapon) and not attack_target:HasStatusEffect("MartialArts") then
					data.effects[#data.effects + 1] = "Marked"
				end
			end,
		}),
	},
	DisplayName = T(738259813299, --[[CharacterEffectCompositeDef BloodScent DisplayName]] "True Strike"),
	Description = T(868553471362, --[[CharacterEffectCompositeDef BloodScent Description]] "Successful <em>Melee Attacks</em> are <GameTerm('Crits')> and apply <GameTerm('Marked')> to the target.\n\n"),
	Icon = "UI/Icons/Perks/BloodScent",
	Tier = "Gold",
	Stat = "Strength",
	StatValue = 90,
}

UndefineClass('LineBreaker')
DefineClass.LineBreaker = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnDamageDone",
			Handler = function (self, target, attack_target, dmg, hit_descr)
				if target and (attack_target ~= nil and target:IsOnEnemySide(attack_target)) and target:IsPointBlankRange(attack_target) and IsKindOf(attack_target, "Unit") then
				    self:SetParameter("LineBreaker_activated", true)
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCombatEnd",
			Handler = function (self, target)
				self:SetParameter("LineBreaker_activated", false)
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcStartTurnAP",
			Handler = function (self, target, value)
				if self:ResolveValue("LineBreaker_activated") then
					return value + 3 * const.Scale.AP -- New LineBreaker APBuff!
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnUnitKill",
			Handler = function (self, target, killedUnits)
				for _, unit in ipairs(killedUnits) do
					if target:IsPointBlankRange(unit) then
						target:AddStatusEffect("Inspired")
						return
					end
				end
			end,
		}),
	},
	DisplayName = T(417989494365, --[[CharacterEffectCompositeDef LineBreaker DisplayName]] "Line Breaker"),
	Description = T(244850628945, --[[CharacterEffectCompositeDef LineBreaker Description]] "Become <GameTerm('Inspired')> after a kill in <GameTerm('PointBlankRange')>."),
	Icon = "UI/Icons/Perks/LineBreaker",
	Tier = "Gold",
	Stat = "Strength",
	StatValue = 90,
}

UndefineClass('Caretaker')
DefineClass.Caretaker = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnUnitBandaged",
			Handler = function (self, target, healer, patient, hp_restored)
				if target == healer then
					local tempHp = MulDivRound(healer.Medical, self:ResolveValue("medicalPercent"), 100)
					if patient.command == "DownedRally" then
						patient:AddStatusEffect("GritAfterRally", tempHp)
					else
						patient:ApplyTempHitPoints(tempHp)
					end
					patient:AddStatusEffect("Inspired")
					healer:AddStatusEffect("Mobile") -- Healer will also gain Mobile!
				end
			end,
		}),
	},
	DisplayName = T(416037614632, --[[CharacterEffectCompositeDef Caretaker DisplayName]] "Painkiller"),
	Description = T(527875226325, --[[CharacterEffectCompositeDef Caretaker Description]] "When you end you turn bandaging an ally, you grant <em><StatPercent('Medical', medicalPercent)></em> <GameTerm('Grit')> to this ally (based on Medical)."),
	OnAdded = function (self, obj)
		obj:AddStatusEffectImmunity("Bleeding", self.class) -- [Caretaker] will invalidate [Bleeding] automatically
	end,
	OnRemoved = function (self, obj)
		obj:RemoveStatusEffectImmunity("Bleeding", self.class) -- this will restore [Bleeding] automatically
	end,
	Icon = "UI/Icons/Perks/Caretaker",
	Tier = "Gold",
	Stat = "Wisdom",
	StatValue = 90,
}

--ShockAndAwe High <GameTerm('Morale')> effect fixed!
UndefineClass('ShockAndAwe')
DefineClass.ShockAndAwe = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnUnitEnterSector",
			Handler = function (self, target, game_start, load_game)
				if not load_game then
					target.team.morale = Max(1, target.team.morale)
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCombatStarting",
			Handler = function (self, target, load_game)
				target.team.morale = Max(1, target.team.morale)
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnBeginTurn",
			Handler = function (self, target)
				target.team.morale = Max(1, target.team.morale)
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcBaseDamage",
			Handler = function (self, target, weapon, attack_target, data)
				if target.team.morale > 0 then
					local damageBonus = self:ResolveValue("highMoraledmgBuff") 
					data.modifier = data.modifier + damageBonus
					data.breakdown[#data.breakdown + 1] = { name = self.DisplayName, value = damageBonus }
				end
			end,
		}),
	},
	DisplayName = T(366436791486, --[[CharacterEffectCompositeDef ShockAndAwe DisplayName]] "Shock and Awe"),
	Description = T(610150756892, --[[CharacterEffectCompositeDef ShockAndAwe Description]] "<em>High</em> <GameTerm('Morale')> when starting combat.\n\nDeal <em><percent(highMoraledmgBuff)></em> extra <em>Damage</em> when <GameTerm('Morale')> is <em>High</em> or <em>Very High</em>."),
	OnAdded = function (self, obj)
		obj:AddStatusEffectImmunity("Panicked", self.class) -- [ShockAndAwe] will invalidate [Panicked] automatically
	end,
	OnRemoved = function (self, obj)
		obj:RemoveStatusEffectImmunity("Panicked", self.class) -- this will restore [Panicked] automatically
	end,
	Icon = "UI/Icons/Perks/ShockAndAwe",
	Tier = "Gold",
	Stat = "Wisdom",
	StatValue = 90,
}

UndefineClass('TrickShot')
DefineClass.TrickShot = {
	__parents = { "Perk" },
	__generated_by_class = "CharacterEffectCompositeDef",


	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcDamageAndEffects",
			Handler = function (self, target, attacker, attack_target, action, weapon, attack_args, hit, data)
				if target == attacker and (attack_target ~= nil and attacker:IsOnEnemySide(attack_target)) and attacker:IsPointBlankRange(attack_target) and IsKindOf(attack_target, "Unit") and (attack_args and attack_args.target_spot_group == "Head") and IsKindOfClasses(weapon, "Pistol", "Revolver") then
					data.base_damage = Max(attack_target:GetTotalHitPoints(), 125) + Max(const.Combat.MaxGrit, 45) -- Handgun "Headshot" will trigger insta-kill!
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnUnitAttack",
			Handler = function (self, target, attacker, action, attack_target, results, attack_args)
				if target == attacker and not results.miss and IsKindOf(attack_target, "Unit") then
					if attack_args.target_spot_group == "Legs" then
						attack_target:AddStatusEffect("KnockDown")
					elseif attack_args.target_spot_group == "Arms" then
						attack_target:AddStatusEffect("Numbness")
					elseif attack_args.target_spot_group == "Groin" then
						attack_target:AddStatusEffect("Exposed")
					end	
				end
			end,
		}),
	},
	DisplayName = T(989219478012, --[[CharacterEffectCompositeDef TrickShot DisplayName]] "Trick Shot"),
	Description = T(287611874277, --[[CharacterEffectCompositeDef TrickShot Description]] "<em>Legs</em> shots apply <GameTerm('Knockdown')>.\n\n<em>Arms</em> shots apply <GameTerm('Numbness')>.\n\n<em>Groin</em> shots apply <GameTerm('Exposed')>."),
	Icon = "UI/Icons/Perks/TrickShot",
	Tier = "Gold",
	Stat = "Wisdom",
	StatValue = 90,
}

-- ========== Tactician Enhanced CharacterEffectDefs Overhaul End ==========