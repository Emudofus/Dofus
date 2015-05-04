package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class TaxCollectorStaticInformations extends Object implements INetworkType
   {
      
      public function TaxCollectorStaticInformations()
      {
         this.guildIdentity = new GuildInformations();
         super();
      }
      
      public static const protocolId:uint = 147;
      
      public var firstNameId:uint = 0;
      
      public var lastNameId:uint = 0;
      
      public var guildIdentity:GuildInformations;
      
      public function getTypeId() : uint
      {
         return 147;
      }
      
      public function initTaxCollectorStaticInformations(param1:uint = 0, param2:uint = 0, param3:GuildInformations = null) : TaxCollectorStaticInformations
      {
         this.firstNameId = param1;
         this.lastNameId = param2;
         this.guildIdentity = param3;
         return this;
      }
      
      public function reset() : void
      {
         this.firstNameId = 0;
         this.lastNameId = 0;
         this.guildIdentity = new GuildInformations();
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_TaxCollectorStaticInformations(param1);
      }
      
      public function serializeAs_TaxCollectorStaticInformations(param1:ICustomDataOutput) : void
      {
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element firstNameId.");
         }
         else
         {
            param1.writeVarShort(this.firstNameId);
            if(this.lastNameId < 0)
            {
               throw new Error("Forbidden value (" + this.lastNameId + ") on element lastNameId.");
            }
            else
            {
               param1.writeVarShort(this.lastNameId);
               this.guildIdentity.serializeAs_GuildInformations(param1);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorStaticInformations(param1);
      }
      
      public function deserializeAs_TaxCollectorStaticInformations(param1:ICustomDataInput) : void
      {
         this.firstNameId = param1.readVarUhShort();
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element of TaxCollectorStaticInformations.firstNameId.");
         }
         else
         {
            this.lastNameId = param1.readVarUhShort();
            if(this.lastNameId < 0)
            {
               throw new Error("Forbidden value (" + this.lastNameId + ") on element of TaxCollectorStaticInformations.lastNameId.");
            }
            else
            {
               this.guildIdentity = new GuildInformations();
               this.guildIdentity.deserialize(param1);
               return;
            }
         }
      }
   }
}
