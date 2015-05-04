package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class PrismFightRemovedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PrismFightRemovedMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6453;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var subAreaId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6453;
      }
      
      public function initPrismFightRemovedMessage(param1:uint = 0) : PrismFightRemovedMessage
      {
         this.subAreaId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.subAreaId = 0;
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
         this.serializeAs_PrismFightRemovedMessage(param1);
      }
      
      public function serializeAs_PrismFightRemovedMessage(param1:ICustomDataOutput) : void
      {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            param1.writeVarShort(this.subAreaId);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_PrismFightRemovedMessage(param1);
      }
      
      public function deserializeAs_PrismFightRemovedMessage(param1:ICustomDataInput) : void
      {
         this.subAreaId = param1.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismFightRemovedMessage.subAreaId.");
         }
         else
         {
            return;
         }
      }
   }
}
