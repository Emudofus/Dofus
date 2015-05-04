package com.ankamagames.dofus.network.types.game.look
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class EntityLook extends Object implements INetworkType
   {
      
      public function EntityLook()
      {
         this.skins = new Vector.<uint>();
         this.indexedColors = new Vector.<int>();
         this.scales = new Vector.<int>();
         this.subentities = new Vector.<SubEntity>();
         super();
      }
      
      public static const protocolId:uint = 55;
      
      public var bonesId:uint = 0;
      
      public var skins:Vector.<uint>;
      
      public var indexedColors:Vector.<int>;
      
      public var scales:Vector.<int>;
      
      public var subentities:Vector.<SubEntity>;
      
      public function getTypeId() : uint
      {
         return 55;
      }
      
      public function initEntityLook(param1:uint = 0, param2:Vector.<uint> = null, param3:Vector.<int> = null, param4:Vector.<int> = null, param5:Vector.<SubEntity> = null) : EntityLook
      {
         this.bonesId = param1;
         this.skins = param2;
         this.indexedColors = param3;
         this.scales = param4;
         this.subentities = param5;
         return this;
      }
      
      public function reset() : void
      {
         this.bonesId = 0;
         this.skins = new Vector.<uint>();
         this.indexedColors = new Vector.<int>();
         this.scales = new Vector.<int>();
         this.subentities = new Vector.<SubEntity>();
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_EntityLook(param1);
      }
      
      public function serializeAs_EntityLook(param1:ICustomDataOutput) : void
      {
         if(this.bonesId < 0)
         {
            throw new Error("Forbidden value (" + this.bonesId + ") on element bonesId.");
         }
         else
         {
            param1.writeVarShort(this.bonesId);
            param1.writeShort(this.skins.length);
            var _loc2_:uint = 0;
            while(_loc2_ < this.skins.length)
            {
               if(this.skins[_loc2_] < 0)
               {
                  throw new Error("Forbidden value (" + this.skins[_loc2_] + ") on element 2 (starting at 1) of skins.");
               }
               else
               {
                  param1.writeVarShort(this.skins[_loc2_]);
                  _loc2_++;
                  continue;
               }
            }
            param1.writeShort(this.indexedColors.length);
            var _loc3_:uint = 0;
            while(_loc3_ < this.indexedColors.length)
            {
               param1.writeInt(this.indexedColors[_loc3_]);
               _loc3_++;
            }
            param1.writeShort(this.scales.length);
            var _loc4_:uint = 0;
            while(_loc4_ < this.scales.length)
            {
               param1.writeVarShort(this.scales[_loc4_]);
               _loc4_++;
            }
            param1.writeShort(this.subentities.length);
            var _loc5_:uint = 0;
            while(_loc5_ < this.subentities.length)
            {
               (this.subentities[_loc5_] as SubEntity).serializeAs_SubEntity(param1);
               _loc5_++;
            }
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_EntityLook(param1);
      }
      
      public function deserializeAs_EntityLook(param1:ICustomDataInput) : void
      {
         var _loc10_:uint = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:SubEntity = null;
         this.bonesId = param1.readVarUhShort();
         if(this.bonesId < 0)
         {
            throw new Error("Forbidden value (" + this.bonesId + ") on element of EntityLook.bonesId.");
         }
         else
         {
            var _loc2_:uint = param1.readUnsignedShort();
            var _loc3_:uint = 0;
            while(_loc3_ < _loc2_)
            {
               _loc10_ = param1.readVarUhShort();
               if(_loc10_ < 0)
               {
                  throw new Error("Forbidden value (" + _loc10_ + ") on elements of skins.");
               }
               else
               {
                  this.skins.push(_loc10_);
                  _loc3_++;
                  continue;
               }
            }
            var _loc4_:uint = param1.readUnsignedShort();
            var _loc5_:uint = 0;
            while(_loc5_ < _loc4_)
            {
               _loc11_ = param1.readInt();
               this.indexedColors.push(_loc11_);
               _loc5_++;
            }
            var _loc6_:uint = param1.readUnsignedShort();
            var _loc7_:uint = 0;
            while(_loc7_ < _loc6_)
            {
               _loc12_ = param1.readVarShort();
               this.scales.push(_loc12_);
               _loc7_++;
            }
            var _loc8_:uint = param1.readUnsignedShort();
            var _loc9_:uint = 0;
            while(_loc9_ < _loc8_)
            {
               _loc13_ = new SubEntity();
               _loc13_.deserialize(param1);
               this.subentities.push(_loc13_);
               _loc9_++;
            }
            return;
         }
      }
   }
}
