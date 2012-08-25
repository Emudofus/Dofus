package com.ankamagames.dofus.network.types.game.context
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class EntityMovementInformations extends Object implements INetworkType
    {
        public var id:int = 0;
        public var steps:Vector.<int>;
        public static const protocolId:uint = 63;

        public function EntityMovementInformations()
        {
            this.steps = new Vector.<int>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 63;
        }// end function

        public function initEntityMovementInformations(param1:int = 0, param2:Vector.<int> = null) : EntityMovementInformations
        {
            this.id = param1;
            this.steps = param2;
            return this;
        }// end function

        public function reset() : void
        {
            this.id = 0;
            this.steps = new Vector.<int>;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_EntityMovementInformations(param1);
            return;
        }// end function

        public function serializeAs_EntityMovementInformations(param1:IDataOutput) : void
        {
            param1.writeInt(this.id);
            param1.writeShort(this.steps.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.steps.length)
            {
                
                param1.writeByte(this.steps[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_EntityMovementInformations(param1);
            return;
        }// end function

        public function deserializeAs_EntityMovementInformations(param1:IDataInput) : void
        {
            var _loc_4:int = 0;
            this.id = param1.readInt();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readByte();
                this.steps.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
