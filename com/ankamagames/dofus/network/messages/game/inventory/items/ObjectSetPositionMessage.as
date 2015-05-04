package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ObjectSetPositionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ObjectSetPositionMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 3021;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var objectUID:uint = 0;
      
      public var position:uint = 63;
      
      public var quantity:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 3021;
      }
      
      public function initObjectSetPositionMessage(param1:uint = 0, param2:uint = 63, param3:uint = 0) : ObjectSetPositionMessage
      {
         this.objectUID = param1;
         this.position = param2;
         this.quantity = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectUID = 0;
         this.position = 63;
         this.quantity = 0;
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
         this.serializeAs_ObjectSetPositionMessage(param1);
      }
      
      public function serializeAs_ObjectSetPositionMessage(param1:ICustomDataOutput) : void
      {
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
         }
         else
         {
            param1.writeVarInt(this.objectUID);
            param1.writeByte(this.position);
            if(this.quantity < 0)
            {
               throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
            }
            else
            {
               param1.writeVarInt(this.quantity);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectSetPositionMessage(param1);
      }
      
      public function deserializeAs_ObjectSetPositionMessage(param1:ICustomDataInput) : void
      {
         this.objectUID = param1.readVarUhInt();
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element of ObjectSetPositionMessage.objectUID.");
         }
         else
         {
            this.position = param1.readUnsignedByte();
            if(this.position < 0 || this.position > 255)
            {
               throw new Error("Forbidden value (" + this.position + ") on element of ObjectSetPositionMessage.position.");
            }
            else
            {
               this.quantity = param1.readVarUhInt();
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
