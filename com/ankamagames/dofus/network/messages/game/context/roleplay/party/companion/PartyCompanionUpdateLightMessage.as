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
      
      public function initPartyCompanionUpdateLightMessage(partyId:uint=0, id:uint=0, lifePoints:uint=0, maxLifePoints:uint=0, prospecting:uint=0, regenRate:uint=0, indexId:uint=0) : PartyCompanionUpdateLightMessage {
         super.initPartyUpdateLightMessage(partyId,id,lifePoints,maxLifePoints,prospecting,regenRate);
         this.indexId = indexId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.indexId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_PartyCompanionUpdateLightMessage(output);
      }
      
      public function serializeAs_PartyCompanionUpdateLightMessage(output:IDataOutput) : void {
         super.serializeAs_PartyUpdateLightMessage(output);
         if(this.indexId < 0)
         {
            throw new Error("Forbidden value (" + this.indexId + ") on element indexId.");
         }
         else
         {
            output.writeByte(this.indexId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyCompanionUpdateLightMessage(input);
      }
      
      public function deserializeAs_PartyCompanionUpdateLightMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.indexId = input.readByte();
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
