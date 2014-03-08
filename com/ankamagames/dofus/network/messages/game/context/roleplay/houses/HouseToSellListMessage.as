package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.house.HouseInformationsForSell;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class HouseToSellListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function HouseToSellListMessage() {
         this.houseList = new Vector.<HouseInformationsForSell>();
         super();
      }
      
      public static const protocolId:uint = 6140;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var pageIndex:uint = 0;
      
      public var totalPage:uint = 0;
      
      public var houseList:Vector.<HouseInformationsForSell>;
      
      override public function getMessageId() : uint {
         return 6140;
      }
      
      public function initHouseToSellListMessage(param1:uint=0, param2:uint=0, param3:Vector.<HouseInformationsForSell>=null) : HouseToSellListMessage {
         this.pageIndex = param1;
         this.totalPage = param2;
         this.houseList = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.pageIndex = 0;
         this.totalPage = 0;
         this.houseList = new Vector.<HouseInformationsForSell>();
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
         this.serializeAs_HouseToSellListMessage(param1);
      }
      
      public function serializeAs_HouseToSellListMessage(param1:IDataOutput) : void {
         if(this.pageIndex < 0)
         {
            throw new Error("Forbidden value (" + this.pageIndex + ") on element pageIndex.");
         }
         else
         {
            param1.writeShort(this.pageIndex);
            if(this.totalPage < 0)
            {
               throw new Error("Forbidden value (" + this.totalPage + ") on element totalPage.");
            }
            else
            {
               param1.writeShort(this.totalPage);
               param1.writeShort(this.houseList.length);
               _loc2_ = 0;
               while(_loc2_ < this.houseList.length)
               {
                  (this.houseList[_loc2_] as HouseInformationsForSell).serializeAs_HouseInformationsForSell(param1);
                  _loc2_++;
               }
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_HouseToSellListMessage(param1);
      }
      
      public function deserializeAs_HouseToSellListMessage(param1:IDataInput) : void {
         var _loc4_:HouseInformationsForSell = null;
         this.pageIndex = param1.readShort();
         if(this.pageIndex < 0)
         {
            throw new Error("Forbidden value (" + this.pageIndex + ") on element of HouseToSellListMessage.pageIndex.");
         }
         else
         {
            this.totalPage = param1.readShort();
            if(this.totalPage < 0)
            {
               throw new Error("Forbidden value (" + this.totalPage + ") on element of HouseToSellListMessage.totalPage.");
            }
            else
            {
               _loc2_ = param1.readUnsignedShort();
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  _loc4_ = new HouseInformationsForSell();
                  _loc4_.deserialize(param1);
                  this.houseList.push(_loc4_);
                  _loc3_++;
               }
               return;
            }
         }
      }
   }
}
