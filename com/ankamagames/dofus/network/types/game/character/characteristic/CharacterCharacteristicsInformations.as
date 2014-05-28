package com.ankamagames.dofus.network.types.game.character.characteristic
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.character.alignment.ActorExtendedAlignmentInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class CharacterCharacteristicsInformations extends Object implements INetworkType
   {
      
      public function CharacterCharacteristicsInformations() {
         this.alignmentInfos = new ActorExtendedAlignmentInformations();
         this.initiative = new CharacterBaseCharacteristic();
         this.prospecting = new CharacterBaseCharacteristic();
         this.actionPoints = new CharacterBaseCharacteristic();
         this.movementPoints = new CharacterBaseCharacteristic();
         this.strength = new CharacterBaseCharacteristic();
         this.vitality = new CharacterBaseCharacteristic();
         this.wisdom = new CharacterBaseCharacteristic();
         this.chance = new CharacterBaseCharacteristic();
         this.agility = new CharacterBaseCharacteristic();
         this.intelligence = new CharacterBaseCharacteristic();
         this.range = new CharacterBaseCharacteristic();
         this.summonableCreaturesBoost = new CharacterBaseCharacteristic();
         this.reflect = new CharacterBaseCharacteristic();
         this.criticalHit = new CharacterBaseCharacteristic();
         this.criticalMiss = new CharacterBaseCharacteristic();
         this.healBonus = new CharacterBaseCharacteristic();
         this.allDamagesBonus = new CharacterBaseCharacteristic();
         this.weaponDamagesBonusPercent = new CharacterBaseCharacteristic();
         this.damagesBonusPercent = new CharacterBaseCharacteristic();
         this.trapBonus = new CharacterBaseCharacteristic();
         this.trapBonusPercent = new CharacterBaseCharacteristic();
         this.glyphBonusPercent = new CharacterBaseCharacteristic();
         this.permanentDamagePercent = new CharacterBaseCharacteristic();
         this.tackleBlock = new CharacterBaseCharacteristic();
         this.tackleEvade = new CharacterBaseCharacteristic();
         this.PAAttack = new CharacterBaseCharacteristic();
         this.PMAttack = new CharacterBaseCharacteristic();
         this.pushDamageBonus = new CharacterBaseCharacteristic();
         this.criticalDamageBonus = new CharacterBaseCharacteristic();
         this.neutralDamageBonus = new CharacterBaseCharacteristic();
         this.earthDamageBonus = new CharacterBaseCharacteristic();
         this.waterDamageBonus = new CharacterBaseCharacteristic();
         this.airDamageBonus = new CharacterBaseCharacteristic();
         this.fireDamageBonus = new CharacterBaseCharacteristic();
         this.dodgePALostProbability = new CharacterBaseCharacteristic();
         this.dodgePMLostProbability = new CharacterBaseCharacteristic();
         this.neutralElementResistPercent = new CharacterBaseCharacteristic();
         this.earthElementResistPercent = new CharacterBaseCharacteristic();
         this.waterElementResistPercent = new CharacterBaseCharacteristic();
         this.airElementResistPercent = new CharacterBaseCharacteristic();
         this.fireElementResistPercent = new CharacterBaseCharacteristic();
         this.neutralElementReduction = new CharacterBaseCharacteristic();
         this.earthElementReduction = new CharacterBaseCharacteristic();
         this.waterElementReduction = new CharacterBaseCharacteristic();
         this.airElementReduction = new CharacterBaseCharacteristic();
         this.fireElementReduction = new CharacterBaseCharacteristic();
         this.pushDamageReduction = new CharacterBaseCharacteristic();
         this.criticalDamageReduction = new CharacterBaseCharacteristic();
         this.pvpNeutralElementResistPercent = new CharacterBaseCharacteristic();
         this.pvpEarthElementResistPercent = new CharacterBaseCharacteristic();
         this.pvpWaterElementResistPercent = new CharacterBaseCharacteristic();
         this.pvpAirElementResistPercent = new CharacterBaseCharacteristic();
         this.pvpFireElementResistPercent = new CharacterBaseCharacteristic();
         this.pvpNeutralElementReduction = new CharacterBaseCharacteristic();
         this.pvpEarthElementReduction = new CharacterBaseCharacteristic();
         this.pvpWaterElementReduction = new CharacterBaseCharacteristic();
         this.pvpAirElementReduction = new CharacterBaseCharacteristic();
         this.pvpFireElementReduction = new CharacterBaseCharacteristic();
         this.spellModifications = new Vector.<CharacterSpellModification>();
         super();
      }
      
      public static const protocolId:uint = 8;
      
      public var experience:Number = 0;
      
      public var experienceLevelFloor:Number = 0;
      
      public var experienceNextLevelFloor:Number = 0;
      
      public var kamas:uint = 0;
      
      public var statsPoints:uint = 0;
      
      public var spellsPoints:uint = 0;
      
      public var alignmentInfos:ActorExtendedAlignmentInformations;
      
      public var lifePoints:uint = 0;
      
      public var maxLifePoints:uint = 0;
      
      public var energyPoints:uint = 0;
      
      public var maxEnergyPoints:uint = 0;
      
      public var actionPointsCurrent:int = 0;
      
      public var movementPointsCurrent:int = 0;
      
      public var initiative:CharacterBaseCharacteristic;
      
      public var prospecting:CharacterBaseCharacteristic;
      
      public var actionPoints:CharacterBaseCharacteristic;
      
      public var movementPoints:CharacterBaseCharacteristic;
      
      public var strength:CharacterBaseCharacteristic;
      
      public var vitality:CharacterBaseCharacteristic;
      
      public var wisdom:CharacterBaseCharacteristic;
      
      public var chance:CharacterBaseCharacteristic;
      
      public var agility:CharacterBaseCharacteristic;
      
      public var intelligence:CharacterBaseCharacteristic;
      
      public var range:CharacterBaseCharacteristic;
      
      public var summonableCreaturesBoost:CharacterBaseCharacteristic;
      
      public var reflect:CharacterBaseCharacteristic;
      
      public var criticalHit:CharacterBaseCharacteristic;
      
      public var criticalHitWeapon:uint = 0;
      
      public var criticalMiss:CharacterBaseCharacteristic;
      
      public var healBonus:CharacterBaseCharacteristic;
      
      public var allDamagesBonus:CharacterBaseCharacteristic;
      
      public var weaponDamagesBonusPercent:CharacterBaseCharacteristic;
      
      public var damagesBonusPercent:CharacterBaseCharacteristic;
      
      public var trapBonus:CharacterBaseCharacteristic;
      
      public var trapBonusPercent:CharacterBaseCharacteristic;
      
      public var glyphBonusPercent:CharacterBaseCharacteristic;
      
      public var permanentDamagePercent:CharacterBaseCharacteristic;
      
      public var tackleBlock:CharacterBaseCharacteristic;
      
      public var tackleEvade:CharacterBaseCharacteristic;
      
      public var PAAttack:CharacterBaseCharacteristic;
      
      public var PMAttack:CharacterBaseCharacteristic;
      
      public var pushDamageBonus:CharacterBaseCharacteristic;
      
      public var criticalDamageBonus:CharacterBaseCharacteristic;
      
      public var neutralDamageBonus:CharacterBaseCharacteristic;
      
      public var earthDamageBonus:CharacterBaseCharacteristic;
      
      public var waterDamageBonus:CharacterBaseCharacteristic;
      
      public var airDamageBonus:CharacterBaseCharacteristic;
      
      public var fireDamageBonus:CharacterBaseCharacteristic;
      
      public var dodgePALostProbability:CharacterBaseCharacteristic;
      
      public var dodgePMLostProbability:CharacterBaseCharacteristic;
      
      public var neutralElementResistPercent:CharacterBaseCharacteristic;
      
      public var earthElementResistPercent:CharacterBaseCharacteristic;
      
      public var waterElementResistPercent:CharacterBaseCharacteristic;
      
      public var airElementResistPercent:CharacterBaseCharacteristic;
      
      public var fireElementResistPercent:CharacterBaseCharacteristic;
      
      public var neutralElementReduction:CharacterBaseCharacteristic;
      
      public var earthElementReduction:CharacterBaseCharacteristic;
      
      public var waterElementReduction:CharacterBaseCharacteristic;
      
      public var airElementReduction:CharacterBaseCharacteristic;
      
      public var fireElementReduction:CharacterBaseCharacteristic;
      
      public var pushDamageReduction:CharacterBaseCharacteristic;
      
      public var criticalDamageReduction:CharacterBaseCharacteristic;
      
      public var pvpNeutralElementResistPercent:CharacterBaseCharacteristic;
      
      public var pvpEarthElementResistPercent:CharacterBaseCharacteristic;
      
      public var pvpWaterElementResistPercent:CharacterBaseCharacteristic;
      
      public var pvpAirElementResistPercent:CharacterBaseCharacteristic;
      
      public var pvpFireElementResistPercent:CharacterBaseCharacteristic;
      
      public var pvpNeutralElementReduction:CharacterBaseCharacteristic;
      
      public var pvpEarthElementReduction:CharacterBaseCharacteristic;
      
      public var pvpWaterElementReduction:CharacterBaseCharacteristic;
      
      public var pvpAirElementReduction:CharacterBaseCharacteristic;
      
      public var pvpFireElementReduction:CharacterBaseCharacteristic;
      
      public var spellModifications:Vector.<CharacterSpellModification>;
      
      public var probationTime:uint = 0;
      
      public function getTypeId() : uint {
         return 8;
      }
      
      public function initCharacterCharacteristicsInformations(experience:Number = 0, experienceLevelFloor:Number = 0, experienceNextLevelFloor:Number = 0, kamas:uint = 0, statsPoints:uint = 0, spellsPoints:uint = 0, alignmentInfos:ActorExtendedAlignmentInformations = null, lifePoints:uint = 0, maxLifePoints:uint = 0, energyPoints:uint = 0, maxEnergyPoints:uint = 0, actionPointsCurrent:int = 0, movementPointsCurrent:int = 0, initiative:CharacterBaseCharacteristic = null, prospecting:CharacterBaseCharacteristic = null, actionPoints:CharacterBaseCharacteristic = null, movementPoints:CharacterBaseCharacteristic = null, strength:CharacterBaseCharacteristic = null, vitality:CharacterBaseCharacteristic = null, wisdom:CharacterBaseCharacteristic = null, chance:CharacterBaseCharacteristic = null, agility:CharacterBaseCharacteristic = null, intelligence:CharacterBaseCharacteristic = null, range:CharacterBaseCharacteristic = null, summonableCreaturesBoost:CharacterBaseCharacteristic = null, reflect:CharacterBaseCharacteristic = null, criticalHit:CharacterBaseCharacteristic = null, criticalHitWeapon:uint = 0, criticalMiss:CharacterBaseCharacteristic = null, healBonus:CharacterBaseCharacteristic = null, allDamagesBonus:CharacterBaseCharacteristic = null, weaponDamagesBonusPercent:CharacterBaseCharacteristic = null, damagesBonusPercent:CharacterBaseCharacteristic = null, trapBonus:CharacterBaseCharacteristic = null, trapBonusPercent:CharacterBaseCharacteristic = null, glyphBonusPercent:CharacterBaseCharacteristic = null, permanentDamagePercent:CharacterBaseCharacteristic = null, tackleBlock:CharacterBaseCharacteristic = null, tackleEvade:CharacterBaseCharacteristic = null, PAAttack:CharacterBaseCharacteristic = null, PMAttack:CharacterBaseCharacteristic = null, pushDamageBonus:CharacterBaseCharacteristic = null, criticalDamageBonus:CharacterBaseCharacteristic = null, neutralDamageBonus:CharacterBaseCharacteristic = null, earthDamageBonus:CharacterBaseCharacteristic = null, waterDamageBonus:CharacterBaseCharacteristic = null, airDamageBonus:CharacterBaseCharacteristic = null, fireDamageBonus:CharacterBaseCharacteristic = null, dodgePALostProbability:CharacterBaseCharacteristic = null, dodgePMLostProbability:CharacterBaseCharacteristic = null, neutralElementResistPercent:CharacterBaseCharacteristic = null, earthElementResistPercent:CharacterBaseCharacteristic = null, waterElementResistPercent:CharacterBaseCharacteristic = null, airElementResistPercent:CharacterBaseCharacteristic = null, fireElementResistPercent:CharacterBaseCharacteristic = null, neutralElementReduction:CharacterBaseCharacteristic = null, earthElementReduction:CharacterBaseCharacteristic = null, waterElementReduction:CharacterBaseCharacteristic = null, airElementReduction:CharacterBaseCharacteristic = null, fireElementReduction:CharacterBaseCharacteristic = null, pushDamageReduction:CharacterBaseCharacteristic = null, criticalDamageReduction:CharacterBaseCharacteristic = null, pvpNeutralElementResistPercent:CharacterBaseCharacteristic = null, pvpEarthElementResistPercent:CharacterBaseCharacteristic = null, pvpWaterElementResistPercent:CharacterBaseCharacteristic = null, pvpAirElementResistPercent:CharacterBaseCharacteristic = null, pvpFireElementResistPercent:CharacterBaseCharacteristic = null, pvpNeutralElementReduction:CharacterBaseCharacteristic = null, pvpEarthElementReduction:CharacterBaseCharacteristic = null, pvpWaterElementReduction:CharacterBaseCharacteristic = null, pvpAirElementReduction:CharacterBaseCharacteristic = null, pvpFireElementReduction:CharacterBaseCharacteristic = null, spellModifications:Vector.<CharacterSpellModification> = null, probationTime:uint = 0) : CharacterCharacteristicsInformations {
         this.experience = experience;
         this.experienceLevelFloor = experienceLevelFloor;
         this.experienceNextLevelFloor = experienceNextLevelFloor;
         this.kamas = kamas;
         this.statsPoints = statsPoints;
         this.spellsPoints = spellsPoints;
         this.alignmentInfos = alignmentInfos;
         this.lifePoints = lifePoints;
         this.maxLifePoints = maxLifePoints;
         this.energyPoints = energyPoints;
         this.maxEnergyPoints = maxEnergyPoints;
         this.actionPointsCurrent = actionPointsCurrent;
         this.movementPointsCurrent = movementPointsCurrent;
         this.initiative = initiative;
         this.prospecting = prospecting;
         this.actionPoints = actionPoints;
         this.movementPoints = movementPoints;
         this.strength = strength;
         this.vitality = vitality;
         this.wisdom = wisdom;
         this.chance = chance;
         this.agility = agility;
         this.intelligence = intelligence;
         this.range = range;
         this.summonableCreaturesBoost = summonableCreaturesBoost;
         this.reflect = reflect;
         this.criticalHit = criticalHit;
         this.criticalHitWeapon = criticalHitWeapon;
         this.criticalMiss = criticalMiss;
         this.healBonus = healBonus;
         this.allDamagesBonus = allDamagesBonus;
         this.weaponDamagesBonusPercent = weaponDamagesBonusPercent;
         this.damagesBonusPercent = damagesBonusPercent;
         this.trapBonus = trapBonus;
         this.trapBonusPercent = trapBonusPercent;
         this.glyphBonusPercent = glyphBonusPercent;
         this.permanentDamagePercent = permanentDamagePercent;
         this.tackleBlock = tackleBlock;
         this.tackleEvade = tackleEvade;
         this.PAAttack = PAAttack;
         this.PMAttack = PMAttack;
         this.pushDamageBonus = pushDamageBonus;
         this.criticalDamageBonus = criticalDamageBonus;
         this.neutralDamageBonus = neutralDamageBonus;
         this.earthDamageBonus = earthDamageBonus;
         this.waterDamageBonus = waterDamageBonus;
         this.airDamageBonus = airDamageBonus;
         this.fireDamageBonus = fireDamageBonus;
         this.dodgePALostProbability = dodgePALostProbability;
         this.dodgePMLostProbability = dodgePMLostProbability;
         this.neutralElementResistPercent = neutralElementResistPercent;
         this.earthElementResistPercent = earthElementResistPercent;
         this.waterElementResistPercent = waterElementResistPercent;
         this.airElementResistPercent = airElementResistPercent;
         this.fireElementResistPercent = fireElementResistPercent;
         this.neutralElementReduction = neutralElementReduction;
         this.earthElementReduction = earthElementReduction;
         this.waterElementReduction = waterElementReduction;
         this.airElementReduction = airElementReduction;
         this.fireElementReduction = fireElementReduction;
         this.pushDamageReduction = pushDamageReduction;
         this.criticalDamageReduction = criticalDamageReduction;
         this.pvpNeutralElementResistPercent = pvpNeutralElementResistPercent;
         this.pvpEarthElementResistPercent = pvpEarthElementResistPercent;
         this.pvpWaterElementResistPercent = pvpWaterElementResistPercent;
         this.pvpAirElementResistPercent = pvpAirElementResistPercent;
         this.pvpFireElementResistPercent = pvpFireElementResistPercent;
         this.pvpNeutralElementReduction = pvpNeutralElementReduction;
         this.pvpEarthElementReduction = pvpEarthElementReduction;
         this.pvpWaterElementReduction = pvpWaterElementReduction;
         this.pvpAirElementReduction = pvpAirElementReduction;
         this.pvpFireElementReduction = pvpFireElementReduction;
         this.spellModifications = spellModifications;
         this.probationTime = probationTime;
         return this;
      }
      
      public function reset() : void {
         this.experience = 0;
         this.experienceLevelFloor = 0;
         this.experienceNextLevelFloor = 0;
         this.kamas = 0;
         this.statsPoints = 0;
         this.spellsPoints = 0;
         this.alignmentInfos = new ActorExtendedAlignmentInformations();
         this.maxLifePoints = 0;
         this.energyPoints = 0;
         this.maxEnergyPoints = 0;
         this.actionPointsCurrent = 0;
         this.movementPointsCurrent = 0;
         this.initiative = new CharacterBaseCharacteristic();
         this.criticalMiss = new CharacterBaseCharacteristic();
         this.probationTime = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_CharacterCharacteristicsInformations(output);
      }
      
      public function serializeAs_CharacterCharacteristicsInformations(output:IDataOutput) : void {
         if(this.experience < 0)
         {
            throw new Error("Forbidden value (" + this.experience + ") on element experience.");
         }
         else
         {
            output.writeDouble(this.experience);
            if(this.experienceLevelFloor < 0)
            {
               throw new Error("Forbidden value (" + this.experienceLevelFloor + ") on element experienceLevelFloor.");
            }
            else
            {
               output.writeDouble(this.experienceLevelFloor);
               if(this.experienceNextLevelFloor < 0)
               {
                  throw new Error("Forbidden value (" + this.experienceNextLevelFloor + ") on element experienceNextLevelFloor.");
               }
               else
               {
                  output.writeDouble(this.experienceNextLevelFloor);
                  if(this.kamas < 0)
                  {
                     throw new Error("Forbidden value (" + this.kamas + ") on element kamas.");
                  }
                  else
                  {
                     output.writeInt(this.kamas);
                     if(this.statsPoints < 0)
                     {
                        throw new Error("Forbidden value (" + this.statsPoints + ") on element statsPoints.");
                     }
                     else
                     {
                        output.writeInt(this.statsPoints);
                        if(this.spellsPoints < 0)
                        {
                           throw new Error("Forbidden value (" + this.spellsPoints + ") on element spellsPoints.");
                        }
                        else
                        {
                           output.writeInt(this.spellsPoints);
                           this.alignmentInfos.serializeAs_ActorExtendedAlignmentInformations(output);
                           if(this.lifePoints < 0)
                           {
                              throw new Error("Forbidden value (" + this.lifePoints + ") on element lifePoints.");
                           }
                           else
                           {
                              output.writeInt(this.lifePoints);
                              if(this.maxLifePoints < 0)
                              {
                                 throw new Error("Forbidden value (" + this.maxLifePoints + ") on element maxLifePoints.");
                              }
                              else
                              {
                                 output.writeInt(this.maxLifePoints);
                                 if(this.energyPoints < 0)
                                 {
                                    throw new Error("Forbidden value (" + this.energyPoints + ") on element energyPoints.");
                                 }
                                 else
                                 {
                                    output.writeShort(this.energyPoints);
                                    if(this.maxEnergyPoints < 0)
                                    {
                                       throw new Error("Forbidden value (" + this.maxEnergyPoints + ") on element maxEnergyPoints.");
                                    }
                                    else
                                    {
                                       output.writeShort(this.maxEnergyPoints);
                                       output.writeShort(this.actionPointsCurrent);
                                       output.writeShort(this.movementPointsCurrent);
                                       this.initiative.serializeAs_CharacterBaseCharacteristic(output);
                                       this.prospecting.serializeAs_CharacterBaseCharacteristic(output);
                                       this.actionPoints.serializeAs_CharacterBaseCharacteristic(output);
                                       this.movementPoints.serializeAs_CharacterBaseCharacteristic(output);
                                       this.strength.serializeAs_CharacterBaseCharacteristic(output);
                                       this.vitality.serializeAs_CharacterBaseCharacteristic(output);
                                       this.wisdom.serializeAs_CharacterBaseCharacteristic(output);
                                       this.chance.serializeAs_CharacterBaseCharacteristic(output);
                                       this.agility.serializeAs_CharacterBaseCharacteristic(output);
                                       this.intelligence.serializeAs_CharacterBaseCharacteristic(output);
                                       this.range.serializeAs_CharacterBaseCharacteristic(output);
                                       this.summonableCreaturesBoost.serializeAs_CharacterBaseCharacteristic(output);
                                       this.reflect.serializeAs_CharacterBaseCharacteristic(output);
                                       this.criticalHit.serializeAs_CharacterBaseCharacteristic(output);
                                       if(this.criticalHitWeapon < 0)
                                       {
                                          throw new Error("Forbidden value (" + this.criticalHitWeapon + ") on element criticalHitWeapon.");
                                       }
                                       else
                                       {
                                          output.writeShort(this.criticalHitWeapon);
                                          this.criticalMiss.serializeAs_CharacterBaseCharacteristic(output);
                                          this.healBonus.serializeAs_CharacterBaseCharacteristic(output);
                                          this.allDamagesBonus.serializeAs_CharacterBaseCharacteristic(output);
                                          this.weaponDamagesBonusPercent.serializeAs_CharacterBaseCharacteristic(output);
                                          this.damagesBonusPercent.serializeAs_CharacterBaseCharacteristic(output);
                                          this.trapBonus.serializeAs_CharacterBaseCharacteristic(output);
                                          this.trapBonusPercent.serializeAs_CharacterBaseCharacteristic(output);
                                          this.glyphBonusPercent.serializeAs_CharacterBaseCharacteristic(output);
                                          this.permanentDamagePercent.serializeAs_CharacterBaseCharacteristic(output);
                                          this.tackleBlock.serializeAs_CharacterBaseCharacteristic(output);
                                          this.tackleEvade.serializeAs_CharacterBaseCharacteristic(output);
                                          this.PAAttack.serializeAs_CharacterBaseCharacteristic(output);
                                          this.PMAttack.serializeAs_CharacterBaseCharacteristic(output);
                                          this.pushDamageBonus.serializeAs_CharacterBaseCharacteristic(output);
                                          this.criticalDamageBonus.serializeAs_CharacterBaseCharacteristic(output);
                                          this.neutralDamageBonus.serializeAs_CharacterBaseCharacteristic(output);
                                          this.earthDamageBonus.serializeAs_CharacterBaseCharacteristic(output);
                                          this.waterDamageBonus.serializeAs_CharacterBaseCharacteristic(output);
                                          this.airDamageBonus.serializeAs_CharacterBaseCharacteristic(output);
                                          this.fireDamageBonus.serializeAs_CharacterBaseCharacteristic(output);
                                          this.dodgePALostProbability.serializeAs_CharacterBaseCharacteristic(output);
                                          this.dodgePMLostProbability.serializeAs_CharacterBaseCharacteristic(output);
                                          this.neutralElementResistPercent.serializeAs_CharacterBaseCharacteristic(output);
                                          this.earthElementResistPercent.serializeAs_CharacterBaseCharacteristic(output);
                                          this.waterElementResistPercent.serializeAs_CharacterBaseCharacteristic(output);
                                          this.airElementResistPercent.serializeAs_CharacterBaseCharacteristic(output);
                                          this.fireElementResistPercent.serializeAs_CharacterBaseCharacteristic(output);
                                          this.neutralElementReduction.serializeAs_CharacterBaseCharacteristic(output);
                                          this.earthElementReduction.serializeAs_CharacterBaseCharacteristic(output);
                                          this.waterElementReduction.serializeAs_CharacterBaseCharacteristic(output);
                                          this.airElementReduction.serializeAs_CharacterBaseCharacteristic(output);
                                          this.fireElementReduction.serializeAs_CharacterBaseCharacteristic(output);
                                          this.pushDamageReduction.serializeAs_CharacterBaseCharacteristic(output);
                                          this.criticalDamageReduction.serializeAs_CharacterBaseCharacteristic(output);
                                          this.pvpNeutralElementResistPercent.serializeAs_CharacterBaseCharacteristic(output);
                                          this.pvpEarthElementResistPercent.serializeAs_CharacterBaseCharacteristic(output);
                                          this.pvpWaterElementResistPercent.serializeAs_CharacterBaseCharacteristic(output);
                                          this.pvpAirElementResistPercent.serializeAs_CharacterBaseCharacteristic(output);
                                          this.pvpFireElementResistPercent.serializeAs_CharacterBaseCharacteristic(output);
                                          this.pvpNeutralElementReduction.serializeAs_CharacterBaseCharacteristic(output);
                                          this.pvpEarthElementReduction.serializeAs_CharacterBaseCharacteristic(output);
                                          this.pvpWaterElementReduction.serializeAs_CharacterBaseCharacteristic(output);
                                          this.pvpAirElementReduction.serializeAs_CharacterBaseCharacteristic(output);
                                          this.pvpFireElementReduction.serializeAs_CharacterBaseCharacteristic(output);
                                          output.writeShort(this.spellModifications.length);
                                          _i73 = 0;
                                          while(_i73 < this.spellModifications.length)
                                          {
                                             (this.spellModifications[_i73] as CharacterSpellModification).serializeAs_CharacterSpellModification(output);
                                             _i73++;
                                          }
                                          if(this.probationTime < 0)
                                          {
                                             throw new Error("Forbidden value (" + this.probationTime + ") on element probationTime.");
                                          }
                                          else
                                          {
                                             output.writeInt(this.probationTime);
                                             return;
                                          }
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterCharacteristicsInformations(input);
      }
      
      public function deserializeAs_CharacterCharacteristicsInformations(input:IDataInput) : void {
         var _item73:CharacterSpellModification = null;
         this.experience = input.readDouble();
         if(this.experience < 0)
         {
            throw new Error("Forbidden value (" + this.experience + ") on element of CharacterCharacteristicsInformations.experience.");
         }
         else
         {
            this.experienceLevelFloor = input.readDouble();
            if(this.experienceLevelFloor < 0)
            {
               throw new Error("Forbidden value (" + this.experienceLevelFloor + ") on element of CharacterCharacteristicsInformations.experienceLevelFloor.");
            }
            else
            {
               this.experienceNextLevelFloor = input.readDouble();
               if(this.experienceNextLevelFloor < 0)
               {
                  throw new Error("Forbidden value (" + this.experienceNextLevelFloor + ") on element of CharacterCharacteristicsInformations.experienceNextLevelFloor.");
               }
               else
               {
                  this.kamas = input.readInt();
                  if(this.kamas < 0)
                  {
                     throw new Error("Forbidden value (" + this.kamas + ") on element of CharacterCharacteristicsInformations.kamas.");
                  }
                  else
                  {
                     this.statsPoints = input.readInt();
                     if(this.statsPoints < 0)
                     {
                        throw new Error("Forbidden value (" + this.statsPoints + ") on element of CharacterCharacteristicsInformations.statsPoints.");
                     }
                     else
                     {
                        this.spellsPoints = input.readInt();
                        if(this.spellsPoints < 0)
                        {
                           throw new Error("Forbidden value (" + this.spellsPoints + ") on element of CharacterCharacteristicsInformations.spellsPoints.");
                        }
                        else
                        {
                           this.alignmentInfos = new ActorExtendedAlignmentInformations();
                           this.alignmentInfos.deserialize(input);
                           this.lifePoints = input.readInt();
                           if(this.lifePoints < 0)
                           {
                              throw new Error("Forbidden value (" + this.lifePoints + ") on element of CharacterCharacteristicsInformations.lifePoints.");
                           }
                           else
                           {
                              this.maxLifePoints = input.readInt();
                              if(this.maxLifePoints < 0)
                              {
                                 throw new Error("Forbidden value (" + this.maxLifePoints + ") on element of CharacterCharacteristicsInformations.maxLifePoints.");
                              }
                              else
                              {
                                 this.energyPoints = input.readShort();
                                 if(this.energyPoints < 0)
                                 {
                                    throw new Error("Forbidden value (" + this.energyPoints + ") on element of CharacterCharacteristicsInformations.energyPoints.");
                                 }
                                 else
                                 {
                                    this.maxEnergyPoints = input.readShort();
                                    if(this.maxEnergyPoints < 0)
                                    {
                                       throw new Error("Forbidden value (" + this.maxEnergyPoints + ") on element of CharacterCharacteristicsInformations.maxEnergyPoints.");
                                    }
                                    else
                                    {
                                       this.actionPointsCurrent = input.readShort();
                                       this.movementPointsCurrent = input.readShort();
                                       this.initiative = new CharacterBaseCharacteristic();
                                       this.initiative.deserialize(input);
                                       this.prospecting = new CharacterBaseCharacteristic();
                                       this.prospecting.deserialize(input);
                                       this.actionPoints = new CharacterBaseCharacteristic();
                                       this.actionPoints.deserialize(input);
                                       this.movementPoints = new CharacterBaseCharacteristic();
                                       this.movementPoints.deserialize(input);
                                       this.strength = new CharacterBaseCharacteristic();
                                       this.strength.deserialize(input);
                                       this.vitality = new CharacterBaseCharacteristic();
                                       this.vitality.deserialize(input);
                                       this.wisdom = new CharacterBaseCharacteristic();
                                       this.wisdom.deserialize(input);
                                       this.chance = new CharacterBaseCharacteristic();
                                       this.chance.deserialize(input);
                                       this.agility = new CharacterBaseCharacteristic();
                                       this.agility.deserialize(input);
                                       this.intelligence = new CharacterBaseCharacteristic();
                                       this.intelligence.deserialize(input);
                                       this.range = new CharacterBaseCharacteristic();
                                       this.range.deserialize(input);
                                       this.summonableCreaturesBoost = new CharacterBaseCharacteristic();
                                       this.summonableCreaturesBoost.deserialize(input);
                                       this.reflect = new CharacterBaseCharacteristic();
                                       this.reflect.deserialize(input);
                                       this.criticalHit = new CharacterBaseCharacteristic();
                                       this.criticalHit.deserialize(input);
                                       this.criticalHitWeapon = input.readShort();
                                       if(this.criticalHitWeapon < 0)
                                       {
                                          throw new Error("Forbidden value (" + this.criticalHitWeapon + ") on element of CharacterCharacteristicsInformations.criticalHitWeapon.");
                                       }
                                       else
                                       {
                                          this.criticalMiss = new CharacterBaseCharacteristic();
                                          this.criticalMiss.deserialize(input);
                                          this.healBonus = new CharacterBaseCharacteristic();
                                          this.healBonus.deserialize(input);
                                          this.allDamagesBonus = new CharacterBaseCharacteristic();
                                          this.allDamagesBonus.deserialize(input);
                                          this.weaponDamagesBonusPercent = new CharacterBaseCharacteristic();
                                          this.weaponDamagesBonusPercent.deserialize(input);
                                          this.damagesBonusPercent = new CharacterBaseCharacteristic();
                                          this.damagesBonusPercent.deserialize(input);
                                          this.trapBonus = new CharacterBaseCharacteristic();
                                          this.trapBonus.deserialize(input);
                                          this.trapBonusPercent = new CharacterBaseCharacteristic();
                                          this.trapBonusPercent.deserialize(input);
                                          this.glyphBonusPercent = new CharacterBaseCharacteristic();
                                          this.glyphBonusPercent.deserialize(input);
                                          this.permanentDamagePercent = new CharacterBaseCharacteristic();
                                          this.permanentDamagePercent.deserialize(input);
                                          this.tackleBlock = new CharacterBaseCharacteristic();
                                          this.tackleBlock.deserialize(input);
                                          this.tackleEvade = new CharacterBaseCharacteristic();
                                          this.tackleEvade.deserialize(input);
                                          this.PAAttack = new CharacterBaseCharacteristic();
                                          this.PAAttack.deserialize(input);
                                          this.PMAttack = new CharacterBaseCharacteristic();
                                          this.PMAttack.deserialize(input);
                                          this.pushDamageBonus = new CharacterBaseCharacteristic();
                                          this.pushDamageBonus.deserialize(input);
                                          this.criticalDamageBonus = new CharacterBaseCharacteristic();
                                          this.criticalDamageBonus.deserialize(input);
                                          this.neutralDamageBonus = new CharacterBaseCharacteristic();
                                          this.neutralDamageBonus.deserialize(input);
                                          this.earthDamageBonus = new CharacterBaseCharacteristic();
                                          this.earthDamageBonus.deserialize(input);
                                          this.waterDamageBonus = new CharacterBaseCharacteristic();
                                          this.waterDamageBonus.deserialize(input);
                                          this.airDamageBonus = new CharacterBaseCharacteristic();
                                          this.airDamageBonus.deserialize(input);
                                          this.fireDamageBonus = new CharacterBaseCharacteristic();
                                          this.fireDamageBonus.deserialize(input);
                                          this.dodgePALostProbability = new CharacterBaseCharacteristic();
                                          this.dodgePALostProbability.deserialize(input);
                                          this.dodgePMLostProbability = new CharacterBaseCharacteristic();
                                          this.dodgePMLostProbability.deserialize(input);
                                          this.neutralElementResistPercent = new CharacterBaseCharacteristic();
                                          this.neutralElementResistPercent.deserialize(input);
                                          this.earthElementResistPercent = new CharacterBaseCharacteristic();
                                          this.earthElementResistPercent.deserialize(input);
                                          this.waterElementResistPercent = new CharacterBaseCharacteristic();
                                          this.waterElementResistPercent.deserialize(input);
                                          this.airElementResistPercent = new CharacterBaseCharacteristic();
                                          this.airElementResistPercent.deserialize(input);
                                          this.fireElementResistPercent = new CharacterBaseCharacteristic();
                                          this.fireElementResistPercent.deserialize(input);
                                          this.neutralElementReduction = new CharacterBaseCharacteristic();
                                          this.neutralElementReduction.deserialize(input);
                                          this.earthElementReduction = new CharacterBaseCharacteristic();
                                          this.earthElementReduction.deserialize(input);
                                          this.waterElementReduction = new CharacterBaseCharacteristic();
                                          this.waterElementReduction.deserialize(input);
                                          this.airElementReduction = new CharacterBaseCharacteristic();
                                          this.airElementReduction.deserialize(input);
                                          this.fireElementReduction = new CharacterBaseCharacteristic();
                                          this.fireElementReduction.deserialize(input);
                                          this.pushDamageReduction = new CharacterBaseCharacteristic();
                                          this.pushDamageReduction.deserialize(input);
                                          this.criticalDamageReduction = new CharacterBaseCharacteristic();
                                          this.criticalDamageReduction.deserialize(input);
                                          this.pvpNeutralElementResistPercent = new CharacterBaseCharacteristic();
                                          this.pvpNeutralElementResistPercent.deserialize(input);
                                          this.pvpEarthElementResistPercent = new CharacterBaseCharacteristic();
                                          this.pvpEarthElementResistPercent.deserialize(input);
                                          this.pvpWaterElementResistPercent = new CharacterBaseCharacteristic();
                                          this.pvpWaterElementResistPercent.deserialize(input);
                                          this.pvpAirElementResistPercent = new CharacterBaseCharacteristic();
                                          this.pvpAirElementResistPercent.deserialize(input);
                                          this.pvpFireElementResistPercent = new CharacterBaseCharacteristic();
                                          this.pvpFireElementResistPercent.deserialize(input);
                                          this.pvpNeutralElementReduction = new CharacterBaseCharacteristic();
                                          this.pvpNeutralElementReduction.deserialize(input);
                                          this.pvpEarthElementReduction = new CharacterBaseCharacteristic();
                                          this.pvpEarthElementReduction.deserialize(input);
                                          this.pvpWaterElementReduction = new CharacterBaseCharacteristic();
                                          this.pvpWaterElementReduction.deserialize(input);
                                          this.pvpAirElementReduction = new CharacterBaseCharacteristic();
                                          this.pvpAirElementReduction.deserialize(input);
                                          this.pvpFireElementReduction = new CharacterBaseCharacteristic();
                                          this.pvpFireElementReduction.deserialize(input);
                                          _spellModificationsLen = input.readUnsignedShort();
                                          _i73 = 0;
                                          while(_i73 < _spellModificationsLen)
                                          {
                                             _item73 = new CharacterSpellModification();
                                             _item73.deserialize(input);
                                             this.spellModifications.push(_item73);
                                             _i73++;
                                          }
                                          this.probationTime = input.readInt();
                                          if(this.probationTime < 0)
                                          {
                                             throw new Error("Forbidden value (" + this.probationTime + ") on element of CharacterCharacteristicsInformations.probationTime.");
                                          }
                                          else
                                          {
                                             return;
                                          }
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
   }
}
