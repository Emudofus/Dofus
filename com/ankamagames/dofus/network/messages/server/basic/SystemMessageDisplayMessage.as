package com.ankamagames.dofus.network.messages.server.basic
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class SystemMessageDisplayMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SystemMessageDisplayMessage()
      {
         this.parameters = new Vector.<String>();
         super();
      }
      
      public static const protocolId:uint = 189;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var hangUp:Boolean = false;
      
      public var msgId:uint = 0;
      
      public var parameters:Vector.<String>;
      
      override public function getMessageId() : uint
      {
         return 189;
      }
      
      public function initSystemMessageDisplayMessage(param1:Boolean = false, param2:uint = 0, param3:Vector.<String> = null) : SystemMessageDisplayMessage
      {
         this.hangUp = param1;
         this.msgId = param2;
         this.parameters = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.hangUp = false;
         this.msgId = 0;
         this.parameters = new Vector.<String>();
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
         this.serializeAs_SystemMessageDisplayMessage(param1);
      }
      
      public function serializeAs_SystemMessageDisplayMessage(param1:ICustomDataOutput) : void
      {
         param1.writeBoolean(this.hangUp);
         if(this.msgId < 0)
         {
            throw new Error("Forbidden value (" + this.msgId + ") on element msgId.");
         }
         else
         {
            param1.writeVarShort(this.msgId);
            param1.writeShort(this.parameters.length);
            var _loc2_:uint = 0;
            while(_loc2_ < this.parameters.length)
            {
               param1.writeUTF(this.parameters[_loc2_]);
               _loc2_++;
            }
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_SystemMessageDisplayMessage(param1);
      }
      
      public function deserializeAs_SystemMessageDisplayMessage(param1:ICustomDataInput) : void
      {
         var _loc4_:String = null;
         this.hangUp = param1.readBoolean();
         this.msgId = param1.readVarUhShort();
         if(this.msgId < 0)
         {
            throw new Error("Forbidden value (" + this.msgId + ") on element of SystemMessageDisplayMessage.msgId.");
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
            return;
         }
      }
   }
}
