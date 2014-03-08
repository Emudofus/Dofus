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
      
      public function initNotificationUpdateFlagMessage(index:uint=0) : NotificationUpdateFlagMessage {
         this.index = index;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.index = 0;
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
         this.serializeAs_NotificationUpdateFlagMessage(output);
      }
      
      public function serializeAs_NotificationUpdateFlagMessage(output:IDataOutput) : void {
         if(this.index < 0)
         {
            throw new Error("Forbidden value (" + this.index + ") on element index.");
         }
         else
         {
            output.writeShort(this.index);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_NotificationUpdateFlagMessage(input);
      }
      
      public function deserializeAs_NotificationUpdateFlagMessage(input:IDataInput) : void {
         this.index = input.readShort();
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
