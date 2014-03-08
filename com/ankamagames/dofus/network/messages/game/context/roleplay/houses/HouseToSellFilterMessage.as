package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class HouseToSellFilterMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function HouseToSellFilterMessage() {
         super();
      }
      
      public static const protocolId:uint = 6137;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var areaId:int = 0;
      
      public var atLeastNbRoom:uint = 0;
      
      public var atLeastNbChest:uint = 0;
      
      public var skillRequested:uint = 0;
      
      public var maxPrice:uint = 0;
      
      override public function getMessageId() : uint {
         return 6137;
      }
      
      public function initHouseToSellFilterMessage(areaId:int=0, atLeastNbRoom:uint=0, atLeastNbChest:uint=0, skillRequested:uint=0, maxPrice:uint=0) : HouseToSellFilterMessage {
         this.areaId = areaId;
         this.atLeastNbRoom = atLeastNbRoom;
         this.atLeastNbChest = atLeastNbChest;
         this.skillRequested = skillRequested;
         this.maxPrice = maxPrice;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.areaId = 0;
         this.atLeastNbRoom = 0;
         this.atLeastNbChest = 0;
         this.skillRequested = 0;
         this.maxPrice = 0;
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
         this.serializeAs_HouseToSellFilterMessage(output);
      }
      
      public function serializeAs_HouseToSellFilterMessage(output:IDataOutput) : void {
         output.writeInt(this.areaId);
         if(this.atLeastNbRoom < 0)
         {
            throw new Error("Forbidden value (" + this.atLeastNbRoom + ") on element atLeastNbRoom.");
         }
         else
         {
            output.writeByte(this.atLeastNbRoom);
            if(this.atLeastNbChest < 0)
            {
               throw new Error("Forbidden value (" + this.atLeastNbChest + ") on element atLeastNbChest.");
            }
            else
            {
               output.writeByte(this.atLeastNbChest);
               if(this.skillRequested < 0)
               {
                  throw new Error("Forbidden value (" + this.skillRequested + ") on element skillRequested.");
               }
               else
               {
                  output.writeShort(this.skillRequested);
                  if(this.maxPrice < 0)
                  {
                     throw new Error("Forbidden value (" + this.maxPrice + ") on element maxPrice.");
                  }
                  else
                  {
                     output.writeInt(this.maxPrice);
                     return;
                  }
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_HouseToSellFilterMessage(input);
      }
      
      public function deserializeAs_HouseToSellFilterMessage(input:IDataInput) : void {
         this.areaId = input.readInt();
         this.atLeastNbRoom = input.readByte();
         if(this.atLeastNbRoom < 0)
         {
            throw new Error("Forbidden value (" + this.atLeastNbRoom + ") on element of HouseToSellFilterMessage.atLeastNbRoom.");
         }
         else
         {
            this.atLeastNbChest = input.readByte();
            if(this.atLeastNbChest < 0)
            {
               throw new Error("Forbidden value (" + this.atLeastNbChest + ") on element of HouseToSellFilterMessage.atLeastNbChest.");
            }
            else
            {
               this.skillRequested = input.readShort();
               if(this.skillRequested < 0)
               {
                  throw new Error("Forbidden value (" + this.skillRequested + ") on element of HouseToSellFilterMessage.skillRequested.");
               }
               else
               {
                  this.maxPrice = input.readInt();
                  if(this.maxPrice < 0)
                  {
                     throw new Error("Forbidden value (" + this.maxPrice + ") on element of HouseToSellFilterMessage.maxPrice.");
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
}
