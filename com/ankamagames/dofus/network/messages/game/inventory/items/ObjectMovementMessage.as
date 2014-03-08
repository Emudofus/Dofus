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
      
      public function initObjectMovementMessage(param1:uint=0, param2:uint=63) : ObjectMovementMessage {
         this.objectUID = param1;
         this.position = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.objectUID = 0;
         this.position = 63;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ObjectMovementMessage(param1);
      }
      
      public function serializeAs_ObjectMovementMessage(param1:IDataOutput) : void {
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
         }
         else
         {
            param1.writeInt(this.objectUID);
            param1.writeByte(this.position);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ObjectMovementMessage(param1);
      }
      
      public function deserializeAs_ObjectMovementMessage(param1:IDataInput) : void {
         this.objectUID = param1.readInt();
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element of ObjectMovementMessage.objectUID.");
         }
         else
         {
            this.position = param1.readUnsignedByte();
            if(this.position < 0 || this.position > 255)
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
