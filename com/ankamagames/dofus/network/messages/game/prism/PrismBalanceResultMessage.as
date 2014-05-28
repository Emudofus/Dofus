package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class PrismBalanceResultMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function PrismBalanceResultMessage() {
         super();
      }

      public static const protocolId:uint = 5841;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }

      public var totalBalanceValue:uint = 0;

      public var subAreaBalanceValue:uint = 0;

      override public function getMessageId() : uint {
         return 5841;
      }

      public function initPrismBalanceResultMessage(totalBalanceValue:uint=0, subAreaBalanceValue:uint=0) : PrismBalanceResultMessage {
         this.totalBalanceValue=totalBalanceValue;
         this.subAreaBalanceValue=subAreaBalanceValue;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         this.totalBalanceValue=0;
         this.subAreaBalanceValue=0;
         this._isInitialized=false;
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
         this.serializeAs_PrismBalanceResultMessage(output);
      }

      public function serializeAs_PrismBalanceResultMessage(output:IDataOutput) : void {
         if(this.totalBalanceValue<0)
         {
            throw new Error("Forbidden value ("+this.totalBalanceValue+") on element totalBalanceValue.");
         }
         else
         {
            output.writeByte(this.totalBalanceValue);
            if(this.subAreaBalanceValue<0)
            {
               throw new Error("Forbidden value ("+this.subAreaBalanceValue+") on element subAreaBalanceValue.");
            }
            else
            {
               output.writeByte(this.subAreaBalanceValue);
               return;
            }
         }
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismBalanceResultMessage(input);
      }

      public function deserializeAs_PrismBalanceResultMessage(input:IDataInput) : void {
         this.totalBalanceValue=input.readByte();
         if(this.totalBalanceValue<0)
         {
            throw new Error("Forbidden value ("+this.totalBalanceValue+") on element of PrismBalanceResultMessage.totalBalanceValue.");
         }
         else
         {
            this.subAreaBalanceValue=input.readByte();
            if(this.subAreaBalanceValue<0)
            {
               throw new Error("Forbidden value ("+this.subAreaBalanceValue+") on element of PrismBalanceResultMessage.subAreaBalanceValue.");
            }
            else
            {
               return;
            }
         }
      }
   }

}