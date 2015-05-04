package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class SequenceNumberMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SequenceNumberMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6317;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var number:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6317;
      }
      
      public function initSequenceNumberMessage(param1:uint = 0) : SequenceNumberMessage
      {
         this.number = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.number = 0;
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
         this.serializeAs_SequenceNumberMessage(param1);
      }
      
      public function serializeAs_SequenceNumberMessage(param1:ICustomDataOutput) : void
      {
         if(this.number < 0 || this.number > 65535)
         {
            throw new Error("Forbidden value (" + this.number + ") on element number.");
         }
         else
         {
            param1.writeShort(this.number);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_SequenceNumberMessage(param1);
      }
      
      public function deserializeAs_SequenceNumberMessage(param1:ICustomDataInput) : void
      {
         this.number = param1.readUnsignedShort();
         if(this.number < 0 || this.number > 65535)
         {
            throw new Error("Forbidden value (" + this.number + ") on element of SequenceNumberMessage.number.");
         }
         else
         {
            return;
         }
      }
   }
}
