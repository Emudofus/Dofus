package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeObjectsRemovedMessage extends ExchangeObjectMessage implements INetworkMessage
   {
      
      public function ExchangeObjectsRemovedMessage()
      {
         this.objectUID = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6532;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var objectUID:Vector.<uint>;
      
      override public function getMessageId() : uint
      {
         return 6532;
      }
      
      public function initExchangeObjectsRemovedMessage(param1:Boolean = false, param2:Vector.<uint> = null) : ExchangeObjectsRemovedMessage
      {
         super.initExchangeObjectMessage(param1);
         this.objectUID = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.objectUID = new Vector.<uint>();
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
         this.serializeAs_ExchangeObjectsRemovedMessage(param1);
      }
      
      public function serializeAs_ExchangeObjectsRemovedMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_ExchangeObjectMessage(param1);
         param1.writeShort(this.objectUID.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.objectUID.length)
         {
            if(this.objectUID[_loc2_] < 0)
            {
               throw new Error("Forbidden value (" + this.objectUID[_loc2_] + ") on element 1 (starting at 1) of objectUID.");
            }
            else
            {
               param1.writeVarInt(this.objectUID[_loc2_]);
               _loc2_++;
               continue;
            }
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeObjectsRemovedMessage(param1);
      }
      
      public function deserializeAs_ExchangeObjectsRemovedMessage(param1:ICustomDataInput) : void
      {
         var _loc4_:uint = 0;
         super.deserialize(param1);
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readVarUhInt();
            if(_loc4_ < 0)
            {
               throw new Error("Forbidden value (" + _loc4_ + ") on elements of objectUID.");
            }
            else
            {
               this.objectUID.push(_loc4_);
               _loc3_++;
               continue;
            }
         }
      }
   }
}
