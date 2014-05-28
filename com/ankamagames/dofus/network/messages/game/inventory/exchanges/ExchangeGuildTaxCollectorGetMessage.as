package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemQuantity;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeGuildTaxCollectorGetMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeGuildTaxCollectorGetMessage() {
         this.objectsInfos = new Vector.<ObjectItemQuantity>();
         super();
      }
      
      public static const protocolId:uint = 5762;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var collectorName:String = "";
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var mapId:int = 0;
      
      public var subAreaId:uint = 0;
      
      public var userName:String = "";
      
      public var experience:Number = 0;
      
      public var objectsInfos:Vector.<ObjectItemQuantity>;
      
      override public function getMessageId() : uint {
         return 5762;
      }
      
      public function initExchangeGuildTaxCollectorGetMessage(collectorName:String = "", worldX:int = 0, worldY:int = 0, mapId:int = 0, subAreaId:uint = 0, userName:String = "", experience:Number = 0, objectsInfos:Vector.<ObjectItemQuantity> = null) : ExchangeGuildTaxCollectorGetMessage {
         this.collectorName = collectorName;
         this.worldX = worldX;
         this.worldY = worldY;
         this.mapId = mapId;
         this.subAreaId = subAreaId;
         this.userName = userName;
         this.experience = experience;
         this.objectsInfos = objectsInfos;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.collectorName = "";
         this.worldX = 0;
         this.worldY = 0;
         this.mapId = 0;
         this.subAreaId = 0;
         this.userName = "";
         this.experience = 0;
         this.objectsInfos = new Vector.<ObjectItemQuantity>();
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
         this.serializeAs_ExchangeGuildTaxCollectorGetMessage(output);
      }
      
      public function serializeAs_ExchangeGuildTaxCollectorGetMessage(output:IDataOutput) : void {
         output.writeUTF(this.collectorName);
         if((this.worldX < -255) || (this.worldX > 255))
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
         }
         else
         {
            output.writeShort(this.worldX);
            if((this.worldY < -255) || (this.worldY > 255))
            {
               throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
            }
            else
            {
               output.writeShort(this.worldY);
               output.writeInt(this.mapId);
               if(this.subAreaId < 0)
               {
                  throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
               }
               else
               {
                  output.writeShort(this.subAreaId);
                  output.writeUTF(this.userName);
                  output.writeDouble(this.experience);
                  output.writeShort(this.objectsInfos.length);
                  _i8 = 0;
                  while(_i8 < this.objectsInfos.length)
                  {
                     (this.objectsInfos[_i8] as ObjectItemQuantity).serializeAs_ObjectItemQuantity(output);
                     _i8++;
                  }
                  return;
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeGuildTaxCollectorGetMessage(input);
      }
      
      public function deserializeAs_ExchangeGuildTaxCollectorGetMessage(input:IDataInput) : void {
         var _item8:ObjectItemQuantity = null;
         this.collectorName = input.readUTF();
         this.worldX = input.readShort();
         if((this.worldX < -255) || (this.worldX > 255))
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of ExchangeGuildTaxCollectorGetMessage.worldX.");
         }
         else
         {
            this.worldY = input.readShort();
            if((this.worldY < -255) || (this.worldY > 255))
            {
               throw new Error("Forbidden value (" + this.worldY + ") on element of ExchangeGuildTaxCollectorGetMessage.worldY.");
            }
            else
            {
               this.mapId = input.readInt();
               this.subAreaId = input.readShort();
               if(this.subAreaId < 0)
               {
                  throw new Error("Forbidden value (" + this.subAreaId + ") on element of ExchangeGuildTaxCollectorGetMessage.subAreaId.");
               }
               else
               {
                  this.userName = input.readUTF();
                  this.experience = input.readDouble();
                  _objectsInfosLen = input.readUnsignedShort();
                  _i8 = 0;
                  while(_i8 < _objectsInfosLen)
                  {
                     _item8 = new ObjectItemQuantity();
                     _item8.deserialize(input);
                     this.objectsInfos.push(_item8);
                     _i8++;
                  }
                  return;
               }
            }
         }
      }
   }
}
