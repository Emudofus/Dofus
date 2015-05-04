package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class PaddockRemoveItemRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PaddockRemoveItemRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5958;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var cellId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5958;
      }
      
      public function initPaddockRemoveItemRequestMessage(param1:uint = 0) : PaddockRemoveItemRequestMessage
      {
         this.cellId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.cellId = 0;
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
         this.serializeAs_PaddockRemoveItemRequestMessage(param1);
      }
      
      public function serializeAs_PaddockRemoveItemRequestMessage(param1:ICustomDataOutput) : void
      {
         if(this.cellId < 0 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
         }
         else
         {
            param1.writeVarShort(this.cellId);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_PaddockRemoveItemRequestMessage(param1);
      }
      
      public function deserializeAs_PaddockRemoveItemRequestMessage(param1:ICustomDataInput) : void
      {
         this.cellId = param1.readVarUhShort();
         if(this.cellId < 0 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element of PaddockRemoveItemRequestMessage.cellId.");
         }
         else
         {
            return;
         }
      }
   }
}
