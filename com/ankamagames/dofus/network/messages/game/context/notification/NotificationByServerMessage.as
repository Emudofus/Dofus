package com.ankamagames.dofus.network.messages.game.context.notification
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class NotificationByServerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function NotificationByServerMessage()
      {
         this.parameters = new Vector.<String>();
         super();
      }
      
      public static const protocolId:uint = 6103;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var id:uint = 0;
      
      public var parameters:Vector.<String>;
      
      public var forceOpen:Boolean = false;
      
      override public function getMessageId() : uint
      {
         return 6103;
      }
      
      public function initNotificationByServerMessage(param1:uint = 0, param2:Vector.<String> = null, param3:Boolean = false) : NotificationByServerMessage
      {
         this.id = param1;
         this.parameters = param2;
         this.forceOpen = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.id = 0;
         this.parameters = new Vector.<String>();
         this.forceOpen = false;
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
         this.serializeAs_NotificationByServerMessage(param1);
      }
      
      public function serializeAs_NotificationByServerMessage(param1:ICustomDataOutput) : void
      {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            param1.writeVarShort(this.id);
            param1.writeShort(this.parameters.length);
            var _loc2_:uint = 0;
            while(_loc2_ < this.parameters.length)
            {
               param1.writeUTF(this.parameters[_loc2_]);
               _loc2_++;
            }
            param1.writeBoolean(this.forceOpen);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_NotificationByServerMessage(param1);
      }
      
      public function deserializeAs_NotificationByServerMessage(param1:ICustomDataInput) : void
      {
         var _loc4_:String = null;
         this.id = param1.readVarUhShort();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of NotificationByServerMessage.id.");
         }
         else
         {
            var _loc2_:uint = param1.readUnsignedShort();
            var _loc3_:uint = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = param1.readUTF();
               this.parameters.push(_loc4_);
               _loc3_++;
            }
            this.forceOpen = param1.readBoolean();
            return;
         }
      }
   }
}
