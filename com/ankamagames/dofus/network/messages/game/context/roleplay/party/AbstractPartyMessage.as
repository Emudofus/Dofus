package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AbstractPartyMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AbstractPartyMessage() {
         super();
      }
      
      public static const protocolId:uint = 6274;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var partyId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6274;
      }
      
      public function initAbstractPartyMessage(partyId:uint = 0) : AbstractPartyMessage {
         this.partyId = partyId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.partyId = 0;
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
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_AbstractPartyMessage(output);
      }
      
      public function serializeAs_AbstractPartyMessage(output:IDataOutput) : void {
         if(this.partyId < 0)
         {
            throw new Error("Forbidden value (" + this.partyId + ") on element partyId.");
         }
         else
         {
            output.writeInt(this.partyId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AbstractPartyMessage(input);
      }
      
      public function deserializeAs_AbstractPartyMessage(input:IDataInput) : void {
         this.partyId = input.readInt();
         if(this.partyId < 0)
         {
            throw new Error("Forbidden value (" + this.partyId + ") on element of AbstractPartyMessage.partyId.");
         }
         else
         {
            return;
         }
      }
   }
}
