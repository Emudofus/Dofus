package com.ankamagames.dofus.network.types.game.look
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class EntityLook extends Object implements INetworkType
    {
        public var bonesId:uint = 0;
        public var skins:Vector.<uint>;
        public var indexedColors:Vector.<int>;
        public var scales:Vector.<int>;
        public var subentities:Vector.<SubEntity>;
        public static const protocolId:uint = 55;

        public function EntityLook()
        {
            this.skins = new Vector.<uint>;
            this.indexedColors = new Vector.<int>;
            this.scales = new Vector.<int>;
            this.subentities = new Vector.<SubEntity>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 55;
        }// end function

        public function initEntityLook(param1:uint = 0, param2:Vector.<uint> = null, param3:Vector.<int> = null, param4:Vector.<int> = null, param5:Vector.<SubEntity> = null) : EntityLook
        {
            this.bonesId = param1;
            this.skins = param2;
            this.indexedColors = param3;
            this.scales = param4;
            this.subentities = param5;
            return this;
        }// end function

        public function reset() : void
        {
            this.bonesId = 0;
            this.skins = new Vector.<uint>;
            this.indexedColors = new Vector.<int>;
            this.scales = new Vector.<int>;
            this.subentities = new Vector.<SubEntity>;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_EntityLook(param1);
            return;
        }// end function

        public function serializeAs_EntityLook(param1:IDataOutput) : void
        {
            if (this.bonesId < 0)
            {
                throw new Error("Forbidden value (" + this.bonesId + ") on element bonesId.");
            }
            param1.writeShort(this.bonesId);
            param1.writeShort(this.skins.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.skins.length)
            {
                
                if (this.skins[_loc_2] < 0)
                {
                    throw new Error("Forbidden value (" + this.skins[_loc_2] + ") on element 2 (starting at 1) of skins.");
                }
                param1.writeShort(this.skins[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.indexedColors.length);
            var _loc_3:* = 0;
            while (_loc_3 < this.indexedColors.length)
            {
                
                param1.writeInt(this.indexedColors[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            param1.writeShort(this.scales.length);
            var _loc_4:* = 0;
            while (_loc_4 < this.scales.length)
            {
                
                param1.writeShort(this.scales[_loc_4]);
                _loc_4 = _loc_4 + 1;
            }
            param1.writeShort(this.subentities.length);
            var _loc_5:* = 0;
            while (_loc_5 < this.subentities.length)
            {
                
                (this.subentities[_loc_5] as SubEntity).serializeAs_SubEntity(param1);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_EntityLook(param1);
            return;
        }// end function

        public function deserializeAs_EntityLook(param1:IDataInput) : void
        {
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            this.bonesId = param1.readShort();
            if (this.bonesId < 0)
            {
                throw new Error("Forbidden value (" + this.bonesId + ") on element of EntityLook.bonesId.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_10 = param1.readShort();
                if (_loc_10 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_10 + ") on elements of skins.");
                }
                this.skins.push(_loc_10);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_11 = param1.readInt();
                this.indexedColors.push(_loc_11);
                _loc_5 = _loc_5 + 1;
            }
            var _loc_6:* = param1.readUnsignedShort();
            var _loc_7:* = 0;
            while (_loc_7 < _loc_6)
            {
                
                _loc_12 = param1.readShort();
                this.scales.push(_loc_12);
                _loc_7 = _loc_7 + 1;
            }
            var _loc_8:* = param1.readUnsignedShort();
            var _loc_9:* = 0;
            while (_loc_9 < _loc_8)
            {
                
                _loc_13 = new SubEntity();
                _loc_13.deserialize(param1);
                this.subentities.push(_loc_13);
                _loc_9 = _loc_9 + 1;
            }
            return;
        }// end function

    }
}
