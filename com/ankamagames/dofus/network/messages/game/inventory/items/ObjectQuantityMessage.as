package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ObjectQuantityMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ObjectQuantityMessage() {
         super();
      }
      
      public static const protocolId:uint = 3023;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var objectUID:uint = 0;
      
      public var quantity:uint = 0;
      
      override public function getMessageId() : uint {
         return 3023;
      }
      
      public function initObjectQuantityMessage(objectUID:uint=0, quantity:uint=0) : ObjectQuantityMessage {
         this.objectUID = objectUID;
         this.quantity = quantity;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.objectUID = 0;
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
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_ObjectQuantityMessage(output);
      }
      
      public function serializeAs_ObjectQuantityMessage(output:IDataOutput) : void {
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
         }
         else
         {
            output.writeInt(this.objectUID);
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
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectQuantityMessage(input);
      }
      
      public function deserializeAs_ObjectQuantityMessage(input:IDataInput) : void {
         this.objectUID = input.readInt();
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element of ObjectQuantityMessage.objectUID.");
         }
         else
         {
            this.quantity = input.readInt();
            if(this.quantity < 0)
            {
               throw new Error("Forbidden value (" + this.quantity + ") on element of ObjectQuantityMessage.quantity.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
