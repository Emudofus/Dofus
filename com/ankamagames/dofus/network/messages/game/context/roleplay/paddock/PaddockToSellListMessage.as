package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockInformationsForSell;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class PaddockToSellListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PaddockToSellListMessage()
      {
         this.paddockList = new Vector.<PaddockInformationsForSell>();
         super();
      }
      
      public static const protocolId:uint = 6138;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var pageIndex:uint = 0;
      
      public var totalPage:uint = 0;
      
      public var paddockList:Vector.<PaddockInformationsForSell>;
      
      override public function getMessageId() : uint
      {
         return 6138;
      }
      
      public function initPaddockToSellListMessage(param1:uint = 0, param2:uint = 0, param3:Vector.<PaddockInformationsForSell> = null) : PaddockToSellListMessage
      {
         this.pageIndex = param1;
         this.totalPage = param2;
         this.paddockList = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.pageIndex = 0;
         this.totalPage = 0;
         this.paddockList = new Vector.<PaddockInformationsForSell>();
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
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_PaddockToSellListMessage(param1);
      }
      
      public function serializeAs_PaddockToSellListMessage(param1:ICustomDataOutput) : void
      {
         if(this.pageIndex < 0)
         {
            throw new Error("Forbidden value (" + this.pageIndex + ") on element pageIndex.");
         }
         else
         {
            param1.writeVarShort(this.pageIndex);
            if(this.totalPage < 0)
            {
               throw new Error("Forbidden value (" + this.totalPage + ") on element totalPage.");
            }
            else
            {
               param1.writeVarShort(this.totalPage);
               param1.writeShort(this.paddockList.length);
               var _loc2_:uint = 0;
               while(_loc2_ < this.paddockList.length)
               {
                  (this.paddockList[_loc2_] as PaddockInformationsForSell).serializeAs_PaddockInformationsForSell(param1);
                  _loc2_++;
               }
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_PaddockToSellListMessage(param1);
      }
      
      public function deserializeAs_PaddockToSellListMessage(param1:ICustomDataInput) : void
      {
         var _loc4_:PaddockInformationsForSell = null;
         this.pageIndex = param1.readVarUhShort();
         if(this.pageIndex < 0)
         {
            throw new Error("Forbidden value (" + this.pageIndex + ") on element of PaddockToSellListMessage.pageIndex.");
         }
         else
         {
            this.totalPage = param1.readVarUhShort();
            if(this.totalPage < 0)
            {
               throw new Error("Forbidden value (" + this.totalPage + ") on element of PaddockToSellListMessage.totalPage.");
            }
            else
            {
               var _loc2_:uint = param1.readUnsignedShort();
               var _loc3_:uint = 0;
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
