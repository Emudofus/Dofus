package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockInformationsForSell;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PaddockToSellListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PaddockToSellListMessage() {
         this.paddockList = new Vector.<PaddockInformationsForSell>();
         super();
      }
      
      public static const protocolId:uint = 6138;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var pageIndex:uint = 0;
      
      public var totalPage:uint = 0;
      
      public var paddockList:Vector.<PaddockInformationsForSell>;
      
      override public function getMessageId() : uint {
         return 6138;
      }
      
      public function initPaddockToSellListMessage(pageIndex:uint = 0, totalPage:uint = 0, paddockList:Vector.<PaddockInformationsForSell> = null) : PaddockToSellListMessage {
         this.pageIndex = pageIndex;
         this.totalPage = totalPage;
         this.paddockList = paddockList;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.pageIndex = 0;
         this.totalPage = 0;
         this.paddockList = new Vector.<PaddockInformationsForSell>();
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
         this.serializeAs_PaddockToSellListMessage(output);
      }
      
      public function serializeAs_PaddockToSellListMessage(output:IDataOutput) : void {
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
               output.writeShort(this.paddockList.length);
               _i3 = 0;
               while(_i3 < this.paddockList.length)
               {
                  (this.paddockList[_i3] as PaddockInformationsForSell).serializeAs_PaddockInformationsForSell(output);
                  _i3++;
               }
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PaddockToSellListMessage(input);
      }
      
      public function deserializeAs_PaddockToSellListMessage(input:IDataInput) : void {
         var _item3:PaddockInformationsForSell = null;
         this.pageIndex = input.readShort();
         if(this.pageIndex < 0)
         {
            throw new Error("Forbidden value (" + this.pageIndex + ") on element of PaddockToSellListMessage.pageIndex.");
         }
         else
         {
            this.totalPage = input.readShort();
            if(this.totalPage < 0)
            {
               throw new Error("Forbidden value (" + this.totalPage + ") on element of PaddockToSellListMessage.totalPage.");
            }
            else
            {
               _paddockListLen = input.readUnsignedShort();
               _i3 = 0;
               while(_i3 < _paddockListLen)
               {
                  _item3 = new PaddockInformationsForSell();
                  _item3.deserialize(input);
                  this.paddockList.push(_item3);
                  _i3++;
               }
               return;
            }
         }
      }
   }
}
