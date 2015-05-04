package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class LockableStateUpdateHouseDoorMessage extends LockableStateUpdateAbstractMessage implements INetworkMessage
   {
      
      public function LockableStateUpdateHouseDoorMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5668;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var houseId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5668;
      }
      
      public function initLockableStateUpdateHouseDoorMessage(param1:Boolean = false, param2:uint = 0) : LockableStateUpdateHouseDoorMessage
      {
         super.initLockableStateUpdateAbstractMessage(param1);
         this.houseId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.houseId = 0;
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
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_LockableStateUpdateHouseDoorMessage(param1);
      }
      
      public function serializeAs_LockableStateUpdateHouseDoorMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_LockableStateUpdateAbstractMessage(param1);
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
         }
         else
         {
            param1.writeVarInt(this.houseId);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_LockableStateUpdateHouseDoorMessage(param1);
      }
      
      public function deserializeAs_LockableStateUpdateHouseDoorMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.houseId = param1.readVarUhInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of LockableStateUpdateHouseDoorMessage.houseId.");
         }
         else
         {
            return;
         }
      }
   }
}
