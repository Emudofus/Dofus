package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AllianceInvitationAnswerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceInvitationAnswerMessage() {
         super();
      }
      
      public static const protocolId:uint = 6401;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var accept:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6401;
      }
      
      public function initAllianceInvitationAnswerMessage(accept:Boolean=false) : AllianceInvitationAnswerMessage {
         this.accept = accept;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.accept = false;
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
         this.serializeAs_AllianceInvitationAnswerMessage(output);
      }
      
      public function serializeAs_AllianceInvitationAnswerMessage(output:IDataOutput) : void {
         output.writeBoolean(this.accept);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AllianceInvitationAnswerMessage(input);
      }
      
      public function deserializeAs_AllianceInvitationAnswerMessage(input:IDataInput) : void {
         this.accept = input.readBoolean();
      }
   }
}
