package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameFightMinimalStats extends Object implements INetworkType
   {
      
      public function GameFightMinimalStats()
      {
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
      
      public var invisibilityState:uint = 0;
      
      public function getTypeId() : uint
      {
         return 31;
      }
      
      public function initGameFightMinimalStats(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:uint = 0, param6:int = 0, param7:int = 0, param8:int = 0, param9:int = 0, param10:int = 0, param11:Boolean = false, param12:int = 0, param13:int = 0, param14:int = 0, param15:int = 0, param16:int = 0, param17:int = 0, param18:int = 0, param19:int = 0, param20:int = 0, param21:int = 0, param22:int = 0, param23:int = 0, param24:uint = 0, param25:uint = 0, param26:int = 0, param27:int = 0, param28:uint = 0) : GameFightMinimalStats
      {
         this.lifePoints = param1;
         this.maxLifePoints = param2;
         this.baseMaxLifePoints = param3;
         this.permanentDamagePercent = param4;
         this.shieldPoints = param5;
         this.actionPoints = param6;
         this.maxActionPoints = param7;
         this.movementPoints = param8;
         this.maxMovementPoints = param9;
         this.summoner = param10;
         this.summoned = param11;
         this.neutralElementResistPercent = param12;
         this.earthElementResistPercent = param13;
         this.waterElementResistPercent = param14;
         this.airElementResistPercent = param15;
         this.fireElementResistPercent = param16;
         this.neutralElementReduction = param17;
         this.earthElementReduction = param18;
         this.waterElementReduction = param19;
         this.airElementReduction = param20;
         this.fireElementReduction = param21;
         this.criticalDamageFixedResist = param22;
         this.pushDamageFixedResist = param23;
         this.dodgePALostProbability = param24;
         this.dodgePMLostProbability = param25;
         this.tackleBlock = param26;
         this.tackleEvade = param27;
         this.invisibilityState = param28;
         return this;
      }
      
      public function reset() : void
      {
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
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightMinimalStats(param1);
      }
      
      public function serializeAs_GameFightMinimalStats(param1:ICustomDataOutput) : void
      {
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
               if(this.baseMaxLifePoints < 0)
               {
                  throw new Error("Forbidden value (" + this.baseMaxLifePoints + ") on element baseMaxLifePoints.");
               }
               else
               {
                  param1.writeVarInt(this.baseMaxLifePoints);
                  if(this.permanentDamagePercent < 0)
                  {
                     throw new Error("Forbidden value (" + this.permanentDamagePercent + ") on element permanentDamagePercent.");
                  }
                  else
                  {
                     param1.writeVarInt(this.permanentDamagePercent);
                     if(this.shieldPoints < 0)
                     {
                        throw new Error("Forbidden value (" + this.shieldPoints + ") on element shieldPoints.");
                     }
                     else
                     {
                        param1.writeVarInt(this.shieldPoints);
                        param1.writeVarShort(this.actionPoints);
                        param1.writeVarShort(this.maxActionPoints);
                        param1.writeVarShort(this.movementPoints);
                        param1.writeVarShort(this.maxMovementPoints);
                        param1.writeInt(this.summoner);
                        param1.writeBoolean(this.summoned);
                        param1.writeVarShort(this.neutralElementResistPercent);
                        param1.writeVarShort(this.earthElementResistPercent);
                        param1.writeVarShort(this.waterElementResistPercent);
                        param1.writeVarShort(this.airElementResistPercent);
                        param1.writeVarShort(this.fireElementResistPercent);
                        param1.writeVarShort(this.neutralElementReduction);
                        param1.writeVarShort(this.earthElementReduction);
                        param1.writeVarShort(this.waterElementReduction);
                        param1.writeVarShort(this.airElementReduction);
                        param1.writeVarShort(this.fireElementReduction);
                        param1.writeVarShort(this.criticalDamageFixedResist);
                        param1.writeVarShort(this.pushDamageFixedResist);
                        if(this.dodgePALostProbability < 0)
                        {
                           throw new Error("Forbidden value (" + this.dodgePALostProbability + ") on element dodgePALostProbability.");
                        }
                        else
                        {
                           param1.writeVarShort(this.dodgePALostProbability);
                           if(this.dodgePMLostProbability < 0)
                           {
                              throw new Error("Forbidden value (" + this.dodgePMLostProbability + ") on element dodgePMLostProbability.");
                           }
                           else
                           {
                              param1.writeVarShort(this.dodgePMLostProbability);
                              param1.writeVarShort(this.tackleBlock);
                              param1.writeVarShort(this.tackleEvade);
                              param1.writeByte(this.invisibilityState);
                              return;
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
         this.deserializeAs_GameFightMinimalStats(param1);
      }
      
      public function deserializeAs_GameFightMinimalStats(param1:ICustomDataInput) : void
      {
         this.lifePoints = param1.readVarUhInt();
         if(this.lifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.lifePoints + ") on element of GameFightMinimalStats.lifePoints.");
         }
         else
         {
            this.maxLifePoints = param1.readVarUhInt();
            if(this.maxLifePoints < 0)
            {
               throw new Error("Forbidden value (" + this.maxLifePoints + ") on element of GameFightMinimalStats.maxLifePoints.");
            }
            else
            {
               this.baseMaxLifePoints = param1.readVarUhInt();
               if(this.baseMaxLifePoints < 0)
               {
                  throw new Error("Forbidden value (" + this.baseMaxLifePoints + ") on element of GameFightMinimalStats.baseMaxLifePoints.");
               }
               else
               {
                  this.permanentDamagePercent = param1.readVarUhInt();
                  if(this.permanentDamagePercent < 0)
                  {
                     throw new Error("Forbidden value (" + this.permanentDamagePercent + ") on element of GameFightMinimalStats.permanentDamagePercent.");
                  }
                  else
                  {
                     this.shieldPoints = param1.readVarUhInt();
                     if(this.shieldPoints < 0)
                     {
                        throw new Error("Forbidden value (" + this.shieldPoints + ") on element of GameFightMinimalStats.shieldPoints.");
                     }
                     else
                     {
                        this.actionPoints = param1.readVarShort();
                        this.maxActionPoints = param1.readVarShort();
                        this.movementPoints = param1.readVarShort();
                        this.maxMovementPoints = param1.readVarShort();
                        this.summoner = param1.readInt();
                        this.summoned = param1.readBoolean();
                        this.neutralElementResistPercent = param1.readVarShort();
                        this.earthElementResistPercent = param1.readVarShort();
                        this.waterElementResistPercent = param1.readVarShort();
                        this.airElementResistPercent = param1.readVarShort();
                        this.fireElementResistPercent = param1.readVarShort();
                        this.neutralElementReduction = param1.readVarShort();
                        this.earthElementReduction = param1.readVarShort();
                        this.waterElementReduction = param1.readVarShort();
                        this.airElementReduction = param1.readVarShort();
                        this.fireElementReduction = param1.readVarShort();
                        this.criticalDamageFixedResist = param1.readVarShort();
                        this.pushDamageFixedResist = param1.readVarShort();
                        this.dodgePALostProbability = param1.readVarUhShort();
                        if(this.dodgePALostProbability < 0)
                        {
                           throw new Error("Forbidden value (" + this.dodgePALostProbability + ") on element of GameFightMinimalStats.dodgePALostProbability.");
                        }
                        else
                        {
                           this.dodgePMLostProbability = param1.readVarUhShort();
                           if(this.dodgePMLostProbability < 0)
                           {
                              throw new Error("Forbidden value (" + this.dodgePMLostProbability + ") on element of GameFightMinimalStats.dodgePMLostProbability.");
                           }
                           else
                           {
                              this.tackleBlock = param1.readVarShort();
                              this.tackleEvade = param1.readVarShort();
                              this.invisibilityState = param1.readByte();
                              if(this.invisibilityState < 0)
                              {
                                 throw new Error("Forbidden value (" + this.invisibilityState + ") on element of GameFightMinimalStats.invisibilityState.");
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
