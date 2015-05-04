package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class LivingObjectMessageMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function LivingObjectMessageMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6065;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var msgId:uint = 0;
      
      public var timeStamp:uint = 0;
      
      public var owner:String = "";
      
      public var objectGenericId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6065;
      }
      
      public function initLivingObjectMessageMessage(param1:uint = 0, param2:uint = 0, param3:String = "", param4:uint = 0) : LivingObjectMessageMessage
      {
         this.msgId = param1;
         this.timeStamp = param2;
         this.owner = param3;
         this.objectGenericId = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.msgId = 0;
         this.timeStamp = 0;
         this.owner = "";
         this.objectGenericId = 0;
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
         this.serializeAs_LivingObjectMessageMessage(param1);
      }
      
      public function serializeAs_LivingObjectMessageMessage(param1:ICustomDataOutput) : void
      {
         if(this.msgId < 0)
         {
            throw new Error("Forbidden value (" + this.msgId + ") on element msgId.");
         }
         else
         {
            param1.writeVarShort(this.msgId);
            if(this.timeStamp < 0)
            {
               throw new Error("Forbidden value (" + this.timeStamp + ") on element timeStamp.");
            }
            else
            {
               param1.writeInt(this.timeStamp);
               param1.writeUTF(this.owner);
               if(this.objectGenericId < 0)
               {
                  throw new Error("Forbidden value (" + this.objectGenericId + ") on element objectGenericId.");
               }
               else
               {
                  param1.writeVarShort(this.objectGenericId);
                  return;
               }
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_LivingObjectMessageMessage(param1);
      }
      
      public function deserializeAs_LivingObjectMessageMessage(param1:ICustomDataInput) : void
      {
         this.msgId = param1.readVarUhShort();
         if(this.msgId < 0)
         {
            throw new Error("Forbidden value (" + this.msgId + ") on element of LivingObjectMessageMessage.msgId.");
         }
         else
         {
            this.timeStamp = param1.readInt();
            if(this.timeStamp < 0)
            {
               throw new Error("Forbidden value (" + this.timeStamp + ") on element of LivingObjectMessageMessage.timeStamp.");
            }
            else
            {
               this.owner = param1.readUTF();
               this.objectGenericId = param1.readVarUhShort();
               if(this.objectGenericId < 0)
               {
                  throw new Error("Forbidden value (" + this.objectGenericId + ") on element of LivingObjectMessageMessage.objectGenericId.");
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
