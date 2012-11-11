package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightFighterNamedInformations extends GameFightFighterInformations implements INetworkType
    {
        public var name:String = "";
        public static const protocolId:uint = 158;

        public function GameFightFighterNamedInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 158;
        }// end function

        public function initGameFightFighterNamedInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:uint = 2, param5:Boolean = false, param6:GameFightMinimalStats = null, param7:String = "") : GameFightFighterNamedInformations
        {
            super.initGameFightFighterInformations(param1, param2, param3, param4, param5, param6);
            this.name = param7;
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
            this.serializeAs_GameFightFighterNamedInformations(param1);
            return;
        }// end function

        public function serializeAs_GameFightFighterNamedInformations(param1:IDataOutput) : void
        {
            super.serializeAs_GameFightFighterInformations(param1);
            param1.writeUTF(this.name);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightFighterNamedInformations(param1);
            return;
        }// end function

        public function deserializeAs_GameFightFighterNamedInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.name = param1.readUTF();
            return;
        }// end function

    }
}
