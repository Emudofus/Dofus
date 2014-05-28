package com.ankamagames.dofus.network.messages.game.inventory.storage
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class StorageObjectRemoveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function StorageObjectRemoveMessage() {
         super();
      }
      
      public static const protocolId:uint = 5648;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var objectUID:uint = 0;
      
      override public function getMessageId() : uint {
         return 5648;
      }
      
      public function initStorageObjectRemoveMessage(objectUID:uint = 0) : StorageObjectRemoveMessage {
         this.objectUID = objectUID;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.objectUID = 0;
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
         this.serializeAs_StorageObjectRemoveMessage(output);
      }
      
      public function serializeAs_StorageObjectRemoveMessage(output:IDataOutput) : void {
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
         }
         else
         {
            output.writeInt(this.objectUID);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_StorageObjectRemoveMessage(input);
      }
      
      public function deserializeAs_StorageObjectRemoveMessage(input:IDataInput) : void {
         this.objectUID = input.readInt();
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element of StorageObjectRemoveMessage.objectUID.");
         }
         else
         {
            return;
         }
      }
   }
}
