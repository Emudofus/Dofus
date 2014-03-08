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
      
      public function initHouseBuyResultMessage(param1:uint=0, param2:Boolean=false, param3:uint=0) : HouseBuyResultMessage {
         this.houseId = param1;
         this.bought = param2;
         this.realPrice = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.houseId = 0;
         this.bought = false;
         this.realPrice = 0;
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
         this.serializeAs_HouseBuyResultMessage(param1);
      }
      
      public function serializeAs_HouseBuyResultMessage(param1:IDataOutput) : void {
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
         }
         else
         {
            param1.writeInt(this.houseId);
            param1.writeBoolean(this.bought);
            if(this.realPrice < 0)
            {
               throw new Error("Forbidden value (" + this.realPrice + ") on element realPrice.");
            }
            else
            {
               param1.writeInt(this.realPrice);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_HouseBuyResultMessage(param1);
      }
      
      public function deserializeAs_HouseBuyResultMessage(param1:IDataInput) : void {
         this.houseId = param1.readInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of HouseBuyResultMessage.houseId.");
         }
         else
         {
            this.bought = param1.readBoolean();
            this.realPrice = param1.readInt();
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
