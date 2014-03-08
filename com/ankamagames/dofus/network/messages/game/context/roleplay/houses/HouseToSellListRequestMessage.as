package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class HouseToSellListRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function HouseToSellListRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6139;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var pageIndex:uint = 0;
      
      override public function getMessageId() : uint {
         return 6139;
      }
      
      public function initHouseToSellListRequestMessage(param1:uint=0) : HouseToSellListRequestMessage {
         this.pageIndex = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.pageIndex = 0;
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
         this.serializeAs_HouseToSellListRequestMessage(param1);
      }
      
      public function serializeAs_HouseToSellListRequestMessage(param1:IDataOutput) : void {
         if(this.pageIndex < 0)
         {
            throw new Error("Forbidden value (" + this.pageIndex + ") on element pageIndex.");
         }
         else
         {
            param1.writeShort(this.pageIndex);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_HouseToSellListRequestMessage(param1);
      }
      
      public function deserializeAs_HouseToSellListRequestMessage(param1:IDataInput) : void {
         this.pageIndex = param1.readShort();
         if(this.pageIndex < 0)
         {
            throw new Error("Forbidden value (" + this.pageIndex + ") on element of HouseToSellListRequestMessage.pageIndex.");
         }
         else
         {
            return;
         }
      }
   }
}
