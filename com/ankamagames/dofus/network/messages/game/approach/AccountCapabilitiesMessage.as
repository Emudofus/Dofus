package com.ankamagames.dofus.network.messages.game.approach
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AccountCapabilitiesMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AccountCapabilitiesMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6216;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var accountId:uint = 0;
      
      public var tutorialAvailable:Boolean = false;
      
      public var breedsVisible:uint = 0;
      
      public var breedsAvailable:uint = 0;
      
      public var status:int = -1;
      
      override public function getMessageId() : uint
      {
         return 6216;
      }
      
      public function initAccountCapabilitiesMessage(param1:uint = 0, param2:Boolean = false, param3:uint = 0, param4:uint = 0, param5:int = -1) : AccountCapabilitiesMessage
      {
         this.accountId = param1;
         this.tutorialAvailable = param2;
         this.breedsVisible = param3;
         this.breedsAvailable = param4;
         this.status = param5;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.accountId = 0;
         this.tutorialAvailable = false;
         this.breedsVisible = 0;
         this.breedsAvailable = 0;
         this.status = -1;
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
         this.serializeAs_AccountCapabilitiesMessage(param1);
      }
      
      public function serializeAs_AccountCapabilitiesMessage(param1:ICustomDataOutput) : void
      {
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         else
         {
            param1.writeInt(this.accountId);
            param1.writeBoolean(this.tutorialAvailable);
            if(this.breedsVisible < 0 || this.breedsVisible > 65535)
            {
               throw new Error("Forbidden value (" + this.breedsVisible + ") on element breedsVisible.");
            }
            else
            {
               param1.writeShort(this.breedsVisible);
               if(this.breedsAvailable < 0 || this.breedsAvailable > 65535)
               {
                  throw new Error("Forbidden value (" + this.breedsAvailable + ") on element breedsAvailable.");
               }
               else
               {
                  param1.writeShort(this.breedsAvailable);
                  param1.writeByte(this.status);
                  return;
               }
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AccountCapabilitiesMessage(param1);
      }
      
      public function deserializeAs_AccountCapabilitiesMessage(param1:ICustomDataInput) : void
      {
         this.accountId = param1.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of AccountCapabilitiesMessage.accountId.");
         }
         else
         {
            this.tutorialAvailable = param1.readBoolean();
            this.breedsVisible = param1.readUnsignedShort();
            if(this.breedsVisible < 0 || this.breedsVisible > 65535)
            {
               throw new Error("Forbidden value (" + this.breedsVisible + ") on element of AccountCapabilitiesMessage.breedsVisible.");
            }
            else
            {
               this.breedsAvailable = param1.readUnsignedShort();
               if(this.breedsAvailable < 0 || this.breedsAvailable > 65535)
               {
                  throw new Error("Forbidden value (" + this.breedsAvailable + ") on element of AccountCapabilitiesMessage.breedsAvailable.");
               }
               else
               {
                  this.status = param1.readByte();
                  return;
               }
            }
         }
      }
   }
}
