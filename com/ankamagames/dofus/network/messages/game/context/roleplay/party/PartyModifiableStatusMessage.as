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
      
      public function initPartyModifiableStatusMessage(param1:uint=0, param2:Boolean=false) : PartyModifiableStatusMessage {
         super.initAbstractPartyMessage(param1);
         this.enabled = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.enabled = false;
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
         this.serializeAs_PartyModifiableStatusMessage(param1);
      }
      
      public function serializeAs_PartyModifiableStatusMessage(param1:IDataOutput) : void {
         super.serializeAs_AbstractPartyMessage(param1);
         param1.writeBoolean(this.enabled);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PartyModifiableStatusMessage(param1);
      }
      
      public function deserializeAs_PartyModifiableStatusMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.enabled = param1.readBoolean();
      }
   }
}
