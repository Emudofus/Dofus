package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class NpcDialogReplyMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function NpcDialogReplyMessage() {
         super();
      }
      
      public static const protocolId:uint = 5616;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var replyId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5616;
      }
      
      public function initNpcDialogReplyMessage(param1:uint=0) : NpcDialogReplyMessage {
         this.replyId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.replyId = 0;
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
         this.serializeAs_NpcDialogReplyMessage(param1);
      }
      
      public function serializeAs_NpcDialogReplyMessage(param1:IDataOutput) : void {
         if(this.replyId < 0)
         {
            throw new Error("Forbidden value (" + this.replyId + ") on element replyId.");
         }
         else
         {
            param1.writeShort(this.replyId);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_NpcDialogReplyMessage(param1);
      }
      
      public function deserializeAs_NpcDialogReplyMessage(param1:IDataInput) : void {
         this.replyId = param1.readShort();
         if(this.replyId < 0)
         {
            throw new Error("Forbidden value (" + this.replyId + ") on element of NpcDialogReplyMessage.replyId.");
         }
         else
         {
            return;
         }
      }
   }
}
