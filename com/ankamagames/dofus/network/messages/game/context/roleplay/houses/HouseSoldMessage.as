package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class HouseSoldMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function HouseSoldMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5737;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var houseId:uint = 0;
      
      public var realPrice:uint = 0;
      
      public var buyerName:String = "";
      
      override public function getMessageId() : uint
      {
         return 5737;
      }
      
      public function initHouseSoldMessage(param1:uint = 0, param2:uint = 0, param3:String = "") : HouseSoldMessage
      {
         this.houseId = param1;
         this.realPrice = param2;
         this.buyerName = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.houseId = 0;
         this.realPrice = 0;
         this.buyerName = "";
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_HouseSoldMessage(param1);
      }
      
      public function serializeAs_HouseSoldMessage(param1:ICustomDataOutput) : void
      {
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
         }
         else
         {
            param1.writeVarInt(this.houseId);
            if(this.realPrice < 0)
            {
               throw new Error("Forbidden value (" + this.realPrice + ") on element realPrice.");
            }
            else
            {
               param1.writeVarInt(this.realPrice);
               param1.writeUTF(this.buyerName);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_HouseSoldMessage(param1);
      }
      
      public function deserializeAs_HouseSoldMessage(param1:ICustomDataInput) : void
      {
         this.houseId = param1.readVarUhInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of HouseSoldMessage.houseId.");
         }
         else
         {
            this.realPrice = param1.readVarUhInt();
            if(this.realPrice < 0)
            {
               throw new Error("Forbidden value (" + this.realPrice + ") on element of HouseSoldMessage.realPrice.");
            }
            else
            {
               this.buyerName = param1.readUTF();
               return;
            }
         }
      }
   }
}
