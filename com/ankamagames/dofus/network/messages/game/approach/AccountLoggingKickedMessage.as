package com.ankamagames.dofus.network.messages.game.approach
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AccountLoggingKickedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AccountLoggingKickedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6029;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var days:uint = 0;
      
      public var hours:uint = 0;
      
      public var minutes:uint = 0;
      
      override public function getMessageId() : uint {
         return 6029;
      }
      
      public function initAccountLoggingKickedMessage(days:uint = 0, hours:uint = 0, minutes:uint = 0) : AccountLoggingKickedMessage {
         this.days = days;
         this.hours = hours;
         this.minutes = minutes;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.days = 0;
         this.hours = 0;
         this.minutes = 0;
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
         this.serializeAs_AccountLoggingKickedMessage(output);
      }
      
      public function serializeAs_AccountLoggingKickedMessage(output:IDataOutput) : void {
         if(this.days < 0)
         {
            throw new Error("Forbidden value (" + this.days + ") on element days.");
         }
         else
         {
            output.writeInt(this.days);
            if(this.hours < 0)
            {
               throw new Error("Forbidden value (" + this.hours + ") on element hours.");
            }
            else
            {
               output.writeInt(this.hours);
               if(this.minutes < 0)
               {
                  throw new Error("Forbidden value (" + this.minutes + ") on element minutes.");
               }
               else
               {
                  output.writeInt(this.minutes);
                  return;
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AccountLoggingKickedMessage(input);
      }
      
      public function deserializeAs_AccountLoggingKickedMessage(input:IDataInput) : void {
         this.days = input.readInt();
         if(this.days < 0)
         {
            throw new Error("Forbidden value (" + this.days + ") on element of AccountLoggingKickedMessage.days.");
         }
         else
         {
            this.hours = input.readInt();
            if(this.hours < 0)
            {
               throw new Error("Forbidden value (" + this.hours + ") on element of AccountLoggingKickedMessage.hours.");
            }
            else
            {
               this.minutes = input.readInt();
               if(this.minutes < 0)
               {
                  throw new Error("Forbidden value (" + this.minutes + ") on element of AccountLoggingKickedMessage.minutes.");
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
