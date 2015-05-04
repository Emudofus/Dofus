package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class SymbioticObjectAssociateRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SymbioticObjectAssociateRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6522;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var symbioteUID:uint = 0;
      
      public var symbiotePos:uint = 0;
      
      public var hostUID:uint = 0;
      
      public var hostPos:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6522;
      }
      
      public function initSymbioticObjectAssociateRequestMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0) : SymbioticObjectAssociateRequestMessage
      {
         this.symbioteUID = param1;
         this.symbiotePos = param2;
         this.hostUID = param3;
         this.hostPos = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.symbioteUID = 0;
         this.symbiotePos = 0;
         this.hostUID = 0;
         this.hostPos = 0;
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
         this.serializeAs_SymbioticObjectAssociateRequestMessage(param1);
      }
      
      public function serializeAs_SymbioticObjectAssociateRequestMessage(param1:ICustomDataOutput) : void
      {
         if(this.symbioteUID < 0)
         {
            throw new Error("Forbidden value (" + this.symbioteUID + ") on element symbioteUID.");
         }
         else
         {
            param1.writeVarInt(this.symbioteUID);
            if(this.symbiotePos < 0 || this.symbiotePos > 255)
            {
               throw new Error("Forbidden value (" + this.symbiotePos + ") on element symbiotePos.");
            }
            else
            {
               param1.writeByte(this.symbiotePos);
               if(this.hostUID < 0)
               {
                  throw new Error("Forbidden value (" + this.hostUID + ") on element hostUID.");
               }
               else
               {
                  param1.writeVarInt(this.hostUID);
                  if(this.hostPos < 0 || this.hostPos > 255)
                  {
                     throw new Error("Forbidden value (" + this.hostPos + ") on element hostPos.");
                  }
                  else
                  {
                     param1.writeByte(this.hostPos);
                     return;
                  }
               }
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_SymbioticObjectAssociateRequestMessage(param1);
      }
      
      public function deserializeAs_SymbioticObjectAssociateRequestMessage(param1:ICustomDataInput) : void
      {
         this.symbioteUID = param1.readVarUhInt();
         if(this.symbioteUID < 0)
         {
            throw new Error("Forbidden value (" + this.symbioteUID + ") on element of SymbioticObjectAssociateRequestMessage.symbioteUID.");
         }
         else
         {
            this.symbiotePos = param1.readUnsignedByte();
            if(this.symbiotePos < 0 || this.symbiotePos > 255)
            {
               throw new Error("Forbidden value (" + this.symbiotePos + ") on element of SymbioticObjectAssociateRequestMessage.symbiotePos.");
            }
            else
            {
               this.hostUID = param1.readVarUhInt();
               if(this.hostUID < 0)
               {
                  throw new Error("Forbidden value (" + this.hostUID + ") on element of SymbioticObjectAssociateRequestMessage.hostUID.");
               }
               else
               {
                  this.hostPos = param1.readUnsignedByte();
                  if(this.hostPos < 0 || this.hostPos > 255)
                  {
                     throw new Error("Forbidden value (" + this.hostPos + ") on element of SymbioticObjectAssociateRequestMessage.hostPos.");
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
