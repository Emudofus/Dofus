package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MimicryObjectEraseRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MimicryObjectEraseRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6457;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var hostUID:uint = 0;
      
      public var hostPos:uint = 0;
      
      override public function getMessageId() : uint {
         return 6457;
      }
      
      public function initMimicryObjectEraseRequestMessage(hostUID:uint=0, hostPos:uint=0) : MimicryObjectEraseRequestMessage {
         this.hostUID = hostUID;
         this.hostPos = hostPos;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
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
         this.serializeAs_MimicryObjectEraseRequestMessage(output);
      }
      
      public function serializeAs_MimicryObjectEraseRequestMessage(output:IDataOutput) : void {
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
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MimicryObjectEraseRequestMessage(input);
      }
      
      public function deserializeAs_MimicryObjectEraseRequestMessage(input:IDataInput) : void {
         this.hostUID = input.readInt();
         if(this.hostUID < 0)
         {
            throw new Error("Forbidden value (" + this.hostUID + ") on element of MimicryObjectEraseRequestMessage.hostUID.");
         }
         else
         {
            this.hostPos = input.readUnsignedByte();
            if((this.hostPos < 0) || (this.hostPos > 255))
            {
               throw new Error("Forbidden value (" + this.hostPos + ") on element of MimicryObjectEraseRequestMessage.hostPos.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
