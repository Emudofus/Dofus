package com.ankamagames.dofus.network.types.game.look
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class EntityLook extends Object implements INetworkType
   {
      
      public function EntityLook() {
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
      
      public function getTypeId() : uint {
         return 55;
      }
      
      public function initEntityLook(bonesId:uint = 0, skins:Vector.<uint> = null, indexedColors:Vector.<int> = null, scales:Vector.<int> = null, subentities:Vector.<SubEntity> = null) : EntityLook {
         this.bonesId = bonesId;
         this.skins = skins;
         this.indexedColors = indexedColors;
         this.scales = scales;
         this.subentities = subentities;
         return this;
      }
      
      public function reset() : void {
         this.bonesId = 0;
         this.skins = new Vector.<uint>();
         this.indexedColors = new Vector.<int>();
         this.scales = new Vector.<int>();
         this.subentities = new Vector.<SubEntity>();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_EntityLook(output);
      }
      
      public function serializeAs_EntityLook(output:IDataOutput) : void {
         if(this.bonesId < 0)
         {
            throw new Error("Forbidden value (" + this.bonesId + ") on element bonesId.");
         }
         else
         {
            output.writeShort(this.bonesId);
            output.writeShort(this.skins.length);
            _i2 = 0;
            while(_i2 < this.skins.length)
            {
               if(this.skins[_i2] < 0)
               {
                  throw new Error("Forbidden value (" + this.skins[_i2] + ") on element 2 (starting at 1) of skins.");
               }
               else
               {
                  output.writeShort(this.skins[_i2]);
                  _i2++;
                  continue;
               }
            }
            output.writeShort(this.indexedColors.length);
            _i3 = 0;
            while(_i3 < this.indexedColors.length)
            {
               output.writeInt(this.indexedColors[_i3]);
               _i3++;
            }
            output.writeShort(this.scales.length);
            _i4 = 0;
            while(_i4 < this.scales.length)
            {
               output.writeShort(this.scales[_i4]);
               _i4++;
            }
            output.writeShort(this.subentities.length);
            _i5 = 0;
            while(_i5 < this.subentities.length)
            {
               (this.subentities[_i5] as SubEntity).serializeAs_SubEntity(output);
               _i5++;
            }
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_EntityLook(input);
      }
      
      public function deserializeAs_EntityLook(input:IDataInput) : void {
         var _val2:uint = 0;
         var _val3:* = 0;
         var _val4:* = 0;
         var _item5:SubEntity = null;
         this.bonesId = input.readShort();
         if(this.bonesId < 0)
         {
            throw new Error("Forbidden value (" + this.bonesId + ") on element of EntityLook.bonesId.");
         }
         else
         {
            _skinsLen = input.readUnsignedShort();
            _i2 = 0;
            while(_i2 < _skinsLen)
            {
               _val2 = input.readShort();
               if(_val2 < 0)
               {
                  throw new Error("Forbidden value (" + _val2 + ") on elements of skins.");
               }
               else
               {
                  this.skins.push(_val2);
                  _i2++;
                  continue;
               }
            }
            _indexedColorsLen = input.readUnsignedShort();
            _i3 = 0;
            while(_i3 < _indexedColorsLen)
            {
               _val3 = input.readInt();
               this.indexedColors.push(_val3);
               _i3++;
            }
            _scalesLen = input.readUnsignedShort();
            _i4 = 0;
            while(_i4 < _scalesLen)
            {
               _val4 = input.readShort();
               this.scales.push(_val4);
               _i4++;
            }
            _subentitiesLen = input.readUnsignedShort();
            _i5 = 0;
            while(_i5 < _subentitiesLen)
            {
               _item5 = new SubEntity();
               _item5.deserialize(input);
               this.subentities.push(_item5);
               _i5++;
            }
            return;
         }
      }
   }
}
