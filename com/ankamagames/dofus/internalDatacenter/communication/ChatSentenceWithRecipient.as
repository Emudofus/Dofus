package com.ankamagames.dofus.internalDatacenter.communication
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   
   public class ChatSentenceWithRecipient extends ChatSentenceWithSource implements IDataCenter
   {
      
      public function ChatSentenceWithRecipient(id:uint, baseMsg:String, msg:String, channel:uint=0, time:Number=0, finger:String="", senderId:uint=0, senderName:String="", receiverName:String="", receiverId:uint=0, objects:Vector.<ItemWrapper>=null) {
         super(id,baseMsg,msg,channel,time,finger,senderId,senderName,objects);
         this._receiverName = receiverName;
         this._receiverId = receiverId;
      }
      
      private var _receiverName:String;
      
      private var _receiverId:uint;
      
      public function get receiverName() : String {
         return this._receiverName;
      }
      
      public function get receiverId() : uint {
         return this._receiverId;
      }
   }
}
