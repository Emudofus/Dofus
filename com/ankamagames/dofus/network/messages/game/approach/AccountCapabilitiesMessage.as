package com.ankamagames.dofus.network.messages.game.approach
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AccountCapabilitiesMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AccountCapabilitiesMessage() {
         super();
      }
      
      public static const protocolId:uint = 6216;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var accountId:int = 0;
      
      public var tutorialAvailable:Boolean = false;
      
      public var breedsVisible:uint = 0;
      
      public var breedsAvailable:uint = 0;
      
      public var status:int = -1;
      
      override public function getMessageId() : uint {
         return 6216;
      }
      
      public function initAccountCapabilitiesMessage(accountId:int = 0, tutorialAvailable:Boolean = false, breedsVisible:uint = 0, breedsAvailable:uint = 0, status:int = -1) : AccountCapabilitiesMessage {
         this.accountId = accountId;
         this.tutorialAvailable = tutorialAvailable;
         this.breedsVisible = breedsVisible;
         this.breedsAvailable = breedsAvailable;
         this.status = status;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.accountId = 0;
         this.tutorialAvailable = false;
         this.breedsVisible = 0;
         this.breedsAvailable = 0;
         this.status = -1;
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
         this.serializeAs_AccountCapabilitiesMessage(output);
      }
      
      public function serializeAs_AccountCapabilitiesMessage(output:IDataOutput) : void {
         output.writeInt(this.accountId);
         output.writeBoolean(this.tutorialAvailable);
         if(this.breedsVisible < 0)
         {
            throw new Error("Forbidden value (" + this.breedsVisible + ") on element breedsVisible.");
         }
         else
         {
            output.writeShort(this.breedsVisible);
            if(this.breedsAvailable < 0)
            {
               throw new Error("Forbidden value (" + this.breedsAvailable + ") on element breedsAvailable.");
            }
            else
            {
               output.writeShort(this.breedsAvailable);
               output.writeByte(this.status);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AccountCapabilitiesMessage(input);
      }
      
      public function deserializeAs_AccountCapabilitiesMessage(input:IDataInput) : void {
         this.accountId = input.readInt();
         this.tutorialAvailable = input.readBoolean();
         this.breedsVisible = input.readShort();
         if(this.breedsVisible < 0)
         {
            throw new Error("Forbidden value (" + this.breedsVisible + ") on element of AccountCapabilitiesMessage.breedsVisible.");
         }
         else
         {
            this.breedsAvailable = input.readShort();
            if(this.breedsAvailable < 0)
            {
               throw new Error("Forbidden value (" + this.breedsAvailable + ") on element of AccountCapabilitiesMessage.breedsAvailable.");
            }
            else
            {
               this.status = input.readByte();
               return;
            }
         }
      }
   }
}
