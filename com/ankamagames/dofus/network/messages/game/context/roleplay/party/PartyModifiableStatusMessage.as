package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyModifiableStatusMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public function PartyModifiableStatusMessage() {
         super();
      }
      
      public static const protocolId:uint = 6277;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var enabled:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6277;
      }
      
      public function initPartyModifiableStatusMessage(partyId:uint = 0, enabled:Boolean = false) : PartyModifiableStatusMessage {
         super.initAbstractPartyMessage(partyId);
         this.enabled = enabled;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.enabled = false;
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
         this.serializeAs_PartyModifiableStatusMessage(output);
      }
      
      public function serializeAs_PartyModifiableStatusMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractPartyMessage(output);
         output.writeBoolean(this.enabled);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyModifiableStatusMessage(input);
      }
      
      public function deserializeAs_PartyModifiableStatusMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.enabled = input.readBoolean();
      }
   }
}
