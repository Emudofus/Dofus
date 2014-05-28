package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class BasicDateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function BasicDateMessage() {
         super();
      }
      
      public static const protocolId:uint = 177;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var day:uint = 0;
      
      public var month:uint = 0;
      
      public var year:uint = 0;
      
      override public function getMessageId() : uint {
         return 177;
      }
      
      public function initBasicDateMessage(day:uint = 0, month:uint = 0, year:uint = 0) : BasicDateMessage {
         this.day = day;
         this.month = month;
         this.year = year;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.day = 0;
         this.month = 0;
         this.year = 0;
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
         this.serializeAs_BasicDateMessage(output);
      }
      
      public function serializeAs_BasicDateMessage(output:IDataOutput) : void {
         if(this.day < 0)
         {
            throw new Error("Forbidden value (" + this.day + ") on element day.");
         }
         else
         {
            output.writeByte(this.day);
            if(this.month < 0)
            {
               throw new Error("Forbidden value (" + this.month + ") on element month.");
            }
            else
            {
               output.writeByte(this.month);
               if(this.year < 0)
               {
                  throw new Error("Forbidden value (" + this.year + ") on element year.");
               }
               else
               {
                  output.writeShort(this.year);
                  return;
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_BasicDateMessage(input);
      }
      
      public function deserializeAs_BasicDateMessage(input:IDataInput) : void {
         this.day = input.readByte();
         if(this.day < 0)
         {
            throw new Error("Forbidden value (" + this.day + ") on element of BasicDateMessage.day.");
         }
         else
         {
            this.month = input.readByte();
            if(this.month < 0)
            {
               throw new Error("Forbidden value (" + this.month + ") on element of BasicDateMessage.month.");
            }
            else
            {
               this.year = input.readShort();
               if(this.year < 0)
               {
                  throw new Error("Forbidden value (" + this.year + ") on element of BasicDateMessage.year.");
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
