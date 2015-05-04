package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class IgnoredDeleteRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function IgnoredDeleteRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5680;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var accountId:uint = 0;
      
      public var session:Boolean = false;
      
      override public function getMessageId() : uint
      {
         return 5680;
      }
      
      public function initIgnoredDeleteRequestMessage(param1:uint = 0, param2:Boolean = false) : IgnoredDeleteRequestMessage
      {
         this.accountId = param1;
         this.session = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.accountId = 0;
         this.session = false;
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
         this.serializeAs_IgnoredDeleteRequestMessage(param1);
      }
      
      public function serializeAs_IgnoredDeleteRequestMessage(param1:ICustomDataOutput) : void
      {
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         else
         {
            param1.writeInt(this.accountId);
            param1.writeBoolean(this.session);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_IgnoredDeleteRequestMessage(param1);
      }
      
      public function deserializeAs_IgnoredDeleteRequestMessage(param1:ICustomDataInput) : void
      {
         this.accountId = param1.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of IgnoredDeleteRequestMessage.accountId.");
         }
         else
         {
            this.session = param1.readBoolean();
            return;
         }
      }
   }
}
