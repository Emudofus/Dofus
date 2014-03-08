package com.ankamagames.dofus.network.types.game.context.roleplay.party.companion
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class PartyCompanionMemberInformations extends PartyCompanionBaseInformations implements INetworkType
   {
      
      public function PartyCompanionMemberInformations() {
         super();
      }
      
      public static const protocolId:uint = 452;
      
      public var initiative:uint = 0;
      
      public var lifePoints:uint = 0;
      
      public var maxLifePoints:uint = 0;
      
      public var prospecting:uint = 0;
      
      public var regenRate:uint = 0;
      
      override public function getTypeId() : uint {
         return 452;
      }
      
      public function initPartyCompanionMemberInformations(param1:uint=0, param2:uint=0, param3:EntityLook=null, param4:uint=0, param5:uint=0, param6:uint=0, param7:uint=0, param8:uint=0) : PartyCompanionMemberInformations {
         super.initPartyCompanionBaseInformations(param1,param2,param3);
         this.initiative = param4;
         this.lifePoints = param5;
         this.maxLifePoints = param6;
         this.prospecting = param7;
         this.regenRate = param8;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.initiative = 0;
         this.lifePoints = 0;
         this.maxLifePoints = 0;
         this.prospecting = 0;
         this.regenRate = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_PartyCompanionMemberInformations(param1);
      }
      
      public function serializeAs_PartyCompanionMemberInformations(param1:IDataOutput) : void {
         super.serializeAs_PartyCompanionBaseInformations(param1);
         if(this.initiative < 0)
         {
            throw new Error("Forbidden value (" + this.initiative + ") on element initiative.");
         }
         else
         {
            param1.writeShort(this.initiative);
            if(this.lifePoints < 0)
            {
               throw new Error("Forbidden value (" + this.lifePoints + ") on element lifePoints.");
            }
            else
            {
               param1.writeInt(this.lifePoints);
               if(this.maxLifePoints < 0)
               {
                  throw new Error("Forbidden value (" + this.maxLifePoints + ") on element maxLifePoints.");
               }
               else
               {
                  param1.writeInt(this.maxLifePoints);
                  if(this.prospecting < 0)
                  {
                     throw new Error("Forbidden value (" + this.prospecting + ") on element prospecting.");
                  }
                  else
                  {
                     param1.writeShort(this.prospecting);
                     if(this.regenRate < 0 || this.regenRate > 255)
                     {
                        throw new Error("Forbidden value (" + this.regenRate + ") on element regenRate.");
                     }
                     else
                     {
                        param1.writeByte(this.regenRate);
                        return;
                     }
                  }
               }
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PartyCompanionMemberInformations(param1);
      }
      
      public function deserializeAs_PartyCompanionMemberInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.initiative = param1.readShort();
         if(this.initiative < 0)
         {
            throw new Error("Forbidden value (" + this.initiative + ") on element of PartyCompanionMemberInformations.initiative.");
         }
         else
         {
            this.lifePoints = param1.readInt();
            if(this.lifePoints < 0)
            {
               throw new Error("Forbidden value (" + this.lifePoints + ") on element of PartyCompanionMemberInformations.lifePoints.");
            }
            else
            {
               this.maxLifePoints = param1.readInt();
               if(this.maxLifePoints < 0)
               {
                  throw new Error("Forbidden value (" + this.maxLifePoints + ") on element of PartyCompanionMemberInformations.maxLifePoints.");
               }
               else
               {
                  this.prospecting = param1.readShort();
                  if(this.prospecting < 0)
                  {
                     throw new Error("Forbidden value (" + this.prospecting + ") on element of PartyCompanionMemberInformations.prospecting.");
                  }
                  else
                  {
                     this.regenRate = param1.readUnsignedByte();
                     if(this.regenRate < 0 || this.regenRate > 255)
                     {
                        throw new Error("Forbidden value (" + this.regenRate + ") on element of PartyCompanionMemberInformations.regenRate.");
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
