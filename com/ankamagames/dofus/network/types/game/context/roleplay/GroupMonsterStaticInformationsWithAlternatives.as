package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GroupMonsterStaticInformationsWithAlternatives extends GroupMonsterStaticInformations implements INetworkType
    {
        public var alternatives:Vector.<AlternativeMonstersInGroupLightInformations>;
        public static const protocolId:uint = 396;

        public function GroupMonsterStaticInformationsWithAlternatives()
        {
            this.alternatives = new Vector.<AlternativeMonstersInGroupLightInformations>;
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 396;
        }// end function

        public function initGroupMonsterStaticInformationsWithAlternatives(param1:MonsterInGroupLightInformations = null, param2:Vector.<MonsterInGroupInformations> = null, param3:Vector.<AlternativeMonstersInGroupLightInformations> = null) : GroupMonsterStaticInformationsWithAlternatives
        {
            super.initGroupMonsterStaticInformations(param1, param2);
            this.alternatives = param3;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.alternatives = new Vector.<AlternativeMonstersInGroupLightInformations>;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GroupMonsterStaticInformationsWithAlternatives(param1);
            return;
        }// end function

        public function serializeAs_GroupMonsterStaticInformationsWithAlternatives(param1:IDataOutput) : void
        {
            super.serializeAs_GroupMonsterStaticInformations(param1);
            param1.writeShort(this.alternatives.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.alternatives.length)
            {
                
                (this.alternatives[_loc_2] as AlternativeMonstersInGroupLightInformations).serializeAs_AlternativeMonstersInGroupLightInformations(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GroupMonsterStaticInformationsWithAlternatives(param1);
            return;
        }// end function

        public function deserializeAs_GroupMonsterStaticInformationsWithAlternatives(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            super.deserialize(param1);
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new AlternativeMonstersInGroupLightInformations();
                _loc_4.deserialize(param1);
                this.alternatives.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
