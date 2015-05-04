package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class PaddockToSellFilterMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PaddockToSellFilterMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6161;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var areaId:int = 0;
      
      public var atLeastNbMount:int = 0;
      
      public var atLeastNbMachine:int = 0;
      
      public var maxPrice:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6161;
      }
      
      public function initPaddockToSellFilterMessage(param1:int = 0, param2:int = 0, param3:int = 0, param4:uint = 0) : PaddockToSellFilterMessage
      {
         this.areaId = param1;
         this.atLeastNbMount = param2;
         this.atLeastNbMachine = param3;
         this.maxPrice = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.areaId = 0;
         this.atLeastNbMount = 0;
         this.atLeastNbMachine = 0;
         this.maxPrice = 0;
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
         this.serializeAs_PaddockToSellFilterMessage(param1);
      }
      
      public function serializeAs_PaddockToSellFilterMessage(param1:ICustomDataOutput) : void
      {
         param1.writeInt(this.areaId);
         param1.writeByte(this.atLeastNbMount);
         param1.writeByte(this.atLeastNbMachine);
         if(this.maxPrice < 0)
         {
            throw new Error("Forbidden value (" + this.maxPrice + ") on element maxPrice.");
         }
         else
         {
            param1.writeVarInt(this.maxPrice);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_PaddockToSellFilterMessage(param1);
      }
      
      public function deserializeAs_PaddockToSellFilterMessage(param1:ICustomDataInput) : void
      {
         this.areaId = param1.readInt();
         this.atLeastNbMount = param1.readByte();
         this.atLeastNbMachine = param1.readByte();
         this.maxPrice = param1.readVarUhInt();
         if(this.maxPrice < 0)
         {
            throw new Error("Forbidden value (" + this.maxPrice + ") on element of PaddockToSellFilterMessage.maxPrice.");
         }
         else
         {
            return;
         }
      }
   }
}
