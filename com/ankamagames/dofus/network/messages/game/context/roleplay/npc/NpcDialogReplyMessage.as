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
      
      public function initNpcDialogReplyMessage(replyId:uint = 0) : NpcDialogReplyMessage {
         this.replyId = replyId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.replyId = 0;
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
         this.serializeAs_NpcDialogReplyMessage(output);
      }
      
      public function serializeAs_NpcDialogReplyMessage(output:IDataOutput) : void {
         if(this.replyId < 0)
         {
            throw new Error("Forbidden value (" + this.replyId + ") on element replyId.");
         }
         else
         {
            output.writeShort(this.replyId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_NpcDialogReplyMessage(input);
      }
      
      public function deserializeAs_NpcDialogReplyMessage(input:IDataInput) : void {
         this.replyId = input.readShort();
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
