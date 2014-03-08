package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class ObjectItem extends Item implements INetworkType
   {
      
      public function ObjectItem() {
         this.effects = new Vector.<ObjectEffect>();
         super();
      }
      
      public static const protocolId:uint = 37;
      
      public var position:uint = 63;
      
      public var objectGID:uint = 0;
      
      public var effects:Vector.<ObjectEffect>;
      
      public var objectUID:uint = 0;
      
      public var quantity:uint = 0;
      
      override public function getTypeId() : uint {
         return 37;
      }
      
      public function initObjectItem(param1:uint=63, param2:uint=0, param3:Vector.<ObjectEffect>=null, param4:uint=0, param5:uint=0) : ObjectItem {
         this.position = param1;
         this.objectGID = param2;
         this.effects = param3;
         this.objectUID = param4;
         this.quantity = param5;
         return this;
      }
      
      override public function reset() : void {
         this.position = 63;
         this.objectGID = 0;
         this.effects = new Vector.<ObjectEffect>();
         this.objectUID = 0;
         this.quantity = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ObjectItem(param1);
      }
      
      public function serializeAs_ObjectItem(param1:IDataOutput) : void {
         super.serializeAs_Item(param1);
         param1.writeByte(this.position);
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element objectGID.");
         }
         else
         {
            param1.writeShort(this.objectGID);
            param1.writeShort(this.effects.length);
            _loc2_ = 0;
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
               param1.writeInt(this.objectUID);
               if(this.quantity < 0)
               {
                  throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
               }
               else
               {
                  param1.writeInt(this.quantity);
                  return;
               }
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ObjectItem(param1);
      }
      
      public function deserializeAs_ObjectItem(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         var _loc5_:ObjectEffect = null;
         super.deserialize(param1);
         this.position = param1.readUnsignedByte();
         if(this.position < 0 || this.position > 255)
         {
            throw new Error("Forbidden value (" + this.position + ") on element of ObjectItem.position.");
         }
         else
         {
            this.objectGID = param1.readShort();
            if(this.objectGID < 0)
            {
               throw new Error("Forbidden value (" + this.objectGID + ") on element of ObjectItem.objectGID.");
            }
            else
            {
               _loc2_ = param1.readUnsignedShort();
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  _loc4_ = param1.readUnsignedShort();
                  _loc5_ = ProtocolTypeManager.getInstance(ObjectEffect,_loc4_);
                  _loc5_.deserialize(param1);
                  this.effects.push(_loc5_);
                  _loc3_++;
               }
               this.objectUID = param1.readInt();
               if(this.objectUID < 0)
               {
                  throw new Error("Forbidden value (" + this.objectUID + ") on element of ObjectItem.objectUID.");
               }
               else
               {
                  this.quantity = param1.readInt();
                  if(this.quantity < 0)
                  {
                     throw new Error("Forbidden value (" + this.quantity + ") on element of ObjectItem.quantity.");
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
