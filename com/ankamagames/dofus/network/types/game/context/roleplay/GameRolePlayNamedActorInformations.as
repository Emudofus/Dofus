package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlayNamedActorInformations extends GameRolePlayActorInformations implements INetworkType
    {
        public var name:String = "";
        public static const protocolId:uint = 154;

        public function GameRolePlayNamedActorInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 154;
        }// end function

        public function initGameRolePlayNamedActorInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:String = "") : GameRolePlayNamedActorInformations
        {
            super.initGameRolePlayActorInformations(param1, param2, param3);
            this.name = param4;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.name = "";
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameRolePlayNamedActorInformations(param1);
            return;
        }// end function

        public function serializeAs_GameRolePlayNamedActorInformations(param1:IDataOutput) : void
        {
            super.serializeAs_GameRolePlayActorInformations(param1);
            param1.writeUTF(this.name);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameRolePlayNamedActorInformations(param1);
            return;
        }// end function

        public function deserializeAs_GameRolePlayNamedActorInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.name = param1.readUTF();
            return;
        }// end function

    }
}
