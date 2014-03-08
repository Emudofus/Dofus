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
      
      public function initAccountLoggingKickedMessage(param1:uint=0, param2:uint=0, param3:uint=0) : AccountLoggingKickedMessage {
         this.days = param1;
         this.hours = param2;
         this.minutes = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.days = 0;
         this.hours = 0;
         this.minutes = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_AccountLoggingKickedMessage(param1);
      }
      
      public function serializeAs_AccountLoggingKickedMessage(param1:IDataOutput) : void {
         if(this.days < 0)
         {
            throw new Error("Forbidden value (" + this.days + ") on element days.");
         }
         else
         {
            param1.writeInt(this.days);
            if(this.hours < 0)
            {
               throw new Error("Forbidden value (" + this.hours + ") on element hours.");
            }
            else
            {
               param1.writeInt(this.hours);
               if(this.minutes < 0)
               {
                  throw new Error("Forbidden value (" + this.minutes + ") on element minutes.");
               }
               else
               {
                  param1.writeInt(this.minutes);
                  return;
               }
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AccountLoggingKickedMessage(param1);
      }
      
      public function deserializeAs_AccountLoggingKickedMessage(param1:IDataInput) : void {
         this.days = param1.readInt();
         if(this.days < 0)
         {
            throw new Error("Forbidden value (" + this.days + ") on element of AccountLoggingKickedMessage.days.");
         }
         else
         {
            this.hours = param1.readInt();
            if(this.hours < 0)
            {
               throw new Error("Forbidden value (" + this.hours + ") on element of AccountLoggingKickedMessage.hours.");
            }
            else
            {
               this.minutes = param1.readInt();
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
