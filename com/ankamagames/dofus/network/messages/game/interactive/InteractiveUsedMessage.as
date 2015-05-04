package com.ankamagames.dofus.network.messages.game.interactive
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class InteractiveUsedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function InteractiveUsedMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5745;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var entityId:uint = 0;
      
      public var elemId:uint = 0;
      
      public var skillId:uint = 0;
      
      public var duration:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5745;
      }
      
      public function initInteractiveUsedMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0) : InteractiveUsedMessage
      {
         this.entityId = param1;
         this.elemId = param2;
         this.skillId = param3;
         this.duration = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.entityId = 0;
         this.elemId = 0;
         this.skillId = 0;
         this.duration = 0;
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
         this.serializeAs_InteractiveUsedMessage(param1);
      }
      
      public function serializeAs_InteractiveUsedMessage(param1:ICustomDataOutput) : void
      {
         if(this.entityId < 0)
         {
            throw new Error("Forbidden value (" + this.entityId + ") on element entityId.");
         }
         else
         {
            param1.writeVarInt(this.entityId);
            if(this.elemId < 0)
            {
               throw new Error("Forbidden value (" + this.elemId + ") on element elemId.");
            }
            else
            {
               param1.writeVarInt(this.elemId);
               if(this.skillId < 0)
               {
                  throw new Error("Forbidden value (" + this.skillId + ") on element skillId.");
               }
               else
               {
                  param1.writeVarShort(this.skillId);
                  if(this.duration < 0)
                  {
                     throw new Error("Forbidden value (" + this.duration + ") on element duration.");
                  }
                  else
                  {
                     param1.writeVarShort(this.duration);
                     return;
                  }
               }
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_InteractiveUsedMessage(param1);
      }
      
      public function deserializeAs_InteractiveUsedMessage(param1:ICustomDataInput) : void
      {
         this.entityId = param1.readVarUhInt();
         if(this.entityId < 0)
         {
            throw new Error("Forbidden value (" + this.entityId + ") on element of InteractiveUsedMessage.entityId.");
         }
         else
         {
            this.elemId = param1.readVarUhInt();
            if(this.elemId < 0)
            {
               throw new Error("Forbidden value (" + this.elemId + ") on element of InteractiveUsedMessage.elemId.");
            }
            else
            {
               this.skillId = param1.readVarUhShort();
               if(this.skillId < 0)
               {
                  throw new Error("Forbidden value (" + this.skillId + ") on element of InteractiveUsedMessage.skillId.");
               }
               else
               {
                  this.duration = param1.readVarUhShort();
                  if(this.duration < 0)
                  {
                     throw new Error("Forbidden value (" + this.duration + ") on element of InteractiveUsedMessage.duration.");
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
}
