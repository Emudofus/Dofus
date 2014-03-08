package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class TeleportBuddiesAnswerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TeleportBuddiesAnswerMessage() {
         super();
      }
      
      public static const protocolId:uint = 6294;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var accept:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6294;
      }
      
      public function initTeleportBuddiesAnswerMessage(accept:Boolean=false) : TeleportBuddiesAnswerMessage {
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
         this.serializeAs_TeleportBuddiesAnswerMessage(output);
      }
      
      public function serializeAs_TeleportBuddiesAnswerMessage(output:IDataOutput) : void {
         output.writeBoolean(this.accept);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TeleportBuddiesAnswerMessage(input);
      }
      
      public function deserializeAs_TeleportBuddiesAnswerMessage(input:IDataInput) : void {
         this.accept = input.readBoolean();
      }
   }
}
