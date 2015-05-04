package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.DecraftedItemStackInfo;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class DecraftResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function DecraftResultMessage()
      {
         this.results = new Vector.<DecraftedItemStackInfo>();
         super();
      }
      
      public static const protocolId:uint = 6569;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var results:Vector.<DecraftedItemStackInfo>;
      
      override public function getMessageId() : uint
      {
         return 6569;
      }
      
      public function initDecraftResultMessage(param1:Vector.<DecraftedItemStackInfo> = null) : DecraftResultMessage
      {
         this.results = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.results = new Vector.<DecraftedItemStackInfo>();
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
         this.serializeAs_DecraftResultMessage(param1);
      }
      
      public function serializeAs_DecraftResultMessage(param1:ICustomDataOutput) : void
      {
         param1.writeShort(this.results.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.results.length)
         {
            (this.results[_loc2_] as DecraftedItemStackInfo).serializeAs_DecraftedItemStackInfo(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_DecraftResultMessage(param1);
      }
      
      public function deserializeAs_DecraftResultMessage(param1:ICustomDataInput) : void
      {
         var _loc4_:DecraftedItemStackInfo = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new DecraftedItemStackInfo();
            _loc4_.deserialize(param1);
            this.results.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
