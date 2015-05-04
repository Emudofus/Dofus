package com.ankamagames.dofus.network.messages.common
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.INetworkDataContainerMessage;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class NetworkDataContainerMessage extends NetworkMessage implements INetworkMessage, INetworkDataContainerMessage
   {
      
      public function NetworkDataContainerMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 2;
      
      private var _content:ByteArray;
      
      private var _isInitialized:Boolean = false;
      
      public function get content() : ByteArray
      {
         return this._content;
      }
      
      public function set content(param1:ByteArray) : void
      {
         this._content = param1;
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2;
      }
      
      public function initNetworkDataContainerMessage(param1:ByteArray = null) : NetworkDataContainerMessage
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
         this.serializeAs_NetworkDataContainerMessage(param1);
      }
      
      public function serializeAs_NetworkDataContainerMessage(param1:ICustomDataOutput) : void
      {
         param1.writeBytes(this.content);
         throw new Error("Not implemented");
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_NetworkDataContainerMessage(param1);
      }
      
      public function deserializeAs_NetworkDataContainerMessage(param1:ICustomDataInput) : void
      {
         var _loc2_:uint = param1.readVarInt();
         var _loc3_:ByteArray = new ByteArray();
         param1.readBytes(_loc3_,0,_loc2_);
         _loc3_.uncompress();
         this.content = _loc3_;
      }
   }
}
