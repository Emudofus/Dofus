package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
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
      
      public function initHouseToSellListMessage(pageIndex:uint = 0, totalPage:uint = 0, houseList:Vector.<HouseInformationsForSell> = null) : HouseToSellListMessage {
         this.pageIndex = pageIndex;
         this.totalPage = totalPage;
         this.houseList = houseList;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.pageIndex = 0;
         this.totalPage = 0;
         this.houseList = new Vector.<HouseInformationsForSell>();
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
         this.serializeAs_HouseToSellListMessage(output);
      }
      
      public function serializeAs_HouseToSellListMessage(output:IDataOutput) : void {
         if(this.pageIndex < 0)
         {
            throw new Error("Forbidden value (" + this.pageIndex + ") on element pageIndex.");
         }
         else
         {
            output.writeShort(this.pageIndex);
            if(this.totalPage < 0)
            {
               throw new Error("Forbidden value (" + this.totalPage + ") on element totalPage.");
            }
            else
            {
               output.writeShort(this.totalPage);
               output.writeShort(this.houseList.length);
               _i3 = 0;
               while(_i3 < this.houseList.length)
               {
                  (this.houseList[_i3] as HouseInformationsForSell).serializeAs_HouseInformationsForSell(output);
                  _i3++;
               }
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_HouseToSellListMessage(input);
      }
      
      public function deserializeAs_HouseToSellListMessage(input:IDataInput) : void {
         var _item3:HouseInformationsForSell = null;
         this.pageIndex = input.readShort();
         if(this.pageIndex < 0)
         {
            throw new Error("Forbidden value (" + this.pageIndex + ") on element of HouseToSellListMessage.pageIndex.");
         }
         else
         {
            this.totalPage = input.readShort();
            if(this.totalPage < 0)
            {
               throw new Error("Forbidden value (" + this.totalPage + ") on element of HouseToSellListMessage.totalPage.");
            }
            else
            {
               _houseListLen = input.readUnsignedShort();
               _i3 = 0;
               while(_i3 < _houseListLen)
               {
                  _item3 = new HouseInformationsForSell();
                  _item3.deserialize(input);
                  this.houseList.push(_item3);
                  _i3++;
               }
               return;
            }
         }
      }
   }
}
