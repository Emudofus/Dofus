package com.ankamagames.dofus.network.messages.game.inventory.storage
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class StorageKamasUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function StorageKamasUpdateMessage() {
         super();
      }
      
      public static const protocolId:uint = 5645;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var kamasTotal:int = 0;
      
      override public function getMessageId() : uint {
         return 5645;
      }
      
      public function initStorageKamasUpdateMessage(kamasTotal:int = 0) : StorageKamasUpdateMessage {
         this.kamasTotal = kamasTotal;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.kamasTotal = 0;
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
         this.serializeAs_StorageKamasUpdateMessage(output);
      }
      
      public function serializeAs_StorageKamasUpdateMessage(output:IDataOutput) : void {
         output.writeInt(this.kamasTotal);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_StorageKamasUpdateMessage(input);
      }
      
      public function deserializeAs_StorageKamasUpdateMessage(input:IDataInput) : void {
         this.kamasTotal = input.readInt();
      }
   }
}
