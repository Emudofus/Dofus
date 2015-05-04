package com.ankamagames.dofus.network.messages.game.subscriber
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class SubscriptionZoneMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SubscriptionZoneMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5573;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var active:Boolean = false;
      
      override public function getMessageId() : uint
      {
         return 5573;
      }
      
      public function initSubscriptionZoneMessage(param1:Boolean = false) : SubscriptionZoneMessage
      {
         this.active = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.active = false;
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
         this.serializeAs_SubscriptionZoneMessage(param1);
      }
      
      public function serializeAs_SubscriptionZoneMessage(param1:ICustomDataOutput) : void
      {
         param1.writeBoolean(this.active);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_SubscriptionZoneMessage(param1);
      }
      
      public function deserializeAs_SubscriptionZoneMessage(param1:ICustomDataInput) : void
      {
         this.active = param1.readBoolean();
      }
   }
}
