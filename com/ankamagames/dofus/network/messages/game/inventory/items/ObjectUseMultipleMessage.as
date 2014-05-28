package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ObjectUseMultipleMessage extends ObjectUseMessage implements INetworkMessage
   {
      
      public function ObjectUseMultipleMessage() {
         super();
      }
      
      public static const protocolId:uint = 6234;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var quantity:uint = 0;
      
      override public function getMessageId() : uint {
         return 6234;
      }
      
      public function initObjectUseMultipleMessage(objectUID:uint = 0, quantity:uint = 0) : ObjectUseMultipleMessage {
         super.initObjectUseMessage(objectUID);
         this.quantity = quantity;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.quantity = 0;
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ObjectUseMultipleMessage(output);
      }
      
      public function serializeAs_ObjectUseMultipleMessage(output:IDataOutput) : void {
         super.serializeAs_ObjectUseMessage(output);
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
         }
         else
         {
            output.writeInt(this.quantity);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectUseMultipleMessage(input);
      }
      
      public function deserializeAs_ObjectUseMultipleMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.quantity = input.readInt();
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element of ObjectUseMultipleMessage.quantity.");
         }
         else
         {
            return;
         }
      }
   }
}
