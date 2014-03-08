package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GameFightMinimalStats extends Object implements INetworkType
   {
      
      public function GameFightMinimalStats() {
         super();
      }
      
      public static const protocolId:uint = 31;
      
      public var lifePoints:uint = 0;
      
      public var maxLifePoints:uint = 0;
      
      public var baseMaxLifePoints:uint = 0;
      
      public var permanentDamagePercent:uint = 0;
      
      public var shieldPoints:uint = 0;
      
      public var actionPoints:int = 0;
      
      public var maxActionPoints:int = 0;
      
      public var movementPoints:int = 0;
      
      public var maxMovementPoints:int = 0;
      
      public var summoner:int = 0;
      
      public var summoned:Boolean = false;
      
      public var neutralElementResistPercent:int = 0;
      
      public var earthElementResistPercent:int = 0;
      
      public var waterElementResistPercent:int = 0;
      
      public var airElementResistPercent:int = 0;
      
      public var fireElementResistPercent:int = 0;
      
      public var neutralElementReduction:int = 0;
      
      public var earthElementReduction:int = 0;
      
      public var waterElementReduction:int = 0;
      
      public var airElementReduction:int = 0;
      
      public var fireElementReduction:int = 0;
      
      public var criticalDamageFixedResist:int = 0;
      
      public var pushDamageFixedResist:int = 0;
      
      public var dodgePALostProbability:uint = 0;
      
      public var dodgePMLostProbability:uint = 0;
      
      public var tackleBlock:int = 0;
      
      public var tackleEvade:int = 0;
      
      public var invisibilityState:int = 0;
      
      public function getTypeId() : uint {
         return 31;
      }
      
      public function initGameFightMinimalStats(lifePoints:uint=0, maxLifePoints:uint=0, baseMaxLifePoints:uint=0, permanentDamagePercent:uint=0, shieldPoints:uint=0, actionPoints:int=0, maxActionPoints:int=0, movementPoints:int=0, maxMovementPoints:int=0, summoner:int=0, summoned:Boolean=false, neutralElementResistPercent:int=0, earthElementResistPercent:int=0, waterElementResistPercent:int=0, airElementResistPercent:int=0, fireElementResistPercent:int=0, neutralElementReduction:int=0, earthElementReduction:int=0, waterElementReduction:int=0, airElementReduction:int=0, fireElementReduction:int=0, criticalDamageFixedResist:int=0, pushDamageFixedResist:int=0, dodgePALostProbability:uint=0, dodgePMLostProbability:uint=0, tackleBlock:int=0, tackleEvade:int=0, invisibilityState:int=0) : GameFightMinimalStats {
         this.lifePoints = lifePoints;
         this.maxLifePoints = maxLifePoints;
         this.baseMaxLifePoints = baseMaxLifePoints;
         this.permanentDamagePercent = permanentDamagePercent;
         this.shieldPoints = shieldPoints;
         this.actionPoints = actionPoints;
         this.maxActionPoints = maxActionPoints;
         this.movementPoints = movementPoints;
         this.maxMovementPoints = maxMovementPoints;
         this.summoner = summoner;
         this.summoned = summoned;
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
         this.criticalDamageFixedResist = criticalDamageFixedResist;
         this.pushDamageFixedResist = pushDamageFixedResist;
         this.dodgePALostProbability = dodgePALostProbability;
         this.dodgePMLostProbability = dodgePMLostProbability;
         this.tackleBlock = tackleBlock;
         this.tackleEvade = tackleEvade;
         this.invisibilityState = invisibilityState;
         return this;
      }
      
      public function reset() : void {
         this.lifePoints = 0;
         this.maxLifePoints = 0;
         this.baseMaxLifePoints = 0;
         this.permanentDamagePercent = 0;
         this.shieldPoints = 0;
         this.actionPoints = 0;
         this.maxActionPoints = 0;
         this.movementPoints = 0;
         this.maxMovementPoints = 0;
         this.summoner = 0;
         this.summoned = false;
         this.neutralElementResistPercent = 0;
         this.earthElementResistPercent = 0;
         this.waterElementResistPercent = 0;
         this.airElementResistPercent = 0;
         this.fireElementResistPercent = 0;
         this.neutralElementReduction = 0;
         this.earthElementReduction = 0;
         this.waterElementReduction = 0;
         this.airElementReduction = 0;
         this.fireElementReduction = 0;
         this.criticalDamageFixedResist = 0;
         this.pushDamageFixedResist = 0;
         this.dodgePALostProbability = 0;
         this.dodgePMLostProbability = 0;
         this.tackleBlock = 0;
         this.tackleEvade = 0;
         this.invisibilityState = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameFightMinimalStats(output);
      }
      
      public function serializeAs_GameFightMinimalStats(output:IDataOutput) : void {
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
               if(this.baseMaxLifePoints < 0)
               {
                  throw new Error("Forbidden value (" + this.baseMaxLifePoints + ") on element baseMaxLifePoints.");
               }
               else
               {
                  output.writeInt(this.baseMaxLifePoints);
                  if(this.permanentDamagePercent < 0)
                  {
                     throw new Error("Forbidden value (" + this.permanentDamagePercent + ") on element permanentDamagePercent.");
                  }
                  else
                  {
                     output.writeInt(this.permanentDamagePercent);
                     if(this.shieldPoints < 0)
                     {
                        throw new Error("Forbidden value (" + this.shieldPoints + ") on element shieldPoints.");
                     }
                     else
                     {
                        output.writeInt(this.shieldPoints);
                        output.writeShort(this.actionPoints);
                        output.writeShort(this.maxActionPoints);
                        output.writeShort(this.movementPoints);
                        output.writeShort(this.maxMovementPoints);
                        output.writeInt(this.summoner);
                        output.writeBoolean(this.summoned);
                        output.writeShort(this.neutralElementResistPercent);
                        output.writeShort(this.earthElementResistPercent);
                        output.writeShort(this.waterElementResistPercent);
                        output.writeShort(this.airElementResistPercent);
                        output.writeShort(this.fireElementResistPercent);
                        output.writeShort(this.neutralElementReduction);
                        output.writeShort(this.earthElementReduction);
                        output.writeShort(this.waterElementReduction);
                        output.writeShort(this.airElementReduction);
                        output.writeShort(this.fireElementReduction);
                        output.writeShort(this.criticalDamageFixedResist);
                        output.writeShort(this.pushDamageFixedResist);
                        if(this.dodgePALostProbability < 0)
                        {
                           throw new Error("Forbidden value (" + this.dodgePALostProbability + ") on element dodgePALostProbability.");
                        }
                        else
                        {
                           output.writeShort(this.dodgePALostProbability);
                           if(this.dodgePMLostProbability < 0)
                           {
                              throw new Error("Forbidden value (" + this.dodgePMLostProbability + ") on element dodgePMLostProbability.");
                           }
                           else
                           {
                              output.writeShort(this.dodgePMLostProbability);
                              output.writeShort(this.tackleBlock);
                              output.writeShort(this.tackleEvade);
                              output.writeByte(this.invisibilityState);
                              return;
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightMinimalStats(input);
      }
      
      public function deserializeAs_GameFightMinimalStats(input:IDataInput) : void {
         this.lifePoints = input.readInt();
         if(this.lifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.lifePoints + ") on element of GameFightMinimalStats.lifePoints.");
         }
         else
         {
            this.maxLifePoints = input.readInt();
            if(this.maxLifePoints < 0)
            {
               throw new Error("Forbidden value (" + this.maxLifePoints + ") on element of GameFightMinimalStats.maxLifePoints.");
            }
            else
            {
               this.baseMaxLifePoints = input.readInt();
               if(this.baseMaxLifePoints < 0)
               {
                  throw new Error("Forbidden value (" + this.baseMaxLifePoints + ") on element of GameFightMinimalStats.baseMaxLifePoints.");
               }
               else
               {
                  this.permanentDamagePercent = input.readInt();
                  if(this.permanentDamagePercent < 0)
                  {
                     throw new Error("Forbidden value (" + this.permanentDamagePercent + ") on element of GameFightMinimalStats.permanentDamagePercent.");
                  }
                  else
                  {
                     this.shieldPoints = input.readInt();
                     if(this.shieldPoints < 0)
                     {
                        throw new Error("Forbidden value (" + this.shieldPoints + ") on element of GameFightMinimalStats.shieldPoints.");
                     }
                     else
                     {
                        this.actionPoints = input.readShort();
                        this.maxActionPoints = input.readShort();
                        this.movementPoints = input.readShort();
                        this.maxMovementPoints = input.readShort();
                        this.summoner = input.readInt();
                        this.summoned = input.readBoolean();
                        this.neutralElementResistPercent = input.readShort();
                        this.earthElementResistPercent = input.readShort();
                        this.waterElementResistPercent = input.readShort();
                        this.airElementResistPercent = input.readShort();
                        this.fireElementResistPercent = input.readShort();
                        this.neutralElementReduction = input.readShort();
                        this.earthElementReduction = input.readShort();
                        this.waterElementReduction = input.readShort();
                        this.airElementReduction = input.readShort();
                        this.fireElementReduction = input.readShort();
                        this.criticalDamageFixedResist = input.readShort();
                        this.pushDamageFixedResist = input.readShort();
                        this.dodgePALostProbability = input.readShort();
                        if(this.dodgePALostProbability < 0)
                        {
                           throw new Error("Forbidden value (" + this.dodgePALostProbability + ") on element of GameFightMinimalStats.dodgePALostProbability.");
                        }
                        else
                        {
                           this.dodgePMLostProbability = input.readShort();
                           if(this.dodgePMLostProbability < 0)
                           {
                              throw new Error("Forbidden value (" + this.dodgePMLostProbability + ") on element of GameFightMinimalStats.dodgePMLostProbability.");
                           }
                           else
                           {
                              this.tackleBlock = input.readShort();
                              this.tackleEvade = input.readShort();
                              this.invisibilityState = input.readByte();
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
