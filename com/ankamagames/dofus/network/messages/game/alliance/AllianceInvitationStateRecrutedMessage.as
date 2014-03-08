package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AllianceInvitationStateRecrutedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceInvitationStateRecrutedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6392;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var invitationState:uint = 0;
      
      override public function getMessageId() : uint {
         return 6392;
      }
      
      public function initAllianceInvitationStateRecrutedMessage(invitationState:uint=0) : AllianceInvitationStateRecrutedMessage {
         this.invitationState = invitationState;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.invitationState = 0;
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
         this.serializeAs_AllianceInvitationStateRecrutedMessage(output);
      }
      
      public function serializeAs_AllianceInvitationStateRecrutedMessage(output:IDataOutput) : void {
         output.writeByte(this.invitationState);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AllianceInvitationStateRecrutedMessage(input);
      }
      
      public function deserializeAs_AllianceInvitationStateRecrutedMessage(input:IDataInput) : void {
         this.invitationState = input.readByte();
         if(this.invitationState < 0)
         {
            throw new Error("Forbidden value (" + this.invitationState + ") on element of AllianceInvitationStateRecrutedMessage.invitationState.");
         }
         else
         {
            return;
         }
      }
   }
}
