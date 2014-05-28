package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
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
      
      public function initUpdateMountBoostMessage(rideId:Number = 0, boostToUpdateList:Vector.<UpdateMountBoost> = null) : UpdateMountBoostMessage {
         this.rideId = rideId;
         this.boostToUpdateList = boostToUpdateList;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.rideId = 0;
         this.boostToUpdateList = new Vector.<UpdateMountBoost>();
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
         this.serializeAs_UpdateMountBoostMessage(output);
      }
      
      public function serializeAs_UpdateMountBoostMessage(output:IDataOutput) : void {
         output.writeDouble(this.rideId);
         output.writeShort(this.boostToUpdateList.length);
         var _i2:uint = 0;
         while(_i2 < this.boostToUpdateList.length)
         {
            output.writeShort((this.boostToUpdateList[_i2] as UpdateMountBoost).getTypeId());
            (this.boostToUpdateList[_i2] as UpdateMountBoost).serialize(output);
            _i2++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_UpdateMountBoostMessage(input);
      }
      
      public function deserializeAs_UpdateMountBoostMessage(input:IDataInput) : void {
         var _id2:uint = 0;
         var _item2:UpdateMountBoost = null;
         this.rideId = input.readDouble();
         var _boostToUpdateListLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2 < _boostToUpdateListLen)
         {
            _id2 = input.readUnsignedShort();
            _item2 = ProtocolTypeManager.getInstance(UpdateMountBoost,_id2);
            _item2.deserialize(input);
            this.boostToUpdateList.push(_item2);
            _i2++;
         }
      }
   }
}
