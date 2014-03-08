package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyRefuseInvitationMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public function PartyRefuseInvitationMessage() {
         super();
      }
      
      public static const protocolId:uint = 5582;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint {
         return 5582;
      }
      
      public function initPartyRefuseInvitationMessage(param1:uint=0) : PartyRefuseInvitationMessage {
         super.initAbstractPartyMessage(param1);
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
         this.serializeAs_PartyRefuseInvitationMessage(param1);
      }
      
      public function serializeAs_PartyRefuseInvitationMessage(param1:IDataOutput) : void {
         super.serializeAs_AbstractPartyMessage(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PartyRefuseInvitationMessage(param1);
      }
      
      public function deserializeAs_PartyRefuseInvitationMessage(param1:IDataInput) : void {
         super.deserialize(param1);
      }
   }
}
