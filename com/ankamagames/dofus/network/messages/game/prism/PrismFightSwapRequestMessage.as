package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class PrismFightSwapRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PrismFightSwapRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5901;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var subAreaId:uint = 0;
      
      public var targetId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5901;
      }
      
      public function initPrismFightSwapRequestMessage(param1:uint = 0, param2:uint = 0) : PrismFightSwapRequestMessage
      {
         this.subAreaId = param1;
         this.targetId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.subAreaId = 0;
         this.targetId = 0;
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
         this.serializeAs_PrismFightSwapRequestMessage(param1);
      }
      
      public function serializeAs_PrismFightSwapRequestMessage(param1:ICustomDataOutput) : void
      {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            param1.writeVarShort(this.subAreaId);
            if(this.targetId < 0)
            {
               throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
            }
            else
            {
               param1.writeVarInt(this.targetId);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_PrismFightSwapRequestMessage(param1);
      }
      
      public function deserializeAs_PrismFightSwapRequestMessage(param1:ICustomDataInput) : void
      {
         this.subAreaId = param1.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismFightSwapRequestMessage.subAreaId.");
         }
         else
         {
            this.targetId = param1.readVarUhInt();
            if(this.targetId < 0)
            {
               throw new Error("Forbidden value (" + this.targetId + ") on element of PrismFightSwapRequestMessage.targetId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
