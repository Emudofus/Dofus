package com.ankamagames.dofus.network.types.game.context.fight
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FightLoot extends Object implements INetworkType
    {
        public var objects:Vector.<uint>;
        public var kamas:uint = 0;
        public static const protocolId:uint = 41;

        public function FightLoot()
        {
            this.objects = new Vector.<uint>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 41;
        }// end function

        public function initFightLoot(param1:Vector.<uint> = null, param2:uint = 0) : FightLoot
        {
            this.objects = param1;
            this.kamas = param2;
            return this;
        }// end function

        public function reset() : void
        {
            this.objects = new Vector.<uint>;
            this.kamas = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_FightLoot(param1);
            return;
        }// end function

        public function serializeAs_FightLoot(param1:IDataOutput) : void
        {
            param1.writeShort(this.objects.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.objects.length)
            {
                
                if (this.objects[_loc_2] < 0)
                {
                    throw new Error("Forbidden value (" + this.objects[_loc_2] + ") on element 1 (starting at 1) of objects.");
                }
                param1.writeShort(this.objects[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            if (this.kamas < 0)
            {
                throw new Error("Forbidden value (" + this.kamas + ") on element kamas.");
            }
            param1.writeInt(this.kamas);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FightLoot(param1);
            return;
        }// end function

        public function deserializeAs_FightLoot(param1:IDataInput) : void
        {
            var _loc_4:* = 0;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readShort();
                if (_loc_4 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_4 + ") on elements of objects.");
                }
                this.objects.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            this.kamas = param1.readInt();
            if (this.kamas < 0)
            {
                throw new Error("Forbidden value (" + this.kamas + ") on element of FightLoot.kamas.");
            }
            return;
        }// end function

    }
}
