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
      
      public function initBasicDateMessage(param1:uint=0, param2:uint=0, param3:uint=0) : BasicDateMessage {
         this.day = param1;
         this.month = param2;
         this.year = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.day = 0;
         this.month = 0;
         this.year = 0;
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
         this.serializeAs_BasicDateMessage(param1);
      }
      
      public function serializeAs_BasicDateMessage(param1:IDataOutput) : void {
         if(this.day < 0)
         {
            throw new Error("Forbidden value (" + this.day + ") on element day.");
         }
         else
         {
            param1.writeByte(this.day);
            if(this.month < 0)
            {
               throw new Error("Forbidden value (" + this.month + ") on element month.");
            }
            else
            {
               param1.writeByte(this.month);
               if(this.year < 0)
               {
                  throw new Error("Forbidden value (" + this.year + ") on element year.");
               }
               else
               {
                  param1.writeShort(this.year);
                  return;
               }
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_BasicDateMessage(param1);
      }
      
      public function deserializeAs_BasicDateMessage(param1:IDataInput) : void {
         this.day = param1.readByte();
         if(this.day < 0)
         {
            throw new Error("Forbidden value (" + this.day + ") on element of BasicDateMessage.day.");
         }
         else
         {
            this.month = param1.readByte();
            if(this.month < 0)
            {
               throw new Error("Forbidden value (" + this.month + ") on element of BasicDateMessage.month.");
            }
            else
            {
               this.year = param1.readShort();
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
