package com.ankamagames.dofus.network.types.game.context.roleplay.party.companion
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class PartyCompanionBaseInformations extends Object implements INetworkType
   {
      
      public function PartyCompanionBaseInformations() {
         this.entityLook = new EntityLook();
         super();
      }
      
      public static const protocolId:uint = 453;
      
      public var indexId:uint = 0;
      
      public var companionGenericId:uint = 0;
      
      public var entityLook:EntityLook;
      
      public function getTypeId() : uint {
         return 453;
      }
      
      public function initPartyCompanionBaseInformations(param1:uint=0, param2:uint=0, param3:EntityLook=null) : PartyCompanionBaseInformations {
         this.indexId = param1;
         this.companionGenericId = param2;
         this.entityLook = param3;
         return this;
      }
      
      public function reset() : void {
         this.indexId = 0;
         this.companionGenericId = 0;
         this.entityLook = new EntityLook();
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_PartyCompanionBaseInformations(param1);
      }
      
      public function serializeAs_PartyCompanionBaseInformations(param1:IDataOutput) : void {
         if(this.indexId < 0)
         {
            throw new Error("Forbidden value (" + this.indexId + ") on element indexId.");
         }
         else
         {
            param1.writeByte(this.indexId);
            if(this.companionGenericId < 0)
            {
               throw new Error("Forbidden value (" + this.companionGenericId + ") on element companionGenericId.");
            }
            else
            {
               param1.writeShort(this.companionGenericId);
               this.entityLook.serializeAs_EntityLook(param1);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PartyCompanionBaseInformations(param1);
      }
      
      public function deserializeAs_PartyCompanionBaseInformations(param1:IDataInput) : void {
         this.indexId = param1.readByte();
         if(this.indexId < 0)
         {
            throw new Error("Forbidden value (" + this.indexId + ") on element of PartyCompanionBaseInformations.indexId.");
         }
         else
         {
            this.companionGenericId = param1.readShort();
            if(this.companionGenericId < 0)
            {
               throw new Error("Forbidden value (" + this.companionGenericId + ") on element of PartyCompanionBaseInformations.companionGenericId.");
            }
            else
            {
               this.entityLook = new EntityLook();
               this.entityLook.deserialize(param1);
               return;
            }
         }
      }
   }
}
