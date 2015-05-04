package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemGenericQuantity;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeGuildTaxCollectorGetMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeGuildTaxCollectorGetMessage()
      {
         this.objectsInfos = new Vector.<ObjectItemGenericQuantity>();
         super();
      }
      
      public static const protocolId:uint = 5762;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var collectorName:String = "";
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var mapId:int = 0;
      
      public var subAreaId:uint = 0;
      
      public var userName:String = "";
      
      public var experience:Number = 0;
      
      public var objectsInfos:Vector.<ObjectItemGenericQuantity>;
      
      override public function getMessageId() : uint
      {
         return 5762;
      }
      
      public function initExchangeGuildTaxCollectorGetMessage(param1:String = "", param2:int = 0, param3:int = 0, param4:int = 0, param5:uint = 0, param6:String = "", param7:Number = 0, param8:Vector.<ObjectItemGenericQuantity> = null) : ExchangeGuildTaxCollectorGetMessage
      {
         this.collectorName = param1;
         this.worldX = param2;
         this.worldY = param3;
         this.mapId = param4;
         this.subAreaId = param5;
         this.userName = param6;
         this.experience = param7;
         this.objectsInfos = param8;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.collectorName = "";
         this.worldX = 0;
         this.worldY = 0;
         this.mapId = 0;
         this.subAreaId = 0;
         this.userName = "";
         this.experience = 0;
         this.objectsInfos = new Vector.<ObjectItemGenericQuantity>();
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
         this.serializeAs_ExchangeGuildTaxCollectorGetMessage(param1);
      }
      
      public function serializeAs_ExchangeGuildTaxCollectorGetMessage(param1:ICustomDataOutput) : void
      {
         param1.writeUTF(this.collectorName);
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
         }
         else
         {
            param1.writeShort(this.worldX);
            if(this.worldY < -255 || this.worldY > 255)
            {
               throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
            }
            else
            {
               param1.writeShort(this.worldY);
               param1.writeInt(this.mapId);
               if(this.subAreaId < 0)
               {
                  throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
               }
               else
               {
                  param1.writeVarShort(this.subAreaId);
                  param1.writeUTF(this.userName);
                  if(this.experience < -9.007199254740992E15 || this.experience > 9.007199254740992E15)
                  {
                     throw new Error("Forbidden value (" + this.experience + ") on element experience.");
                  }
                  else
                  {
                     param1.writeDouble(this.experience);
                     param1.writeShort(this.objectsInfos.length);
                     var _loc2_:uint = 0;
                     while(_loc2_ < this.objectsInfos.length)
                     {
                        (this.objectsInfos[_loc2_] as ObjectItemGenericQuantity).serializeAs_ObjectItemGenericQuantity(param1);
                        _loc2_++;
                     }
                     return;
                  }
               }
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeGuildTaxCollectorGetMessage(param1);
      }
      
      public function deserializeAs_ExchangeGuildTaxCollectorGetMessage(param1:ICustomDataInput) : void
      {
         var _loc4_:ObjectItemGenericQuantity = null;
         this.collectorName = param1.readUTF();
         this.worldX = param1.readShort();
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of ExchangeGuildTaxCollectorGetMessage.worldX.");
         }
         else
         {
            this.worldY = param1.readShort();
            if(this.worldY < -255 || this.worldY > 255)
            {
               throw new Error("Forbidden value (" + this.worldY + ") on element of ExchangeGuildTaxCollectorGetMessage.worldY.");
            }
            else
            {
               this.mapId = param1.readInt();
               this.subAreaId = param1.readVarUhShort();
               if(this.subAreaId < 0)
               {
                  throw new Error("Forbidden value (" + this.subAreaId + ") on element of ExchangeGuildTaxCollectorGetMessage.subAreaId.");
               }
               else
               {
                  this.userName = param1.readUTF();
                  this.experience = param1.readDouble();
                  if(this.experience < -9.007199254740992E15 || this.experience > 9.007199254740992E15)
                  {
                     throw new Error("Forbidden value (" + this.experience + ") on element of ExchangeGuildTaxCollectorGetMessage.experience.");
                  }
                  else
                  {
                     var _loc2_:uint = param1.readUnsignedShort();
                     var _loc3_:uint = 0;
                     while(_loc3_ < _loc2_)
                     {
                        _loc4_ = new ObjectItemGenericQuantity();
                        _loc4_.deserialize(param1);
                        this.objectsInfos.push(_loc4_);
                        _loc3_++;
                     }
                     return;
                  }
               }
            }
         }
      }
   }
}
