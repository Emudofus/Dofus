package com.ankamagames.dofus.network.types.game.character
{
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CharacterMinimalPlusLookInformations extends CharacterMinimalInformations implements INetworkType
    {
        public var entityLook:EntityLook;
        public static const protocolId:uint = 163;

        public function CharacterMinimalPlusLookInformations()
        {
            this.entityLook = new EntityLook();
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 163;
        }// end function

        public function initCharacterMinimalPlusLookInformations(param1:uint = 0, param2:uint = 0, param3:String = "", param4:EntityLook = null) : CharacterMinimalPlusLookInformations
        {
            super.initCharacterMinimalInformations(param1, param2, param3);
            this.entityLook = param4;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.entityLook = new EntityLook();
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_CharacterMinimalPlusLookInformations(param1);
            return;
        }// end function

        public function serializeAs_CharacterMinimalPlusLookInformations(param1:IDataOutput) : void
        {
            super.serializeAs_CharacterMinimalInformations(param1);
            this.entityLook.serializeAs_EntityLook(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CharacterMinimalPlusLookInformations(param1);
            return;
        }// end function

        public function deserializeAs_CharacterMinimalPlusLookInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.entityLook = new EntityLook();
            this.entityLook.deserialize(param1);
            return;
        }// end function

    }
}
