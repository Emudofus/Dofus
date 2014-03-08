package com.ankamagames.dofus.network.messages.game.context.notification
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class NotificationUpdateFlagMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function NotificationUpdateFlagMessage() {
         super();
      }
      
      public static const protocolId:uint = 6090;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var index:uint = 0;
      
      override public function getMessageId() : uint {
         return 6090;
      }
      
      public function initNotificationUpdateFlagMessage(param1:uint=0) : NotificationUpdateFlagMessage {
         this.index = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.index = 0;
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
         this.serializeAs_NotificationUpdateFlagMessage(param1);
      }
      
      public function serializeAs_NotificationUpdateFlagMessage(param1:IDataOutput) : void {
         if(this.index < 0)
         {
            throw new Error("Forbidden value (" + this.index + ") on element index.");
         }
         else
         {
            param1.writeShort(this.index);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_NotificationUpdateFlagMessage(param1);
      }
      
      public function deserializeAs_NotificationUpdateFlagMessage(param1:IDataInput) : void {
         this.index = param1.readShort();
         if(this.index < 0)
         {
            throw new Error("Forbidden value (" + this.index + ") on element of NotificationUpdateFlagMessage.index.");
         }
         else
         {
            return;
         }
      }
   }
}
