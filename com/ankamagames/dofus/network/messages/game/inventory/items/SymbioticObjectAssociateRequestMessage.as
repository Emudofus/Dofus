package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class SymbioticObjectAssociateRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SymbioticObjectAssociateRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6522;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var symbioteUID:uint = 0;
      
      public var symbiotePos:uint = 0;
      
      public var hostUID:uint = 0;
      
      public var hostPos:uint = 0;
      
      override public function getMessageId() : uint {
         return 6522;
      }
      
      public function initSymbioticObjectAssociateRequestMessage(symbioteUID:uint = 0, symbiotePos:uint = 0, hostUID:uint = 0, hostPos:uint = 0) : SymbioticObjectAssociateRequestMessage {
         this.symbioteUID = symbioteUID;
         this.symbiotePos = symbiotePos;
         this.hostUID = hostUID;
         this.hostPos = hostPos;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.symbioteUID = 0;
         this.symbiotePos = 0;
         this.hostUID = 0;
         this.hostPos = 0;
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
         this.serializeAs_SymbioticObjectAssociateRequestMessage(output);
      }
      
      public function serializeAs_SymbioticObjectAssociateRequestMessage(output:IDataOutput) : void {
         if(this.symbioteUID < 0)
         {
            throw new Error("Forbidden value (" + this.symbioteUID + ") on element symbioteUID.");
         }
         else
         {
            output.writeInt(this.symbioteUID);
            if((this.symbiotePos < 0) || (this.symbiotePos > 255))
            {
               throw new Error("Forbidden value (" + this.symbiotePos + ") on element symbiotePos.");
            }
            else
            {
               output.writeByte(this.symbiotePos);
               if(this.hostUID < 0)
               {
                  throw new Error("Forbidden value (" + this.hostUID + ") on element hostUID.");
               }
               else
               {
                  output.writeInt(this.hostUID);
                  if((this.hostPos < 0) || (this.hostPos > 255))
                  {
                     throw new Error("Forbidden value (" + this.hostPos + ") on element hostPos.");
                  }
                  else
                  {
                     output.writeByte(this.hostPos);
                     return;
                  }
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_SymbioticObjectAssociateRequestMessage(input);
      }
      
      public function deserializeAs_SymbioticObjectAssociateRequestMessage(input:IDataInput) : void {
         this.symbioteUID = input.readInt();
         if(this.symbioteUID < 0)
         {
            throw new Error("Forbidden value (" + this.symbioteUID + ") on element of SymbioticObjectAssociateRequestMessage.symbioteUID.");
         }
         else
         {
            this.symbiotePos = input.readUnsignedByte();
            if((this.symbiotePos < 0) || (this.symbiotePos > 255))
            {
               throw new Error("Forbidden value (" + this.symbiotePos + ") on element of SymbioticObjectAssociateRequestMessage.symbiotePos.");
            }
            else
            {
               this.hostUID = input.readInt();
               if(this.hostUID < 0)
               {
                  throw new Error("Forbidden value (" + this.hostUID + ") on element of SymbioticObjectAssociateRequestMessage.hostUID.");
               }
               else
               {
                  this.hostPos = input.readUnsignedByte();
                  if((this.hostPos < 0) || (this.hostPos > 255))
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
