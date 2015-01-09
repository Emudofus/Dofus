package com.ankamagames.dofus.network.types.game.look
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class EntityLook implements INetworkType 
    {

        public static const protocolId:uint = 55;

        public var bonesId:uint = 0;
        public var skins:Vector.<uint>;
        public var indexedColors:Vector.<int>;
        public var scales:Vector.<int>;
        public var subentities:Vector.<SubEntity>;

        public function EntityLook()
        {
            this.skins = new Vector.<uint>();
            this.indexedColors = new Vector.<int>();
            this.scales = new Vector.<int>();
            this.subentities = new Vector.<SubEntity>();
            super();
        }

        public function getTypeId():uint
        {
            return (55);
        }

        public function initEntityLook(bonesId:uint=0, skins:Vector.<uint>=null, indexedColors:Vector.<int>=null, scales:Vector.<int>=null, subentities:Vector.<SubEntity>=null):EntityLook
        {
            this.bonesId = bonesId;
            this.skins = skins;
            this.indexedColors = indexedColors;
            this.scales = scales;
            this.subentities = subentities;
            return (this);
        }

        public function reset():void
        {
            this.bonesId = 0;
            this.skins = new Vector.<uint>();
            this.indexedColors = new Vector.<int>();
            this.scales = new Vector.<int>();
            this.subentities = new Vector.<SubEntity>();
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_EntityLook(output);
        }

        public function serializeAs_EntityLook(output:ICustomDataOutput):void
        {
            if (this.bonesId < 0)
            {
                throw (new Error((("Forbidden value (" + this.bonesId) + ") on element bonesId.")));
            };
            output.writeVarShort(this.bonesId);
            output.writeShort(this.skins.length);
            var _i2:uint;
            while (_i2 < this.skins.length)
            {
                if (this.skins[_i2] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.skins[_i2]) + ") on element 2 (starting at 1) of skins.")));
                };
                output.writeVarShort(this.skins[_i2]);
                _i2++;
            };
            output.writeShort(this.indexedColors.length);
            var _i3:uint;
            while (_i3 < this.indexedColors.length)
            {
                output.writeInt(this.indexedColors[_i3]);
                _i3++;
            };
            output.writeShort(this.scales.length);
            var _i4:uint;
            while (_i4 < this.scales.length)
            {
                output.writeVarShort(this.scales[_i4]);
                _i4++;
            };
            output.writeShort(this.subentities.length);
            var _i5:uint;
            while (_i5 < this.subentities.length)
            {
                (this.subentities[_i5] as SubEntity).serializeAs_SubEntity(output);
                _i5++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_EntityLook(input);
        }

        public function deserializeAs_EntityLook(input:ICustomDataInput):void
        {
            var _val2:uint;
            var _val3:int;
            var _val4:int;
            var _item5:SubEntity;
            this.bonesId = input.readVarUhShort();
            if (this.bonesId < 0)
            {
                throw (new Error((("Forbidden value (" + this.bonesId) + ") on element of EntityLook.bonesId.")));
            };
            var _skinsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _skinsLen)
            {
                _val2 = input.readVarUhShort();
                if (_val2 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val2) + ") on elements of skins.")));
                };
                this.skins.push(_val2);
                _i2++;
            };
            var _indexedColorsLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _indexedColorsLen)
            {
                _val3 = input.readInt();
                this.indexedColors.push(_val3);
                _i3++;
            };
            var _scalesLen:uint = input.readUnsignedShort();
            var _i4:uint;
            while (_i4 < _scalesLen)
            {
                _val4 = input.readVarShort();
                this.scales.push(_val4);
                _i4++;
            };
            var _subentitiesLen:uint = input.readUnsignedShort();
            var _i5:uint;
            while (_i5 < _subentitiesLen)
            {
                _item5 = new SubEntity();
                _item5.deserialize(input);
                this.subentities.push(_item5);
                _i5++;
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.look

