package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
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
      
      public function initPaddockToSellListMessage(param1:uint=0, param2:uint=0, param3:Vector.<PaddockInformationsForSell>=null) : PaddockToSellListMessage {
         this.pageIndex = param1;
         this.totalPage = param2;
         this.paddockList = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.pageIndex = 0;
         this.totalPage = 0;
         this.paddockList = new Vector.<PaddockInformationsForSell>();
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
         this.serializeAs_PaddockToSellListMessage(param1);
      }
      
      public function serializeAs_PaddockToSellListMessage(param1:IDataOutput) : void {
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
               param1.writeShort(this.paddockList.length);
               _loc2_ = 0;
               while(_loc2_ < this.paddockList.length)
               {
                  (this.paddockList[_loc2_] as PaddockInformationsForSell).serializeAs_PaddockInformationsForSell(param1);
                  _loc2_++;
               }
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PaddockToSellListMessage(param1);
      }
      
      public function deserializeAs_PaddockToSellListMessage(param1:IDataInput) : void {
         var _loc4_:PaddockInformationsForSell = null;
         this.pageIndex = param1.readShort();
         if(this.pageIndex < 0)
         {
            throw new Error("Forbidden value (" + this.pageIndex + ") on element of PaddockToSellListMessage.pageIndex.");
         }
         else
         {
            this.totalPage = param1.readShort();
            if(this.totalPage < 0)
            {
               throw new Error("Forbidden value (" + this.totalPage + ") on element of PaddockToSellListMessage.totalPage.");
            }
            else
            {
               _loc2_ = param1.readUnsignedShort();
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  _loc4_ = new PaddockInformationsForSell();
                  _loc4_.deserialize(param1);
                  this.paddockList.push(_loc4_);
                  _loc3_++;
               }
               return;
            }
         }
      }
   }
}
