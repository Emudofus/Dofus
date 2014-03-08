package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class ObjectItemToSellInHumanVendorShop extends Item implements INetworkType
   {
      
      public function ObjectItemToSellInHumanVendorShop() {
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
      
      override public function getTypeId() : uint {
         return 359;
      }
      
      public function initObjectItemToSellInHumanVendorShop(objectGID:uint=0, effects:Vector.<ObjectEffect>=null, objectUID:uint=0, quantity:uint=0, objectPrice:uint=0, publicPrice:uint=0) : ObjectItemToSellInHumanVendorShop {
         this.objectGID = objectGID;
         this.effects = effects;
         this.objectUID = objectUID;
         this.quantity = quantity;
         this.objectPrice = objectPrice;
         this.publicPrice = publicPrice;
         return this;
      }
      
      override public function reset() : void {
         this.objectGID = 0;
         this.effects = new Vector.<ObjectEffect>();
         this.objectUID = 0;
         this.quantity = 0;
         this.objectPrice = 0;
         this.publicPrice = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ObjectItemToSellInHumanVendorShop(output);
      }
      
      public function serializeAs_ObjectItemToSellInHumanVendorShop(output:IDataOutput) : void {
         super.serializeAs_Item(output);
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element objectGID.");
         }
         else
         {
            output.writeShort(this.objectGID);
            output.writeShort(this.effects.length);
            _i2 = 0;
            while(_i2 < this.effects.length)
            {
               output.writeShort((this.effects[_i2] as ObjectEffect).getTypeId());
               (this.effects[_i2] as ObjectEffect).serialize(output);
               _i2++;
            }
            if(this.objectUID < 0)
            {
               throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
            }
            else
            {
               output.writeInt(this.objectUID);
               if(this.quantity < 0)
               {
                  throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
               }
               else
               {
                  output.writeInt(this.quantity);
                  if(this.objectPrice < 0)
                  {
                     throw new Error("Forbidden value (" + this.objectPrice + ") on element objectPrice.");
                  }
                  else
                  {
                     output.writeInt(this.objectPrice);
                     if(this.publicPrice < 0)
                     {
                        throw new Error("Forbidden value (" + this.publicPrice + ") on element publicPrice.");
                     }
                     else
                     {
                        output.writeInt(this.publicPrice);
                        return;
                     }
                  }
               }
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectItemToSellInHumanVendorShop(input);
      }
      
      public function deserializeAs_ObjectItemToSellInHumanVendorShop(input:IDataInput) : void {
         var _id2:uint = 0;
         var _item2:ObjectEffect = null;
         super.deserialize(input);
         this.objectGID = input.readShort();
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element of ObjectItemToSellInHumanVendorShop.objectGID.");
         }
         else
         {
            _effectsLen = input.readUnsignedShort();
            _i2 = 0;
            while(_i2 < _effectsLen)
            {
               _id2 = input.readUnsignedShort();
               _item2 = ProtocolTypeManager.getInstance(ObjectEffect,_id2);
               _item2.deserialize(input);
               this.effects.push(_item2);
               _i2++;
            }
            this.objectUID = input.readInt();
            if(this.objectUID < 0)
            {
               throw new Error("Forbidden value (" + this.objectUID + ") on element of ObjectItemToSellInHumanVendorShop.objectUID.");
            }
            else
            {
               this.quantity = input.readInt();
               if(this.quantity < 0)
               {
                  throw new Error("Forbidden value (" + this.quantity + ") on element of ObjectItemToSellInHumanVendorShop.quantity.");
               }
               else
               {
                  this.objectPrice = input.readInt();
                  if(this.objectPrice < 0)
                  {
                     throw new Error("Forbidden value (" + this.objectPrice + ") on element of ObjectItemToSellInHumanVendorShop.objectPrice.");
                  }
                  else
                  {
                     this.publicPrice = input.readInt();
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
