package com.ankamagames.dofus.network.messages.common.basic
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class BasicStatMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function BasicStatMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6530;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var statId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6530;
      }
      
      public function initBasicStatMessage(param1:uint = 0) : BasicStatMessage
      {
         this.statId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.statId = 0;
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
         this.serializeAs_BasicStatMessage(param1);
      }
      
      public function serializeAs_BasicStatMessage(param1:ICustomDataOutput) : void
      {
         param1.writeVarShort(this.statId);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_BasicStatMessage(param1);
      }
      
      public function deserializeAs_BasicStatMessage(param1:ICustomDataInput) : void
      {
         this.statId = param1.readVarUhShort();
         if(this.statId < 0)
         {
            throw new Error("Forbidden value (" + this.statId + ") on element of BasicStatMessage.statId.");
         }
         else
         {
            return;
         }
      }
   }
}
