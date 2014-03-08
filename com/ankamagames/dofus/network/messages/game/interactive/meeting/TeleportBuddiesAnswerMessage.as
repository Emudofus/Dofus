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
      
      public function initTeleportBuddiesAnswerMessage(param1:Boolean=false) : TeleportBuddiesAnswerMessage {
         this.accept = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.accept = false;
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
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_TeleportBuddiesAnswerMessage(param1);
      }
      
      public function serializeAs_TeleportBuddiesAnswerMessage(param1:IDataOutput) : void {
         param1.writeBoolean(this.accept);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_TeleportBuddiesAnswerMessage(param1);
      }
      
      public function deserializeAs_TeleportBuddiesAnswerMessage(param1:IDataInput) : void {
         this.accept = param1.readBoolean();
      }
   }
}
