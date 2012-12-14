package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.character.restriction.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class HumanInformations extends Object implements INetworkType
    {
        public var restrictions:ActorRestrictionsInformations;
        public var sex:Boolean = false;
        public var options:Vector.<HumanOption>;
        public static const protocolId:uint = 157;

        public function HumanInformations()
        {
            this.restrictions = new ActorRestrictionsInformations();
            this.options = new Vector.<HumanOption>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 157;
        }// end function

        public function initHumanInformations(param1:ActorRestrictionsInformations = null, param2:Boolean = false, param3:Vector.<HumanOption> = null) : HumanInformations
        {
            this.restrictions = param1;
            this.sex = param2;
            this.options = param3;
            return this;
        }// end function

        public function reset() : void
        {
            this.restrictions = new ActorRestrictionsInformations();
            this.options = new Vector.<HumanOption>;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_HumanInformations(param1);
            return;
        }// end function

        public function serializeAs_HumanInformations(param1:IDataOutput) : void
        {
            this.restrictions.serializeAs_ActorRestrictionsInformations(param1);
            param1.writeBoolean(this.sex);
            param1.writeShort(this.options.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.options.length)
            {
                
                param1.writeShort((this.options[_loc_2] as HumanOption).getTypeId());
                (this.options[_loc_2] as HumanOption).serialize(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_HumanInformations(param1);
            return;
        }// end function

        public function deserializeAs_HumanInformations(param1:IDataInput) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            this.restrictions = new ActorRestrictionsInformations();
            this.restrictions.deserialize(param1);
            this.sex = param1.readBoolean();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readUnsignedShort();
                _loc_5 = ProtocolTypeManager.getInstance(HumanOption, _loc_4);
                _loc_5.deserialize(param1);
                this.options.push(_loc_5);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
