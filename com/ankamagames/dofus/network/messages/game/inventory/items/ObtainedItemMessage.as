package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ObtainedItemMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ObtainedItemMessage() {
         super();
      }
      
      public static const protocolId:uint = 6519;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var genericId:uint = 0;
      
      public var baseQuantity:uint = 0;
      
      override public function getMessageId() : uint {
         return 6519;
      }
      
      public function initObtainedItemMessage(genericId:uint = 0, baseQuantity:uint = 0) : ObtainedItemMessage {
         this.genericId = genericId;
         this.baseQuantity = baseQuantity;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.genericId = 0;
         this.baseQuantity = 0;
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
         this.serializeAs_ObtainedItemMessage(output);
      }
      
      public function serializeAs_ObtainedItemMessage(output:IDataOutput) : void {
         if(this.genericId < 0)
         {
            throw new Error("Forbidden value (" + this.genericId + ") on element genericId.");
         }
         else
         {
            output.writeInt(this.genericId);
            if(this.baseQuantity < 0)
            {
               throw new Error("Forbidden value (" + this.baseQuantity + ") on element baseQuantity.");
            }
            else
            {
               output.writeInt(this.baseQuantity);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObtainedItemMessage(input);
      }
      
      public function deserializeAs_ObtainedItemMessage(input:IDataInput) : void {
         this.genericId = input.readInt();
         if(this.genericId < 0)
         {
            throw new Error("Forbidden value (" + this.genericId + ") on element of ObtainedItemMessage.genericId.");
         }
         else
         {
            this.baseQuantity = input.readInt();
            if(this.baseQuantity < 0)
            {
               throw new Error("Forbidden value (" + this.baseQuantity + ") on element of ObtainedItemMessage.baseQuantity.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
