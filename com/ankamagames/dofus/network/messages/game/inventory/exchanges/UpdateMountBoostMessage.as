package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.mount.UpdateMountBoost;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class UpdateMountBoostMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function UpdateMountBoostMessage() {
         this.boostToUpdateList = new Vector.<UpdateMountBoost>();
         super();
      }
      
      public static const protocolId:uint = 6179;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var rideId:Number = 0;
      
      public var boostToUpdateList:Vector.<UpdateMountBoost>;
      
      override public function getMessageId() : uint {
         return 6179;
      }
      
      public function initUpdateMountBoostMessage(param1:Number=0, param2:Vector.<UpdateMountBoost>=null) : UpdateMountBoostMessage {
         this.rideId = param1;
         this.boostToUpdateList = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.rideId = 0;
         this.boostToUpdateList = new Vector.<UpdateMountBoost>();
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
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_UpdateMountBoostMessage(param1);
      }
      
      public function serializeAs_UpdateMountBoostMessage(param1:IDataOutput) : void {
         param1.writeDouble(this.rideId);
         param1.writeShort(this.boostToUpdateList.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.boostToUpdateList.length)
         {
            param1.writeShort((this.boostToUpdateList[_loc2_] as UpdateMountBoost).getTypeId());
            (this.boostToUpdateList[_loc2_] as UpdateMountBoost).serialize(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_UpdateMountBoostMessage(param1);
      }
      
      public function deserializeAs_UpdateMountBoostMessage(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         var _loc5_:UpdateMountBoost = null;
         this.rideId = param1.readDouble();
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readUnsignedShort();
            _loc5_ = ProtocolTypeManager.getInstance(UpdateMountBoost,_loc4_);
            _loc5_.deserialize(param1);
            this.boostToUpdateList.push(_loc5_);
            _loc3_++;
         }
      }
   }
}
