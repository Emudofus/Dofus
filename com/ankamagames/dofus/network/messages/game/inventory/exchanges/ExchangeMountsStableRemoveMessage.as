package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeMountsStableRemoveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeMountsStableRemoveMessage()
      {
         this.mountsId = new Vector.<int>();
         super();
      }
      
      public static const protocolId:uint = 6556;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var mountsId:Vector.<int>;
      
      override public function getMessageId() : uint
      {
         return 6556;
      }
      
      public function initExchangeMountsStableRemoveMessage(param1:Vector.<int> = null) : ExchangeMountsStableRemoveMessage
      {
         this.mountsId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.mountsId = new Vector.<int>();
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
         this.serializeAs_ExchangeMountsStableRemoveMessage(param1);
      }
      
      public function serializeAs_ExchangeMountsStableRemoveMessage(param1:ICustomDataOutput) : void
      {
         param1.writeShort(this.mountsId.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.mountsId.length)
         {
            param1.writeVarInt(this.mountsId[_loc2_]);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeMountsStableRemoveMessage(param1);
      }
      
      public function deserializeAs_ExchangeMountsStableRemoveMessage(param1:ICustomDataInput) : void
      {
         var _loc4_:* = 0;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readVarInt();
            this.mountsId.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
