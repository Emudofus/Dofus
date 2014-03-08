package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class HouseSoldMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function HouseSoldMessage() {
         super();
      }
      
      public static const protocolId:uint = 5737;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var houseId:uint = 0;
      
      public var realPrice:uint = 0;
      
      public var buyerName:String = "";
      
      override public function getMessageId() : uint {
         return 5737;
      }
      
      public function initHouseSoldMessage(houseId:uint=0, realPrice:uint=0, buyerName:String="") : HouseSoldMessage {
         this.houseId = houseId;
         this.realPrice = realPrice;
         this.buyerName = buyerName;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.houseId = 0;
         this.realPrice = 0;
         this.buyerName = "";
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
         this.serializeAs_HouseSoldMessage(output);
      }
      
      public function serializeAs_HouseSoldMessage(output:IDataOutput) : void {
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
         }
         else
         {
            output.writeInt(this.houseId);
            if(this.realPrice < 0)
            {
               throw new Error("Forbidden value (" + this.realPrice + ") on element realPrice.");
            }
            else
            {
               output.writeInt(this.realPrice);
               output.writeUTF(this.buyerName);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_HouseSoldMessage(input);
      }
      
      public function deserializeAs_HouseSoldMessage(input:IDataInput) : void {
         this.houseId = input.readInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of HouseSoldMessage.houseId.");
         }
         else
         {
            this.realPrice = input.readInt();
            if(this.realPrice < 0)
            {
               throw new Error("Forbidden value (" + this.realPrice + ") on element of HouseSoldMessage.realPrice.");
            }
            else
            {
               this.buyerName = input.readUTF();
               return;
            }
         }
      }
   }
}
