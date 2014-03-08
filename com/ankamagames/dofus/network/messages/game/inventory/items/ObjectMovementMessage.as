package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ObjectMovementMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ObjectMovementMessage() {
         super();
      }
      
      public static const protocolId:uint = 3010;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var objectUID:uint = 0;
      
      public var position:uint = 63;
      
      override public function getMessageId() : uint {
         return 3010;
      }
      
      public function initObjectMovementMessage(objectUID:uint=0, position:uint=63) : ObjectMovementMessage {
         this.objectUID = objectUID;
         this.position = position;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.objectUID = 0;
         this.position = 63;
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
         this.serializeAs_ObjectMovementMessage(output);
      }
      
      public function serializeAs_ObjectMovementMessage(output:IDataOutput) : void {
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
         }
         else
         {
            output.writeInt(this.objectUID);
            output.writeByte(this.position);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectMovementMessage(input);
      }
      
      public function deserializeAs_ObjectMovementMessage(input:IDataInput) : void {
         this.objectUID = input.readInt();
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element of ObjectMovementMessage.objectUID.");
         }
         else
         {
            this.position = input.readUnsignedByte();
            if((this.position < 0) || (this.position > 255))
            {
               throw new Error("Forbidden value (" + this.position + ") on element of ObjectMovementMessage.position.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
