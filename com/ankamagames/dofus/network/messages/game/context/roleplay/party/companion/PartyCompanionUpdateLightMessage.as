package com.ankamagames.dofus.network.messages.game.context.roleplay.party.companion
{
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyUpdateLightMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyCompanionUpdateLightMessage extends PartyUpdateLightMessage implements INetworkMessage
   {
      
      public function PartyCompanionUpdateLightMessage() {
         super();
      }
      
      public static const protocolId:uint = 6472;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var indexId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6472;
      }
      
      public function initPartyCompanionUpdateLightMessage(param1:uint=0, param2:uint=0, param3:uint=0, param4:uint=0, param5:uint=0, param6:uint=0, param7:uint=0) : PartyCompanionUpdateLightMessage {
         super.initPartyUpdateLightMessage(param1,param2,param3,param4,param5,param6);
         this.indexId = param7;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.indexId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_PartyCompanionUpdateLightMessage(param1);
      }
      
      public function serializeAs_PartyCompanionUpdateLightMessage(param1:IDataOutput) : void {
         super.serializeAs_PartyUpdateLightMessage(param1);
         if(this.indexId < 0)
         {
            throw new Error("Forbidden value (" + this.indexId + ") on element indexId.");
         }
         else
         {
            param1.writeByte(this.indexId);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PartyCompanionUpdateLightMessage(param1);
      }
      
      public function deserializeAs_PartyCompanionUpdateLightMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.indexId = param1.readByte();
         if(this.indexId < 0)
         {
            throw new Error("Forbidden value (" + this.indexId + ") on element of PartyCompanionUpdateLightMessage.indexId.");
         }
         else
         {
            return;
         }
      }
   }
}
