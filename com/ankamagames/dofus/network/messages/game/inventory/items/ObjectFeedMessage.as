package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ObjectFeedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ObjectFeedMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6290;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var objectUID:uint = 0;
      
      public var foodUID:uint = 0;
      
      public var foodQuantity:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6290;
      }
      
      public function initObjectFeedMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0) : ObjectFeedMessage
      {
         this.objectUID = param1;
         this.foodUID = param2;
         this.foodQuantity = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectUID = 0;
         this.foodUID = 0;
         this.foodQuantity = 0;
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
         this.serializeAs_ObjectFeedMessage(param1);
      }
      
      public function serializeAs_ObjectFeedMessage(param1:ICustomDataOutput) : void
      {
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
         }
         else
         {
            param1.writeVarInt(this.objectUID);
            if(this.foodUID < 0)
            {
               throw new Error("Forbidden value (" + this.foodUID + ") on element foodUID.");
            }
            else
            {
               param1.writeVarInt(this.foodUID);
               if(this.foodQuantity < 0)
               {
                  throw new Error("Forbidden value (" + this.foodQuantity + ") on element foodQuantity.");
               }
               else
               {
                  param1.writeVarInt(this.foodQuantity);
                  return;
               }
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectFeedMessage(param1);
      }
      
      public function deserializeAs_ObjectFeedMessage(param1:ICustomDataInput) : void
      {
         this.objectUID = param1.readVarUhInt();
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element of ObjectFeedMessage.objectUID.");
         }
         else
         {
            this.foodUID = param1.readVarUhInt();
            if(this.foodUID < 0)
            {
               throw new Error("Forbidden value (" + this.foodUID + ") on element of ObjectFeedMessage.foodUID.");
            }
            else
            {
               this.foodQuantity = param1.readVarUhInt();
               if(this.foodQuantity < 0)
               {
                  throw new Error("Forbidden value (" + this.foodQuantity + ") on element of ObjectFeedMessage.foodQuantity.");
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
