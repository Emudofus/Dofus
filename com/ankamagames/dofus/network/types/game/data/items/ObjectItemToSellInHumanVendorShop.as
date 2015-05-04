package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class ObjectItemToSellInHumanVendorShop extends Item implements INetworkType
   {
      
      public function ObjectItemToSellInHumanVendorShop()
      {
         this.effects = new Vector.<ObjectEffect>();
         super();
      }
      
      public static const protocolId:uint = 359;
      
      public var objectGID:uint = 0;
      
      public var effects:Vector.<ObjectEffect>;
      
      public var objectUID:uint = 0;
      
      public var quantity:uint = 0;
      
      public var objectPrice:uint = 0;
      
      public var publicPrice:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 359;
      }
      
      public function initObjectItemToSellInHumanVendorShop(param1:uint = 0, param2:Vector.<ObjectEffect> = null, param3:uint = 0, param4:uint = 0, param5:uint = 0, param6:uint = 0) : ObjectItemToSellInHumanVendorShop
      {
         this.objectGID = param1;
         this.effects = param2;
         this.objectUID = param3;
         this.quantity = param4;
         this.objectPrice = param5;
         this.publicPrice = param6;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectGID = 0;
         this.effects = new Vector.<ObjectEffect>();
         this.objectUID = 0;
         this.quantity = 0;
         this.objectPrice = 0;
         this.publicPrice = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectItemToSellInHumanVendorShop(param1);
      }
      
      public function serializeAs_ObjectItemToSellInHumanVendorShop(param1:ICustomDataOutput) : void
      {
         super.serializeAs_Item(param1);
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element objectGID.");
         }
         else
         {
            param1.writeVarShort(this.objectGID);
            param1.writeShort(this.effects.length);
            var _loc2_:uint = 0;
            while(_loc2_ < this.effects.length)
            {
               param1.writeShort((this.effects[_loc2_] as ObjectEffect).getTypeId());
               (this.effects[_loc2_] as ObjectEffect).serialize(param1);
               _loc2_++;
            }
            if(this.objectUID < 0)
            {
               throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
            }
            else
            {
               param1.writeVarInt(this.objectUID);
               if(this.quantity < 0)
               {
                  throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
               }
               else
               {
                  param1.writeVarInt(this.quantity);
                  if(this.objectPrice < 0)
                  {
                     throw new Error("Forbidden value (" + this.objectPrice + ") on element objectPrice.");
                  }
                  else
                  {
                     param1.writeVarInt(this.objectPrice);
                     if(this.publicPrice < 0)
                     {
                        throw new Error("Forbidden value (" + this.publicPrice + ") on element publicPrice.");
                     }
                     else
                     {
                        param1.writeVarInt(this.publicPrice);
                        return;
                     }
                  }
               }
            }
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectItemToSellInHumanVendorShop(param1);
      }
      
      public function deserializeAs_ObjectItemToSellInHumanVendorShop(param1:ICustomDataInput) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:ObjectEffect = null;
         super.deserialize(param1);
         this.objectGID = param1.readVarUhShort();
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element of ObjectItemToSellInHumanVendorShop.objectGID.");
         }
         else
         {
            var _loc2_:uint = param1.readUnsignedShort();
            var _loc3_:uint = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = param1.readUnsignedShort();
               _loc5_ = ProtocolTypeManager.getInstance(ObjectEffect,_loc4_);
               _loc5_.deserialize(param1);
               this.effects.push(_loc5_);
               _loc3_++;
            }
            this.objectUID = param1.readVarUhInt();
            if(this.objectUID < 0)
            {
               throw new Error("Forbidden value (" + this.objectUID + ") on element of ObjectItemToSellInHumanVendorShop.objectUID.");
            }
            else
            {
               this.quantity = param1.readVarUhInt();
               if(this.quantity < 0)
               {
                  throw new Error("Forbidden value (" + this.quantity + ") on element of ObjectItemToSellInHumanVendorShop.quantity.");
               }
               else
               {
                  this.objectPrice = param1.readVarUhInt();
                  if(this.objectPrice < 0)
                  {
                     throw new Error("Forbidden value (" + this.objectPrice + ") on element of ObjectItemToSellInHumanVendorShop.objectPrice.");
                  }
                  else
                  {
                     this.publicPrice = param1.readVarUhInt();
                     if(this.publicPrice < 0)
                     {
                        throw new Error("Forbidden value (" + this.publicPrice + ") on element of ObjectItemToSellInHumanVendorShop.publicPrice.");
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
}
