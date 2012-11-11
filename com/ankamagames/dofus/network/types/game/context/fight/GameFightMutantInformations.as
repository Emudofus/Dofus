package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightMutantInformations extends GameFightFighterNamedInformations implements INetworkType
    {
        public var powerLevel:uint = 0;
        public static const protocolId:uint = 50;

        public function GameFightMutantInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 50;
        }// end function

        public function initGameFightMutantInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:uint = 2, param5:Boolean = false, param6:GameFightMinimalStats = null, param7:String = "", param8:uint = 0) : GameFightMutantInformations
        {
            super.initGameFightFighterNamedInformations(param1, param2, param3, param4, param5, param6, param7);
            this.powerLevel = param8;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.powerLevel = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameFightMutantInformations(param1);
            return;
        }// end function

        public function serializeAs_GameFightMutantInformations(param1:IDataOutput) : void
        {
            super.serializeAs_GameFightFighterNamedInformations(param1);
            if (this.powerLevel < 0)
            {
                throw new Error("Forbidden value (" + this.powerLevel + ") on element powerLevel.");
            }
            param1.writeByte(this.powerLevel);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightMutantInformations(param1);
            return;
        }// end function

        public function deserializeAs_GameFightMutantInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.powerLevel = param1.readByte();
            if (this.powerLevel < 0)
            {
                throw new Error("Forbidden value (" + this.powerLevel + ") on element of GameFightMutantInformations.powerLevel.");
            }
            return;
        }// end function

    }
}
