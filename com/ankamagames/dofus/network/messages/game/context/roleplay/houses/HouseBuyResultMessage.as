package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class HouseBuyResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function HouseBuyResultMessage() {
         super();
      }
      
      public static const protocolId:uint = 5735;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var houseId:uint = 0;
      
      public var bought:Boolean = false;
      
      public var realPrice:uint = 0;
      
      override public function getMessageId() : uint {
         return 5735;
      }
      
      public function initHouseBuyResultMessage(houseId:uint=0, bought:Boolean=false, realPrice:uint=0) : HouseBuyResultMessage {
         this.houseId = houseId;
         this.bought = bought;
         this.realPrice = realPrice;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.houseId = 0;
         this.bought = false;
         this.realPrice = 0;
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
         this.serializeAs_HouseBuyResultMessage(output);
      }
      
      public function serializeAs_HouseBuyResultMessage(output:IDataOutput) : void {
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
         }
         else
         {
            output.writeInt(this.houseId);
            output.writeBoolean(this.bought);
            if(this.realPrice < 0)
            {
               throw new Error("Forbidden value (" + this.realPrice + ") on element realPrice.");
            }
            else
            {
               output.writeInt(this.realPrice);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_HouseBuyResultMessage(input);
      }
      
      public function deserializeAs_HouseBuyResultMessage(input:IDataInput) : void {
         this.houseId = input.readInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of HouseBuyResultMessage.houseId.");
         }
         else
         {
            this.bought = input.readBoolean();
            this.realPrice = input.readInt();
            if(this.realPrice < 0)
            {
               throw new Error("Forbidden value (" + this.realPrice + ") on element of HouseBuyResultMessage.realPrice.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
