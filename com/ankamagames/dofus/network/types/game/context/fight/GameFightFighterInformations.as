package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightFighterInformations extends GameContextActorInformations implements INetworkType
    {
        public var teamId:uint = 2;
        public var alive:Boolean = false;
        public var stats:GameFightMinimalStats;
        public static const protocolId:uint = 143;

        public function GameFightFighterInformations()
        {
            this.stats = new GameFightMinimalStats();
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 143;
        }// end function

        public function initGameFightFighterInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:uint = 2, param5:Boolean = false, param6:GameFightMinimalStats = null) : GameFightFighterInformations
        {
            super.initGameContextActorInformations(param1, param2, param3);
            this.teamId = param4;
            this.alive = param5;
            this.stats = param6;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.teamId = 2;
            this.alive = false;
            this.stats = new GameFightMinimalStats();
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameFightFighterInformations(param1);
            return;
        }// end function

        public function serializeAs_GameFightFighterInformations(param1:IDataOutput) : void
        {
            super.serializeAs_GameContextActorInformations(param1);
            param1.writeByte(this.teamId);
            param1.writeBoolean(this.alive);
            param1.writeShort(this.stats.getTypeId());
            this.stats.serialize(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightFighterInformations(param1);
            return;
        }// end function

        public function deserializeAs_GameFightFighterInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.teamId = param1.readByte();
            if (this.teamId < 0)
            {
                throw new Error("Forbidden value (" + this.teamId + ") on element of GameFightFighterInformations.teamId.");
            }
            this.alive = param1.readBoolean();
            var _loc_2:* = param1.readUnsignedShort();
            this.stats = ProtocolTypeManager.getInstance(GameFightMinimalStats, _loc_2);
            this.stats.deserialize(param1);
            return;
        }// end function

    }
}
