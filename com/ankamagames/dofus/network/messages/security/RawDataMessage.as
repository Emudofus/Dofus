package com.ankamagames.dofus.network.messages.security
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class RawDataMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function RawDataMessage()
      {
         this.content = new ByteArray();
         super();
      }
      
      public static const protocolId:uint = 6253;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var content:ByteArray;
      
      override public function getMessageId() : uint
      {
         return 6253;
      }
      
      public function initRawDataMessage(param1:ByteArray = null) : RawDataMessage
      {
         this.content = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.content = new ByteArray();
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
         this.serializeAs_RawDataMessage(param1);
      }
      
      public function serializeAs_RawDataMessage(param1:ICustomDataOutput) : void
      {
         param1.writeVarInt(this.content.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.content.length)
         {
            param1.writeByte(this.content[_loc2_]);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_RawDataMessage(param1);
      }
      
      public function deserializeAs_RawDataMessage(param1:ICustomDataInput) : void
      {
         var _loc2_:uint = param1.readVarInt();
         param1.readBytes(this.content,0,_loc2_);
      }
   }
}
