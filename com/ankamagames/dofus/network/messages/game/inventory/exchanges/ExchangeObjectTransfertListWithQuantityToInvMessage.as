package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeObjectTransfertListWithQuantityToInvMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeObjectTransfertListWithQuantityToInvMessage()
      {
         this.ids = new Vector.<uint>();
         this.qtys = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6470;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var ids:Vector.<uint>;
      
      public var qtys:Vector.<uint>;
      
      override public function getMessageId() : uint
      {
         return 6470;
      }
      
      public function initExchangeObjectTransfertListWithQuantityToInvMessage(param1:Vector.<uint> = null, param2:Vector.<uint> = null) : ExchangeObjectTransfertListWithQuantityToInvMessage
      {
         this.ids = param1;
         this.qtys = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.ids = new Vector.<uint>();
         this.qtys = new Vector.<uint>();
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
         this.serializeAs_ExchangeObjectTransfertListWithQuantityToInvMessage(param1);
      }
      
      public function serializeAs_ExchangeObjectTransfertListWithQuantityToInvMessage(param1:ICustomDataOutput) : void
      {
         param1.writeShort(this.ids.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.ids.length)
         {
            if(this.ids[_loc2_] < 0)
            {
               throw new Error("Forbidden value (" + this.ids[_loc2_] + ") on element 1 (starting at 1) of ids.");
            }
            else
            {
               param1.writeVarInt(this.ids[_loc2_]);
               _loc2_++;
               continue;
            }
         }
         param1.writeShort(this.qtys.length);
         var _loc3_:uint = 0;
         while(_loc3_ < this.qtys.length)
         {
            if(this.qtys[_loc3_] < 0)
            {
               throw new Error("Forbidden value (" + this.qtys[_loc3_] + ") on element 2 (starting at 1) of qtys.");
            }
            else
            {
               param1.writeVarInt(this.qtys[_loc3_]);
               _loc3_++;
               continue;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeObjectTransfertListWithQuantityToInvMessage(param1);
      }
      
      public function deserializeAs_ExchangeObjectTransfertListWithQuantityToInvMessage(param1:ICustomDataInput) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc6_ = param1.readVarUhInt();
            if(_loc6_ < 0)
            {
               throw new Error("Forbidden value (" + _loc6_ + ") on elements of ids.");
            }
            else
            {
               this.ids.push(_loc6_);
               _loc3_++;
               continue;
            }
         }
         var _loc4_:uint = param1.readUnsignedShort();
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = param1.readVarUhInt();
            if(_loc7_ < 0)
            {
               throw new Error("Forbidden value (" + _loc7_ + ") on elements of qtys.");
            }
            else
            {
               this.qtys.push(_loc7_);
               _loc5_++;
               continue;
            }
         }
      }
   }
}
