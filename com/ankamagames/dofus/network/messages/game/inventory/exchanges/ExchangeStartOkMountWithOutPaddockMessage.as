package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.mount.MountClientData;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeStartOkMountWithOutPaddockMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeStartOkMountWithOutPaddockMessage() {
         this.stabledMountsDescription = new Vector.<MountClientData>();
         super();
      }
      
      public static const protocolId:uint = 5991;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var stabledMountsDescription:Vector.<MountClientData>;
      
      override public function getMessageId() : uint {
         return 5991;
      }
      
      public function initExchangeStartOkMountWithOutPaddockMessage(param1:Vector.<MountClientData>=null) : ExchangeStartOkMountWithOutPaddockMessage {
         this.stabledMountsDescription = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.stabledMountsDescription = new Vector.<MountClientData>();
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
         this.serializeAs_ExchangeStartOkMountWithOutPaddockMessage(param1);
      }
      
      public function serializeAs_ExchangeStartOkMountWithOutPaddockMessage(param1:IDataOutput) : void {
         param1.writeShort(this.stabledMountsDescription.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.stabledMountsDescription.length)
         {
            (this.stabledMountsDescription[_loc2_] as MountClientData).serializeAs_MountClientData(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeStartOkMountWithOutPaddockMessage(param1);
      }
      
      public function deserializeAs_ExchangeStartOkMountWithOutPaddockMessage(param1:IDataInput) : void {
         var _loc4_:MountClientData = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new MountClientData();
            _loc4_.deserialize(param1);
            this.stabledMountsDescription.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
