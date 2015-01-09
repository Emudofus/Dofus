package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class FightLoot implements INetworkType 
    {

        public static const protocolId:uint = 41;

        public var objects:Vector.<uint>;
        public var kamas:uint = 0;

        public function FightLoot()
        {
            this.objects = new Vector.<uint>();
            super();
        }

        public function getTypeId():uint
        {
            return (41);
        }

        public function initFightLoot(objects:Vector.<uint>=null, kamas:uint=0):FightLoot
        {
            this.objects = objects;
            this.kamas = kamas;
            return (this);
        }

        public function reset():void
        {
            this.objects = new Vector.<uint>();
            this.kamas = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_FightLoot(output);
        }

        public function serializeAs_FightLoot(output:ICustomDataOutput):void
        {
            output.writeShort(this.objects.length);
            var _i1:uint;
            while (_i1 < this.objects.length)
            {
                if (this.objects[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.objects[_i1]) + ") on element 1 (starting at 1) of objects.")));
                };
                output.writeVarShort(this.objects[_i1]);
                _i1++;
            };
            if (this.kamas < 0)
            {
                throw (new Error((("Forbidden value (" + this.kamas) + ") on element kamas.")));
            };
            output.writeVarInt(this.kamas);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_FightLoot(input);
        }

        public function deserializeAs_FightLoot(input:ICustomDataInput):void
        {
            var _val1:uint;
            var _objectsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _objectsLen)
            {
                _val1 = input.readVarUhShort();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of objects.")));
                };
                this.objects.push(_val1);
                _i1++;
            };
            this.kamas = input.readVarUhInt();
            if (this.kamas < 0)
            {
                throw (new Error((("Forbidden value (" + this.kamas) + ") on element of FightLoot.kamas.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.fight

