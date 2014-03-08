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
      
      public function initFightTeamMemberTaxCollectorInformations(id:int=0, firstNameId:uint=0, lastNameId:uint=0, level:uint=0, guildId:uint=0, uid:uint=0) : FightTeamMemberTaxCollectorInformations {
         super.initFightTeamMemberInformations(id);
         this.firstNameId = firstNameId;
         this.lastNameId = lastNameId;
         this.level = level;
         this.guildId = guildId;
         this.uid = uid;
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_FightTeamMemberTaxCollectorInformations(output);
      }
      
      public function serializeAs_FightTeamMemberTaxCollectorInformations(output:IDataOutput) : void {
         super.serializeAs_FightTeamMemberInformations(output);
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element firstNameId.");
         }
         else
         {
            output.writeShort(this.firstNameId);
            if(this.lastNameId < 0)
            {
               throw new Error("Forbidden value (" + this.lastNameId + ") on element lastNameId.");
            }
            else
            {
               output.writeShort(this.lastNameId);
               if((this.level < 1) || (this.level > 200))
               {
                  throw new Error("Forbidden value (" + this.level + ") on element level.");
               }
               else
               {
                  output.writeByte(this.level);
                  if(this.guildId < 0)
                  {
                     throw new Error("Forbidden value (" + this.guildId + ") on element guildId.");
                  }
                  else
                  {
                     output.writeInt(this.guildId);
                     if(this.uid < 0)
                     {
                        throw new Error("Forbidden value (" + this.uid + ") on element uid.");
                     }
                     else
                     {
                        output.writeInt(this.uid);
                        return;
                     }
                  }
               }
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FightTeamMemberTaxCollectorInformations(input);
      }
      
      public function deserializeAs_FightTeamMemberTaxCollectorInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.firstNameId = input.readShort();
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element of FightTeamMemberTaxCollectorInformations.firstNameId.");
         }
         else
         {
            this.lastNameId = input.readShort();
            if(this.lastNameId < 0)
            {
               throw new Error("Forbidden value (" + this.lastNameId + ") on element of FightTeamMemberTaxCollectorInformations.lastNameId.");
            }
            else
            {
               this.level = input.readUnsignedByte();
               if((this.level < 1) || (this.level > 200))
               {
                  throw new Error("Forbidden value (" + this.level + ") on element of FightTeamMemberTaxCollectorInformations.level.");
               }
               else
               {
                  this.guildId = input.readInt();
                  if(this.guildId < 0)
                  {
                     throw new Error("Forbidden value (" + this.guildId + ") on element of FightTeamMemberTaxCollectorInformations.guildId.");
                  }
                  else
                  {
                     this.uid = input.readInt();
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
