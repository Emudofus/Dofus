package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ObjectFoundWhileRecoltingMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ObjectFoundWhileRecoltingMessage() {
         super();
      }
      
      public static const protocolId:uint = 6017;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var genericId:uint = 0;
      
      public var quantity:uint = 0;
      
      public var ressourceGenericId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6017;
      }
      
      public function initObjectFoundWhileRecoltingMessage(genericId:uint = 0, quantity:uint = 0, ressourceGenericId:uint = 0) : ObjectFoundWhileRecoltingMessage {
         this.genericId = genericId;
         this.quantity = quantity;
         this.ressourceGenericId = ressourceGenericId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.genericId = 0;
         this.quantity = 0;
         this.ressourceGenericId = 0;
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
         this.serializeAs_ObjectFoundWhileRecoltingMessage(output);
      }
      
      public function serializeAs_ObjectFoundWhileRecoltingMessage(output:IDataOutput) : void {
         if(this.genericId < 0)
         {
            throw new Error("Forbidden value (" + this.genericId + ") on element genericId.");
         }
         else
         {
            output.writeInt(this.genericId);
            if(this.quantity < 0)
            {
               throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
            }
            else
            {
               output.writeInt(this.quantity);
               if(this.ressourceGenericId < 0)
               {
                  throw new Error("Forbidden value (" + this.ressourceGenericId + ") on element ressourceGenericId.");
               }
               else
               {
                  output.writeInt(this.ressourceGenericId);
                  return;
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectFoundWhileRecoltingMessage(input);
      }
      
      public function deserializeAs_ObjectFoundWhileRecoltingMessage(input:IDataInput) : void {
         this.genericId = input.readInt();
         if(this.genericId < 0)
         {
            throw new Error("Forbidden value (" + this.genericId + ") on element of ObjectFoundWhileRecoltingMessage.genericId.");
         }
         else
         {
            this.quantity = input.readInt();
            if(this.quantity < 0)
            {
               throw new Error("Forbidden value (" + this.quantity + ") on element of ObjectFoundWhileRecoltingMessage.quantity.");
            }
            else
            {
               this.ressourceGenericId = input.readInt();
               if(this.ressourceGenericId < 0)
               {
                  throw new Error("Forbidden value (" + this.ressourceGenericId + ") on element of ObjectFoundWhileRecoltingMessage.ressourceGenericId.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }
}
