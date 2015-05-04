package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.prism.PrismSubareaEmptyInfo;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class PrismsListUpdateMessage extends PrismsListMessage implements INetworkMessage
   {
      
      public function PrismsListUpdateMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6438;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint
      {
         return 6438;
      }
      
      public function initPrismsListUpdateMessage(param1:Vector.<PrismSubareaEmptyInfo> = null) : PrismsListUpdateMessage
      {
         super.initPrismsListMessage(param1);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
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
         this.serializeAs_PrismsListUpdateMessage(param1);
      }
      
      public function serializeAs_PrismsListUpdateMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_PrismsListMessage(param1);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_PrismsListUpdateMessage(param1);
      }
      
      public function deserializeAs_PrismsListUpdateMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
      }
   }
}
