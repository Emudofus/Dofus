package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class FightTeamMemberTaxCollectorInformations extends FightTeamMemberInformations implements INetworkType
   {
      
      public function FightTeamMemberTaxCollectorInformations() {
         super();
      }
      
      public static const protocolId:uint = 177;
      
      public var firstNameId:uint = 0;
      
      public var lastNameId:uint = 0;
      
      public var level:uint = 0;
      
      public var guildId:uint = 0;
      
      public var uid:uint = 0;
      
      override public function getTypeId() : uint {
         return 177;
      }
      
      public function initFightTeamMemberTaxCollectorInformations(param1:int=0, param2:uint=0, param3:uint=0, param4:uint=0, param5:uint=0, param6:uint=0) : FightTeamMemberTaxCollectorInformations {
         super.initFightTeamMemberInformations(param1);
         this.firstNameId = param2;
         this.lastNameId = param3;
         this.level = param4;
         this.guildId = param5;
         this.uid = param6;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.firstNameId = 0;
         this.lastNameId = 0;
         this.level = 0;
         this.guildId = 0;
         this.uid = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_FightTeamMemberTaxCollectorInformations(param1);
      }
      
      public function serializeAs_FightTeamMemberTaxCollectorInformations(param1:IDataOutput) : void {
         super.serializeAs_FightTeamMemberInformations(param1);
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element firstNameId.");
         }
         else
         {
            param1.writeShort(this.firstNameId);
            if(this.lastNameId < 0)
            {
               throw new Error("Forbidden value (" + this.lastNameId + ") on element lastNameId.");
            }
            else
            {
               param1.writeShort(this.lastNameId);
               if(this.level < 1 || this.level > 200)
               {
                  throw new Error("Forbidden value (" + this.level + ") on element level.");
               }
               else
               {
                  param1.writeByte(this.level);
                  if(this.guildId < 0)
                  {
                     throw new Error("Forbidden value (" + this.guildId + ") on element guildId.");
                  }
                  else
                  {
                     param1.writeInt(this.guildId);
                     if(this.uid < 0)
                     {
                        throw new Error("Forbidden value (" + this.uid + ") on element uid.");
                     }
                     else
                     {
                        param1.writeInt(this.uid);
                        return;
                     }
                  }
               }
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_FightTeamMemberTaxCollectorInformations(param1);
      }
      
      public function deserializeAs_FightTeamMemberTaxCollectorInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.firstNameId = param1.readShort();
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element of FightTeamMemberTaxCollectorInformations.firstNameId.");
         }
         else
         {
            this.lastNameId = param1.readShort();
            if(this.lastNameId < 0)
            {
               throw new Error("Forbidden value (" + this.lastNameId + ") on element of FightTeamMemberTaxCollectorInformations.lastNameId.");
            }
            else
            {
               this.level = param1.readUnsignedByte();
               if(this.level < 1 || this.level > 200)
               {
                  throw new Error("Forbidden value (" + this.level + ") on element of FightTeamMemberTaxCollectorInformations.level.");
               }
               else
               {
                  this.guildId = param1.readInt();
                  if(this.guildId < 0)
                  {
                     throw new Error("Forbidden value (" + this.guildId + ") on element of FightTeamMemberTaxCollectorInformations.guildId.");
                  }
                  else
                  {
                     this.uid = param1.readInt();
                     if(this.uid < 0)
                     {
                        throw new Error("Forbidden value (" + this.uid + ") on element of FightTeamMemberTaxCollectorInformations.uid.");
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
