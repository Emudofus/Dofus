package com.ankamagames.dofus.network.messages.game.context.notification
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class NotificationListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function NotificationListMessage()
      {
         this.flags = new Vector.<int>();
         super();
      }
      
      public static const protocolId:uint = 6087;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var flags:Vector.<int>;
      
      override public function getMessageId() : uint
      {
         return 6087;
      }
      
      public function initNotificationListMessage(param1:Vector.<int> = null) : NotificationListMessage
      {
         this.flags = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.flags = new Vector.<int>();
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_NotificationListMessage(param1);
      }
      
      public function serializeAs_NotificationListMessage(param1:ICustomDataOutput) : void
      {
         param1.writeShort(this.flags.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.flags.length)
         {
            param1.writeVarInt(this.flags[_loc2_]);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_NotificationListMessage(param1);
      }
      
      public function deserializeAs_NotificationListMessage(param1:ICustomDataInput) : void
      {
         var _loc4_:* = 0;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readVarInt();
            this.flags.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
