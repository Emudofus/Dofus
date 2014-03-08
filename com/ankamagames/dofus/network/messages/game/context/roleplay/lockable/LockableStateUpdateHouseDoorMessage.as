package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class LockableStateUpdateHouseDoorMessage extends LockableStateUpdateAbstractMessage implements INetworkMessage
   {
      
      public function LockableStateUpdateHouseDoorMessage() {
         super();
      }
      
      public static const protocolId:uint = 5668;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var houseId:int = 0;
      
      override public function getMessageId() : uint {
         return 5668;
      }
      
      public function initLockableStateUpdateHouseDoorMessage(param1:Boolean=false, param2:int=0) : LockableStateUpdateHouseDoorMessage {
         super.initLockableStateUpdateAbstractMessage(param1);
         this.houseId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.houseId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_LockableStateUpdateHouseDoorMessage(param1);
      }
      
      public function serializeAs_LockableStateUpdateHouseDoorMessage(param1:IDataOutput) : void {
         super.serializeAs_LockableStateUpdateAbstractMessage(param1);
         param1.writeInt(this.houseId);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_LockableStateUpdateHouseDoorMessage(param1);
      }
      
      public function deserializeAs_LockableStateUpdateHouseDoorMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.houseId = param1.readInt();
      }
   }
}
