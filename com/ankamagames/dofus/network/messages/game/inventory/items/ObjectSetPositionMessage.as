package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ObjectSetPositionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ObjectSetPositionMessage() {
         super();
      }
      
      public static const protocolId:uint = 3021;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var objectUID:uint = 0;
      
      public var position:uint = 63;
      
      public var quantity:uint = 0;
      
      override public function getMessageId() : uint {
         return 3021;
      }
      
      public function initObjectSetPositionMessage(objectUID:uint = 0, position:uint = 63, quantity:uint = 0) : ObjectSetPositionMessage {
         this.objectUID = objectUID;
         this.position = position;
         this.quantity = quantity;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.objectUID = 0;
         this.position = 63;
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
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: NullPointerException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function serializeAs_ObjectSetPositionMessage(output:IDataOutput) : void {
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
         }
         else
         {
            output.writeInt(this.objectUID);
            output.writeByte(this.position);
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
         this.deserializeAs_ObjectSetPositionMessage(input);
      }
      
      public function deserializeAs_ObjectSetPositionMessage(input:IDataInput) : void {
         this.objectUID = input.readInt();
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element of ObjectSetPositionMessage.objectUID.");
         }
         else
         {
            this.position = input.readUnsignedByte();
            if((this.position < 0) || (this.position > 255))
            {
               throw new Error("Forbidden value (" + this.position + ") on element of ObjectSetPositionMessage.position.");
            }
            else
            {
               this.quantity = input.readInt();
               if(this.quantity < 0)
               {
                  throw new Error("Forbidden value (" + this.quantity + ") on element of ObjectSetPositionMessage.quantity.");
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
