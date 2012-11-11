package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MonsterInGroupInformations extends MonsterInGroupLightInformations implements INetworkType
    {
        public var look:EntityLook;
        public static const protocolId:uint = 144;

        public function MonsterInGroupInformations()
        {
            this.look = new EntityLook();
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 144;
        }// end function

        public function initMonsterInGroupInformations(param1:int = 0, param2:uint = 0, param3:EntityLook = null) : MonsterInGroupInformations
        {
            super.initMonsterInGroupLightInformations(param1, param2);
            this.look = param3;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.look = new EntityLook();
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_MonsterInGroupInformations(param1);
            return;
        }// end function

        public function serializeAs_MonsterInGroupInformations(param1:IDataOutput) : void
        {
            super.serializeAs_MonsterInGroupLightInformations(param1);
            this.look.serializeAs_EntityLook(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MonsterInGroupInformations(param1);
            return;
        }// end function

        public function deserializeAs_MonsterInGroupInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.look = new EntityLook();
            this.look.deserialize(param1);
            return;
        }// end function

    }
}
