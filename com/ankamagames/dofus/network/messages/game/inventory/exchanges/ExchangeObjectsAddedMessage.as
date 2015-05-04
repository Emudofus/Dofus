package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeObjectsAddedMessage extends ExchangeObjectMessage implements INetworkMessage
   {
      
      public function ExchangeObjectsAddedMessage()
      {
         this.object = new Vector.<ObjectItem>();
         super();
      }
      
      public static const protocolId:uint = 6535;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var object:Vector.<ObjectItem>;
      
      override public function getMessageId() : uint
      {
         return 6535;
      }
      
      public function initExchangeObjectsAddedMessage(param1:Boolean = false, param2:Vector.<ObjectItem> = null) : ExchangeObjectsAddedMessage
      {
         super.initExchangeObjectMessage(param1);
         this.object = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.object = new Vector.<ObjectItem>();
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
         this.serializeAs_ExchangeObjectsAddedMessage(param1);
      }
      
      public function serializeAs_ExchangeObjectsAddedMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_ExchangeObjectMessage(param1);
         param1.writeShort(this.object.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.object.length)
         {
            (this.object[_loc2_] as ObjectItem).serializeAs_ObjectItem(param1);
            _loc2_++;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeObjectsAddedMessage(param1);
      }
      
      public function deserializeAs_ExchangeObjectsAddedMessage(param1:ICustomDataInput) : void
      {
         var _loc4_:ObjectItem = null;
         super.deserialize(param1);
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new ObjectItem();
            _loc4_.deserialize(param1);
            this.object.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
