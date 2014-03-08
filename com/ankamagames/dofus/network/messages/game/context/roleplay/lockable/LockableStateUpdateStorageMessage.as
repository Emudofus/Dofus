package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class LockableStateUpdateStorageMessage extends LockableStateUpdateAbstractMessage implements INetworkMessage
   {
      
      public function LockableStateUpdateStorageMessage() {
         super();
      }
      
      public static const protocolId:uint = 5669;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var mapId:int = 0;
      
      public var elementId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5669;
      }
      
      public function initLockableStateUpdateStorageMessage(locked:Boolean=false, mapId:int=0, elementId:uint=0) : LockableStateUpdateStorageMessage {
         super.initLockableStateUpdateAbstractMessage(locked);
         this.mapId = mapId;
         this.elementId = elementId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.mapId = 0;
         this.elementId = 0;
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_LockableStateUpdateStorageMessage(output);
      }
      
      public function serializeAs_LockableStateUpdateStorageMessage(output:IDataOutput) : void {
         super.serializeAs_LockableStateUpdateAbstractMessage(output);
         output.writeInt(this.mapId);
         if(this.elementId < 0)
         {
            throw new Error("Forbidden value (" + this.elementId + ") on element elementId.");
         }
         else
         {
            output.writeInt(this.elementId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_LockableStateUpdateStorageMessage(input);
      }
      
      public function deserializeAs_LockableStateUpdateStorageMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.mapId = input.readInt();
         this.elementId = input.readInt();
         if(this.elementId < 0)
         {
            throw new Error("Forbidden value (" + this.elementId + ") on element of LockableStateUpdateStorageMessage.elementId.");
         }
         else
         {
            return;
         }
      }
   }
}
