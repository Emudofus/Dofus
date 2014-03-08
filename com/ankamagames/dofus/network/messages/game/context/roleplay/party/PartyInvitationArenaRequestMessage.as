package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyInvitationArenaRequestMessage extends PartyInvitationRequestMessage implements INetworkMessage
   {
      
      public function PartyInvitationArenaRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6283;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint {
         return 6283;
      }
      
      public function initPartyInvitationArenaRequestMessage(param1:String="") : PartyInvitationArenaRequestMessage {
         super.initPartyInvitationRequestMessage(param1);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
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
         this.serializeAs_PartyInvitationArenaRequestMessage(param1);
      }
      
      public function serializeAs_PartyInvitationArenaRequestMessage(param1:IDataOutput) : void {
         super.serializeAs_PartyInvitationRequestMessage(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PartyInvitationArenaRequestMessage(param1);
      }
      
      public function deserializeAs_PartyInvitationArenaRequestMessage(param1:IDataInput) : void {
         super.deserialize(param1);
      }
   }
}
