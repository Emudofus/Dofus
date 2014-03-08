package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeStartOkJobIndexMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeStartOkJobIndexMessage() {
         this.jobs = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 5819;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var jobs:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 5819;
      }
      
      public function initExchangeStartOkJobIndexMessage(jobs:Vector.<uint>=null) : ExchangeStartOkJobIndexMessage {
         this.jobs = jobs;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.jobs = new Vector.<uint>();
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
         this.serializeAs_ExchangeStartOkJobIndexMessage(output);
      }
      
      public function serializeAs_ExchangeStartOkJobIndexMessage(output:IDataOutput) : void {
         output.writeShort(this.jobs.length);
         var _i1:uint = 0;
         while(_i1 < this.jobs.length)
         {
            if(this.jobs[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.jobs[_i1] + ") on element 1 (starting at 1) of jobs.");
            }
            else
            {
               output.writeInt(this.jobs[_i1]);
               _i1++;
               continue;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeStartOkJobIndexMessage(input);
      }
      
      public function deserializeAs_ExchangeStartOkJobIndexMessage(input:IDataInput) : void {
         var _val1:uint = 0;
         var _jobsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _jobsLen)
         {
            _val1 = input.readInt();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of jobs.");
            }
            else
            {
               this.jobs.push(_val1);
               _i1++;
               continue;
            }
         }
      }
   }
}
