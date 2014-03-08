package com.ankamagames.dofus.network.messages.game.subscriber
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class SubscriptionLimitationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SubscriptionLimitationMessage() {
         super();
      }
      
      public static const protocolId:uint = 5542;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var reason:uint = 0;
      
      override public function getMessageId() : uint {
         return 5542;
      }
      
      public function initSubscriptionLimitationMessage(reason:uint=0) : SubscriptionLimitationMessage {
         this.reason = reason;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.reason = 0;
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
         this.serializeAs_SubscriptionLimitationMessage(output);
      }
      
      public function serializeAs_SubscriptionLimitationMessage(output:IDataOutput) : void {
         output.writeByte(this.reason);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_SubscriptionLimitationMessage(input);
      }
      
      public function deserializeAs_SubscriptionLimitationMessage(input:IDataInput) : void {
         this.reason = input.readByte();
         if(this.reason < 0)
         {
            throw new Error("Forbidden value (" + this.reason + ") on element of SubscriptionLimitationMessage.reason.");
         }
         else
         {
            return;
         }
      }
   }
}
