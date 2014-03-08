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
      
      public function initPartyCompanionBaseInformations(indexId:uint=0, companionGenericId:uint=0, entityLook:EntityLook=null) : PartyCompanionBaseInformations {
         this.indexId = indexId;
         this.companionGenericId = companionGenericId;
         this.entityLook = entityLook;
         return this;
      }
      
      public function reset() : void {
         this.indexId = 0;
         this.companionGenericId = 0;
         this.entityLook = new EntityLook();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_PartyCompanionBaseInformations(output);
      }
      
      public function serializeAs_PartyCompanionBaseInformations(output:IDataOutput) : void {
         if(this.indexId < 0)
         {
            throw new Error("Forbidden value (" + this.indexId + ") on element indexId.");
         }
         else
         {
            output.writeByte(this.indexId);
            if(this.companionGenericId < 0)
            {
               throw new Error("Forbidden value (" + this.companionGenericId + ") on element companionGenericId.");
            }
            else
            {
               output.writeShort(this.companionGenericId);
               this.entityLook.serializeAs_EntityLook(output);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyCompanionBaseInformations(input);
      }
      
      public function deserializeAs_PartyCompanionBaseInformations(input:IDataInput) : void {
         this.indexId = input.readByte();
         if(this.indexId < 0)
         {
            throw new Error("Forbidden value (" + this.indexId + ") on element of PartyCompanionBaseInformations.indexId.");
         }
         else
         {
            this.companionGenericId = input.readShort();
            if(this.companionGenericId < 0)
            {
               throw new Error("Forbidden value (" + this.companionGenericId + ") on element of PartyCompanionBaseInformations.companionGenericId.");
            }
            else
            {
               this.entityLook = new EntityLook();
               this.entityLook.deserialize(input);
               return;
            }
         }
      }
   }
}
