package com.ankamagames.dofus.network.messages.game.inventory.storage
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class StorageKamasUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function StorageKamasUpdateMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5645;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var kamasTotal:int = 0;
      
      override public function getMessageId() : uint
      {
         return 5645;
      }
      
      public function initStorageKamasUpdateMessage(param1:int = 0) : StorageKamasUpdateMessage
      {
         this.kamasTotal = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.kamasTotal = 0;
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
         this.serializeAs_StorageKamasUpdateMessage(param1);
      }
      
      public function serializeAs_StorageKamasUpdateMessage(param1:ICustomDataOutput) : void
      {
         param1.writeInt(this.kamasTotal);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_StorageKamasUpdateMessage(param1);
      }
      
      public function deserializeAs_StorageKamasUpdateMessage(param1:ICustomDataInput) : void
      {
         this.kamasTotal = param1.readInt();
      }
   }
}
