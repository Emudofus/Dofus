package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GroupMonsterStaticInformations extends Object implements INetworkType
    {
        public var mainCreatureLightInfos:MonsterInGroupLightInformations;
        public var underlings:Vector.<MonsterInGroupInformations>;
        public static const protocolId:uint = 140;

        public function GroupMonsterStaticInformations()
        {
            this.mainCreatureLightInfos = new MonsterInGroupLightInformations();
            this.underlings = new Vector.<MonsterInGroupInformations>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 140;
        }// end function

        public function initGroupMonsterStaticInformations(param1:MonsterInGroupLightInformations = null, param2:Vector.<MonsterInGroupInformations> = null) : GroupMonsterStaticInformations
        {
            this.mainCreatureLightInfos = param1;
            this.underlings = param2;
            return this;
        }// end function

        public function reset() : void
        {
            this.mainCreatureLightInfos = new MonsterInGroupLightInformations();
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GroupMonsterStaticInformations(param1);
            return;
        }// end function

        public function serializeAs_GroupMonsterStaticInformations(param1:IDataOutput) : void
        {
            this.mainCreatureLightInfos.serializeAs_MonsterInGroupLightInformations(param1);
            param1.writeShort(this.underlings.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.underlings.length)
            {
                
                (this.underlings[_loc_2] as MonsterInGroupInformations).serializeAs_MonsterInGroupInformations(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GroupMonsterStaticInformations(param1);
            return;
        }// end function

        public function deserializeAs_GroupMonsterStaticInformations(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            this.mainCreatureLightInfos = new MonsterInGroupLightInformations();
            this.mainCreatureLightInfos.deserialize(param1);
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new MonsterInGroupInformations();
                _loc_4.deserialize(param1);
                this.underlings.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
