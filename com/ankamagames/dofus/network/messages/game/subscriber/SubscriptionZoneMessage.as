package com.ankamagames.dofus.network.messages.game.subscriber
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class SubscriptionZoneMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SubscriptionZoneMessage() {
         super();
      }
      
      public static const protocolId:uint = 5573;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var active:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5573;
      }
      
      public function initSubscriptionZoneMessage(active:Boolean=false) : SubscriptionZoneMessage {
         this.active = active;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.active = false;
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_SubscriptionZoneMessage(output);
      }
      
      public function serializeAs_SubscriptionZoneMessage(output:IDataOutput) : void {
         output.writeBoolean(this.active);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_SubscriptionZoneMessage(input);
      }
      
      public function deserializeAs_SubscriptionZoneMessage(input:IDataInput) : void {
         this.active = input.readBoolean();
      }
   }
}
