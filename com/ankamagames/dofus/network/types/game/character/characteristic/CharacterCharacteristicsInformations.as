package com.ankamagames.dofus.network.types.game.character.characteristic
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.character.alignment.ActorExtendedAlignmentInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class CharacterCharacteristicsInformations extends Object implements INetworkType
   {
      
      public function CharacterCharacteristicsInformations()
      {
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
      
      public var additionnalPoints:uint = 0;
      
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
      
      public function getTypeId() : uint
      {
         return 8;
      }
      
      public function initCharacterCharacteristicsInformations(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:uint = 0, param5:uint = 0, param6:uint = 0, param7:uint = 0, param8:ActorExtendedAlignmentInformations = null, param9:uint = 0, param10:uint = 0, param11:uint = 0, param12:uint = 0, param13:int = 0, param14:int = 0, param15:CharacterBaseCharacteristic = null, param16:CharacterBaseCharacteristic = null, param17:CharacterBaseCharacteristic = null, param18:CharacterBaseCharacteristic = null, param19:CharacterBaseCharacteristic = null, param20:CharacterBaseCharacteristic = null, param21:CharacterBaseCharacteristic = null, param22:CharacterBaseCharacteristic = null, param23:CharacterBaseCharacteristic = null, param24:CharacterBaseCharacteristic = null, param25:CharacterBaseCharacteristic = null, param26:CharacterBaseCharacteristic = null, param27:CharacterBaseCharacteristic = null, param28:CharacterBaseCharacteristic = null, param29:uint = 0, param30:CharacterBaseCharacteristic = null, param31:CharacterBaseCharacteristic = null, param32:CharacterBaseCharacteristic = null, param33:CharacterBaseCharacteristic = null, param34:CharacterBaseCharacteristic = null, param35:CharacterBaseCharacteristic = null, param36:CharacterBaseCharacteristic = null, param37:CharacterBaseCharacteristic = null, param38:CharacterBaseCharacteristic = null, param39:CharacterBaseCharacteristic = null, param40:CharacterBaseCharacteristic = null, param41:CharacterBaseCharacteristic = null, param42:CharacterBaseCharacteristic = null, param43:CharacterBaseCharacteristic = null, param44:CharacterBaseCharacteristic = null, param45:CharacterBaseCharacteristic = null, param46:CharacterBaseCharacteristic = null, param47:CharacterBaseCharacteristic = null, param48:CharacterBaseCharacteristic = null, param49:CharacterBaseCharacteristic = null, param50:CharacterBaseCharacteristic = null, param51:CharacterBaseCharacteristic = null, param52:CharacterBaseCharacteristic = null, param53:CharacterBaseCharacteristic = null, param54:CharacterBaseCharacteristic = null, param55:CharacterBaseCharacteristic = null, param56:CharacterBaseCharacteristic = null, param57:CharacterBaseCharacteristic = null, param58:CharacterBaseCharacteristic = null, param59:CharacterBaseCharacteristic = null, param60:CharacterBaseCharacteristic = null, param61:CharacterBaseCharacteristic = null, param62:CharacterBaseCharacteristic = null, param63:CharacterBaseCharacteristic = null, param64:CharacterBaseCharacteristic = null, param65:CharacterBaseCharacteristic = null, param66:CharacterBaseCharacteristic = null, param67:CharacterBaseCharacteristic = null, param68:CharacterBaseCharacteristic = null, param69:CharacterBaseCharacteristic = null, param70:CharacterBaseCharacteristic = null, param71:CharacterBaseCharacteristic = null, param72:CharacterBaseCharacteristic = null, param73:CharacterBaseCharacteristic = null, param74:Vector.<CharacterSpellModification> = null, param75:uint = 0) : CharacterCharacteristicsInformations
      {
         this.experience = param1;
         this.experienceLevelFloor = param2;
         this.experienceNextLevelFloor = param3;
         this.kamas = param4;
         this.statsPoints = param5;
         this.additionnalPoints = param6;
         this.spellsPoints = param7;
         this.alignmentInfos = param8;
         this.lifePoints = param9;
         this.maxLifePoints = param10;
         this.energyPoints = param11;
         this.maxEnergyPoints = param12;
         this.actionPointsCurrent = param13;
         this.movementPointsCurrent = param14;
         this.initiative = param15;
         this.prospecting = param16;
         this.actionPoints = param17;
         this.movementPoints = param18;
         this.strength = param19;
         this.vitality = param20;
         this.wisdom = param21;
         this.chance = param22;
         this.agility = param23;
         this.intelligence = param24;
         this.range = param25;
         this.summonableCreaturesBoost = param26;
         this.reflect = param27;
         this.criticalHit = param28;
         this.criticalHitWeapon = param29;
         this.criticalMiss = param30;
         this.healBonus = param31;
         this.allDamagesBonus = param32;
         this.weaponDamagesBonusPercent = param33;
         this.damagesBonusPercent = param34;
         this.trapBonus = param35;
         this.trapBonusPercent = param36;
         this.glyphBonusPercent = param37;
         this.permanentDamagePercent = param38;
         this.tackleBlock = param39;
         this.tackleEvade = param40;
         this.PAAttack = param41;
         this.PMAttack = param42;
         this.pushDamageBonus = param43;
         this.criticalDamageBonus = param44;
         this.neutralDamageBonus = param45;
         this.earthDamageBonus = param46;
         this.waterDamageBonus = param47;
         this.airDamageBonus = param48;
         this.fireDamageBonus = param49;
         this.dodgePALostProbability = param50;
         this.dodgePMLostProbability = param51;
         this.neutralElementResistPercent = param52;
         this.earthElementResistPercent = param53;
         this.waterElementResistPercent = param54;
         this.airElementResistPercent = param55;
         this.fireElementResistPercent = param56;
         this.neutralElementReduction = param57;
         this.earthElementReduction = param58;
         this.waterElementReduction = param59;
         this.airElementReduction = param60;
         this.fireElementReduction = param61;
         this.pushDamageReduction = param62;
         this.criticalDamageReduction = param63;
         this.pvpNeutralElementResistPercent = param64;
         this.pvpEarthElementResistPercent = param65;
         this.pvpWaterElementResistPercent = param66;
         this.pvpAirElementResistPercent = param67;
         this.pvpFireElementResistPercent = param68;
         this.pvpNeutralElementReduction = param69;
         this.pvpEarthElementReduction = param70;
         this.pvpWaterElementReduction = param71;
         this.pvpAirElementReduction = param72;
         this.pvpFireElementReduction = param73;
         this.spellModifications = param74;
         this.probationTime = param75;
         return this;
      }
      
      public function reset() : void
      {
         this.experience = 0;
         this.experienceLevelFloor = 0;
         this.experienceNextLevelFloor = 0;
         this.kamas = 0;
         this.statsPoints = 0;
         this.additionnalPoints = 0;
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
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterCharacteristicsInformations(param1);
      }
      
      public function serializeAs_CharacterCharacteristicsInformations(param1:ICustomDataOutput) : void
      {
         if(this.experience < 0 || this.experience > 9.007199254740992E15)
         {
            throw new Error("Forbidden value (" + this.experience + ") on element experience.");
         }
         else
         {
            param1.writeVarLong(this.experience);
            if(this.experienceLevelFloor < 0 || this.experienceLevelFloor > 9.007199254740992E15)
            {
               throw new Error("Forbidden value (" + this.experienceLevelFloor + ") on element experienceLevelFloor.");
            }
            else
            {
               param1.writeVarLong(this.experienceLevelFloor);
               if(this.experienceNextLevelFloor < 0 || this.experienceNextLevelFloor > 9.007199254740992E15)
               {
                  throw new Error("Forbidden value (" + this.experienceNextLevelFloor + ") on element experienceNextLevelFloor.");
               }
               else
               {
                  param1.writeVarLong(this.experienceNextLevelFloor);
                  if(this.kamas < 0)
                  {
                     throw new Error("Forbidden value (" + this.kamas + ") on element kamas.");
                  }
                  else
                  {
                     param1.writeInt(this.kamas);
                     if(this.statsPoints < 0)
                     {
                        throw new Error("Forbidden value (" + this.statsPoints + ") on element statsPoints.");
                     }
                     else
                     {
                        param1.writeVarShort(this.statsPoints);
                        if(this.additionnalPoints < 0)
                        {
                           throw new Error("Forbidden value (" + this.additionnalPoints + ") on element additionnalPoints.");
                        }
                        else
                        {
                           param1.writeVarShort(this.additionnalPoints);
                           if(this.spellsPoints < 0)
                           {
                              throw new Error("Forbidden value (" + this.spellsPoints + ") on element spellsPoints.");
                           }
                           else
                           {
                              param1.writeVarShort(this.spellsPoints);
                              this.alignmentInfos.serializeAs_ActorExtendedAlignmentInformations(param1);
                              if(this.lifePoints < 0)
                              {
                                 throw new Error("Forbidden value (" + this.lifePoints + ") on element lifePoints.");
                              }
                              else
                              {
                                 param1.writeVarInt(this.lifePoints);
                                 if(this.maxLifePoints < 0)
                                 {
                                    throw new Error("Forbidden value (" + this.maxLifePoints + ") on element maxLifePoints.");
                                 }
                                 else
                                 {
                                    param1.writeVarInt(this.maxLifePoints);
                                    if(this.energyPoints < 0)
                                    {
                                       throw new Error("Forbidden value (" + this.energyPoints + ") on element energyPoints.");
                                    }
                                    else
                                    {
                                       param1.writeVarShort(this.energyPoints);
                                       if(this.maxEnergyPoints < 0)
                                       {
                                          throw new Error("Forbidden value (" + this.maxEnergyPoints + ") on element maxEnergyPoints.");
                                       }
                                       else
                                       {
                                          param1.writeVarShort(this.maxEnergyPoints);
                                          param1.writeVarShort(this.actionPointsCurrent);
                                          param1.writeVarShort(this.movementPointsCurrent);
                                          this.initiative.serializeAs_CharacterBaseCharacteristic(param1);
                                          this.prospecting.serializeAs_CharacterBaseCharacteristic(param1);
                                          this.actionPoints.serializeAs_CharacterBaseCharacteristic(param1);
                                          this.movementPoints.serializeAs_CharacterBaseCharacteristic(param1);
                                          this.strength.serializeAs_CharacterBaseCharacteristic(param1);
                                          this.vitality.serializeAs_CharacterBaseCharacteristic(param1);
                                          this.wisdom.serializeAs_CharacterBaseCharacteristic(param1);
                                          this.chance.serializeAs_CharacterBaseCharacteristic(param1);
                                          this.agility.serializeAs_CharacterBaseCharacteristic(param1);
                                          this.intelligence.serializeAs_CharacterBaseCharacteristic(param1);
                                          this.range.serializeAs_CharacterBaseCharacteristic(param1);
                                          this.summonableCreaturesBoost.serializeAs_CharacterBaseCharacteristic(param1);
                                          this.reflect.serializeAs_CharacterBaseCharacteristic(param1);
                                          this.criticalHit.serializeAs_CharacterBaseCharacteristic(param1);
                                          if(this.criticalHitWeapon < 0)
                                          {
                                             throw new Error("Forbidden value (" + this.criticalHitWeapon + ") on element criticalHitWeapon.");
                                          }
                                          else
                                          {
                                             param1.writeVarShort(this.criticalHitWeapon);
                                             this.criticalMiss.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.healBonus.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.allDamagesBonus.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.weaponDamagesBonusPercent.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.damagesBonusPercent.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.trapBonus.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.trapBonusPercent.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.glyphBonusPercent.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.permanentDamagePercent.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.tackleBlock.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.tackleEvade.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.PAAttack.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.PMAttack.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.pushDamageBonus.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.criticalDamageBonus.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.neutralDamageBonus.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.earthDamageBonus.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.waterDamageBonus.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.airDamageBonus.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.fireDamageBonus.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.dodgePALostProbability.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.dodgePMLostProbability.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.neutralElementResistPercent.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.earthElementResistPercent.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.waterElementResistPercent.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.airElementResistPercent.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.fireElementResistPercent.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.neutralElementReduction.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.earthElementReduction.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.waterElementReduction.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.airElementReduction.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.fireElementReduction.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.pushDamageReduction.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.criticalDamageReduction.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.pvpNeutralElementResistPercent.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.pvpEarthElementResistPercent.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.pvpWaterElementResistPercent.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.pvpAirElementResistPercent.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.pvpFireElementResistPercent.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.pvpNeutralElementReduction.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.pvpEarthElementReduction.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.pvpWaterElementReduction.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.pvpAirElementReduction.serializeAs_CharacterBaseCharacteristic(param1);
                                             this.pvpFireElementReduction.serializeAs_CharacterBaseCharacteristic(param1);
                                             param1.writeShort(this.spellModifications.length);
                                             var _loc2_:uint = 0;
                                             while(_loc2_ < this.spellModifications.length)
                                             {
                                                (this.spellModifications[_loc2_] as CharacterSpellModification).serializeAs_CharacterSpellModification(param1);
                                                _loc2_++;
                                             }
                                             if(this.probationTime < 0)
                                             {
                                                throw new Error("Forbidden value (" + this.probationTime + ") on element probationTime.");
                                             }
                                             else
                                             {
                                                param1.writeInt(this.probationTime);
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
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterCharacteristicsInformations(param1);
      }
      
      public function deserializeAs_CharacterCharacteristicsInformations(param1:ICustomDataInput) : void
      {
         var _loc4_:CharacterSpellModification = null;
         this.experience = param1.readVarUhLong();
         if(this.experience < 0 || this.experience > 9.007199254740992E15)
         {
            throw new Error("Forbidden value (" + this.experience + ") on element of CharacterCharacteristicsInformations.experience.");
         }
         else
         {
            this.experienceLevelFloor = param1.readVarUhLong();
            if(this.experienceLevelFloor < 0 || this.experienceLevelFloor > 9.007199254740992E15)
            {
               throw new Error("Forbidden value (" + this.experienceLevelFloor + ") on element of CharacterCharacteristicsInformations.experienceLevelFloor.");
            }
            else
            {
               this.experienceNextLevelFloor = param1.readVarUhLong();
               if(this.experienceNextLevelFloor < 0 || this.experienceNextLevelFloor > 9.007199254740992E15)
               {
                  throw new Error("Forbidden value (" + this.experienceNextLevelFloor + ") on element of CharacterCharacteristicsInformations.experienceNextLevelFloor.");
               }
               else
               {
                  this.kamas = param1.readInt();
                  if(this.kamas < 0)
                  {
                     throw new Error("Forbidden value (" + this.kamas + ") on element of CharacterCharacteristicsInformations.kamas.");
                  }
                  else
                  {
                     this.statsPoints = param1.readVarUhShort();
                     if(this.statsPoints < 0)
                     {
                        throw new Error("Forbidden value (" + this.statsPoints + ") on element of CharacterCharacteristicsInformations.statsPoints.");
                     }
                     else
                     {
                        this.additionnalPoints = param1.readVarUhShort();
                        if(this.additionnalPoints < 0)
                        {
                           throw new Error("Forbidden value (" + this.additionnalPoints + ") on element of CharacterCharacteristicsInformations.additionnalPoints.");
                        }
                        else
                        {
                           this.spellsPoints = param1.readVarUhShort();
                           if(this.spellsPoints < 0)
                           {
                              throw new Error("Forbidden value (" + this.spellsPoints + ") on element of CharacterCharacteristicsInformations.spellsPoints.");
                           }
                           else
                           {
                              this.alignmentInfos = new ActorExtendedAlignmentInformations();
                              this.alignmentInfos.deserialize(param1);
                              this.lifePoints = param1.readVarUhInt();
                              if(this.lifePoints < 0)
                              {
                                 throw new Error("Forbidden value (" + this.lifePoints + ") on element of CharacterCharacteristicsInformations.lifePoints.");
                              }
                              else
                              {
                                 this.maxLifePoints = param1.readVarUhInt();
                                 if(this.maxLifePoints < 0)
                                 {
                                    throw new Error("Forbidden value (" + this.maxLifePoints + ") on element of CharacterCharacteristicsInformations.maxLifePoints.");
                                 }
                                 else
                                 {
                                    this.energyPoints = param1.readVarUhShort();
                                    if(this.energyPoints < 0)
                                    {
                                       throw new Error("Forbidden value (" + this.energyPoints + ") on element of CharacterCharacteristicsInformations.energyPoints.");
                                    }
                                    else
                                    {
                                       this.maxEnergyPoints = param1.readVarUhShort();
                                       if(this.maxEnergyPoints < 0)
                                       {
                                          throw new Error("Forbidden value (" + this.maxEnergyPoints + ") on element of CharacterCharacteristicsInformations.maxEnergyPoints.");
                                       }
                                       else
                                       {
                                          this.actionPointsCurrent = param1.readVarShort();
                                          this.movementPointsCurrent = param1.readVarShort();
                                          this.initiative = new CharacterBaseCharacteristic();
                                          this.initiative.deserialize(param1);
                                          this.prospecting = new CharacterBaseCharacteristic();
                                          this.prospecting.deserialize(param1);
                                          this.actionPoints = new CharacterBaseCharacteristic();
                                          this.actionPoints.deserialize(param1);
                                          this.movementPoints = new CharacterBaseCharacteristic();
                                          this.movementPoints.deserialize(param1);
                                          this.strength = new CharacterBaseCharacteristic();
                                          this.strength.deserialize(param1);
                                          this.vitality = new CharacterBaseCharacteristic();
                                          this.vitality.deserialize(param1);
                                          this.wisdom = new CharacterBaseCharacteristic();
                                          this.wisdom.deserialize(param1);
                                          this.chance = new CharacterBaseCharacteristic();
                                          this.chance.deserialize(param1);
                                          this.agility = new CharacterBaseCharacteristic();
                                          this.agility.deserialize(param1);
                                          this.intelligence = new CharacterBaseCharacteristic();
                                          this.intelligence.deserialize(param1);
                                          this.range = new CharacterBaseCharacteristic();
                                          this.range.deserialize(param1);
                                          this.summonableCreaturesBoost = new CharacterBaseCharacteristic();
                                          this.summonableCreaturesBoost.deserialize(param1);
                                          this.reflect = new CharacterBaseCharacteristic();
                                          this.reflect.deserialize(param1);
                                          this.criticalHit = new CharacterBaseCharacteristic();
                                          this.criticalHit.deserialize(param1);
                                          this.criticalHitWeapon = param1.readVarUhShort();
                                          if(this.criticalHitWeapon < 0)
                                          {
                                             throw new Error("Forbidden value (" + this.criticalHitWeapon + ") on element of CharacterCharacteristicsInformations.criticalHitWeapon.");
                                          }
                                          else
                                          {
                                             this.criticalMiss = new CharacterBaseCharacteristic();
                                             this.criticalMiss.deserialize(param1);
                                             this.healBonus = new CharacterBaseCharacteristic();
                                             this.healBonus.deserialize(param1);
                                             this.allDamagesBonus = new CharacterBaseCharacteristic();
                                             this.allDamagesBonus.deserialize(param1);
                                             this.weaponDamagesBonusPercent = new CharacterBaseCharacteristic();
                                             this.weaponDamagesBonusPercent.deserialize(param1);
                                             this.damagesBonusPercent = new CharacterBaseCharacteristic();
                                             this.damagesBonusPercent.deserialize(param1);
                                             this.trapBonus = new CharacterBaseCharacteristic();
                                             this.trapBonus.deserialize(param1);
                                             this.trapBonusPercent = new CharacterBaseCharacteristic();
                                             this.trapBonusPercent.deserialize(param1);
                                             this.glyphBonusPercent = new CharacterBaseCharacteristic();
                                             this.glyphBonusPercent.deserialize(param1);
                                             this.permanentDamagePercent = new CharacterBaseCharacteristic();
                                             this.permanentDamagePercent.deserialize(param1);
                                             this.tackleBlock = new CharacterBaseCharacteristic();
                                             this.tackleBlock.deserialize(param1);
                                             this.tackleEvade = new CharacterBaseCharacteristic();
                                             this.tackleEvade.deserialize(param1);
                                             this.PAAttack = new CharacterBaseCharacteristic();
                                             this.PAAttack.deserialize(param1);
                                             this.PMAttack = new CharacterBaseCharacteristic();
                                             this.PMAttack.deserialize(param1);
                                             this.pushDamageBonus = new CharacterBaseCharacteristic();
                                             this.pushDamageBonus.deserialize(param1);
                                             this.criticalDamageBonus = new CharacterBaseCharacteristic();
                                             this.criticalDamageBonus.deserialize(param1);
                                             this.neutralDamageBonus = new CharacterBaseCharacteristic();
                                             this.neutralDamageBonus.deserialize(param1);
                                             this.earthDamageBonus = new CharacterBaseCharacteristic();
                                             this.earthDamageBonus.deserialize(param1);
                                             this.waterDamageBonus = new CharacterBaseCharacteristic();
                                             this.waterDamageBonus.deserialize(param1);
                                             this.airDamageBonus = new CharacterBaseCharacteristic();
                                             this.airDamageBonus.deserialize(param1);
                                             this.fireDamageBonus = new CharacterBaseCharacteristic();
                                             this.fireDamageBonus.deserialize(param1);
                                             this.dodgePALostProbability = new CharacterBaseCharacteristic();
                                             this.dodgePALostProbability.deserialize(param1);
                                             this.dodgePMLostProbability = new CharacterBaseCharacteristic();
                                             this.dodgePMLostProbability.deserialize(param1);
                                             this.neutralElementResistPercent = new CharacterBaseCharacteristic();
                                             this.neutralElementResistPercent.deserialize(param1);
                                             this.earthElementResistPercent = new CharacterBaseCharacteristic();
                                             this.earthElementResistPercent.deserialize(param1);
                                             this.waterElementResistPercent = new CharacterBaseCharacteristic();
                                             this.waterElementResistPercent.deserialize(param1);
                                             this.airElementResistPercent = new CharacterBaseCharacteristic();
                                             this.airElementResistPercent.deserialize(param1);
                                             this.fireElementResistPercent = new CharacterBaseCharacteristic();
                                             this.fireElementResistPercent.deserialize(param1);
                                             this.neutralElementReduction = new CharacterBaseCharacteristic();
                                             this.neutralElementReduction.deserialize(param1);
                                             this.earthElementReduction = new CharacterBaseCharacteristic();
                                             this.earthElementReduction.deserialize(param1);
                                             this.waterElementReduction = new CharacterBaseCharacteristic();
                                             this.waterElementReduction.deserialize(param1);
                                             this.airElementReduction = new CharacterBaseCharacteristic();
                                             this.airElementReduction.deserialize(param1);
                                             this.fireElementReduction = new CharacterBaseCharacteristic();
                                             this.fireElementReduction.deserialize(param1);
                                             this.pushDamageReduction = new CharacterBaseCharacteristic();
                                             this.pushDamageReduction.deserialize(param1);
                                             this.criticalDamageReduction = new CharacterBaseCharacteristic();
                                             this.criticalDamageReduction.deserialize(param1);
                                             this.pvpNeutralElementResistPercent = new CharacterBaseCharacteristic();
                                             this.pvpNeutralElementResistPercent.deserialize(param1);
                                             this.pvpEarthElementResistPercent = new CharacterBaseCharacteristic();
                                             this.pvpEarthElementResistPercent.deserialize(param1);
                                             this.pvpWaterElementResistPercent = new CharacterBaseCharacteristic();
                                             this.pvpWaterElementResistPercent.deserialize(param1);
                                             this.pvpAirElementResistPercent = new CharacterBaseCharacteristic();
                                             this.pvpAirElementResistPercent.deserialize(param1);
                                             this.pvpFireElementResistPercent = new CharacterBaseCharacteristic();
                                             this.pvpFireElementResistPercent.deserialize(param1);
                                             this.pvpNeutralElementReduction = new CharacterBaseCharacteristic();
                                             this.pvpNeutralElementReduction.deserialize(param1);
                                             this.pvpEarthElementReduction = new CharacterBaseCharacteristic();
                                             this.pvpEarthElementReduction.deserialize(param1);
                                             this.pvpWaterElementReduction = new CharacterBaseCharacteristic();
                                             this.pvpWaterElementReduction.deserialize(param1);
                                             this.pvpAirElementReduction = new CharacterBaseCharacteristic();
                                             this.pvpAirElementReduction.deserialize(param1);
                                             this.pvpFireElementReduction = new CharacterBaseCharacteristic();
                                             this.pvpFireElementReduction.deserialize(param1);
                                             var _loc2_:uint = param1.readUnsignedShort();
                                             var _loc3_:uint = 0;
                                             while(_loc3_ < _loc2_)
                                             {
                                                _loc4_ = new CharacterSpellModification();
                                                _loc4_.deserialize(param1);
                                                this.spellModifications.push(_loc4_);
                                                _loc3_++;
                                             }
                                             this.probationTime = param1.readInt();
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
}
