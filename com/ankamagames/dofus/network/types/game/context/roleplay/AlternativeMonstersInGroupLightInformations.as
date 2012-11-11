package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AlternativeMonstersInGroupLightInformations extends Object implements INetworkType
    {
        public var playerCount:int = 0;
        public var monsters:Vector.<MonsterInGroupLightInformations>;
        public static const protocolId:uint = 394;

        public function AlternativeMonstersInGroupLightInformations()
        {
            this.monsters = new Vector.<MonsterInGroupLightInformations>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 394;
        }// end function

        public function initAlternativeMonstersInGroupLightInformations(param1:int = 0, param2:Vector.<MonsterInGroupLightInformations> = null) : AlternativeMonstersInGroupLightInformations
        {
            this.playerCount = param1;
            this.monsters = param2;
            return this;
        }// end function

        public function reset() : void
        {
            this.playerCount = 0;
            this.monsters = new Vector.<MonsterInGroupLightInformations>;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_AlternativeMonstersInGroupLightInformations(param1);
            return;
        }// end function

        public function serializeAs_AlternativeMonstersInGroupLightInformations(param1:IDataOutput) : void
        {
            param1.writeInt(this.playerCount);
            param1.writeShort(this.monsters.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.monsters.length)
            {
                
                (this.monsters[_loc_2] as MonsterInGroupLightInformations).serializeAs_MonsterInGroupLightInformations(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AlternativeMonstersInGroupLightInformations(param1);
            return;
        }// end function

        public function deserializeAs_AlternativeMonstersInGroupLightInformations(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            this.playerCount = param1.readInt();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new MonsterInGroupLightInformations();
                _loc_4.deserialize(param1);
                this.monsters.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
