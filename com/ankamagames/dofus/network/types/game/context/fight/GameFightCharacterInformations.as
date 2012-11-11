package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.dofus.network.types.game.character.alignment.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightCharacterInformations extends GameFightFighterNamedInformations implements INetworkType
    {
        public var level:uint = 0;
        public var alignmentInfos:ActorAlignmentInformations;
        public var breed:int = 0;
        public static const protocolId:uint = 46;

        public function GameFightCharacterInformations()
        {
            this.alignmentInfos = new ActorAlignmentInformations();
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 46;
        }// end function

        public function initGameFightCharacterInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:uint = 2, param5:Boolean = false, param6:GameFightMinimalStats = null, param7:String = "", param8:uint = 0, param9:ActorAlignmentInformations = null, param10:int = 0) : GameFightCharacterInformations
        {
            super.initGameFightFighterNamedInformations(param1, param2, param3, param4, param5, param6, param7);
            this.level = param8;
            this.alignmentInfos = param9;
            this.breed = param10;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.level = 0;
            this.alignmentInfos = new ActorAlignmentInformations();
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameFightCharacterInformations(param1);
            return;
        }// end function

        public function serializeAs_GameFightCharacterInformations(param1:IDataOutput) : void
        {
            super.serializeAs_GameFightFighterNamedInformations(param1);
            if (this.level < 0)
            {
                throw new Error("Forbidden value (" + this.level + ") on element level.");
            }
            param1.writeShort(this.level);
            this.alignmentInfos.serializeAs_ActorAlignmentInformations(param1);
            param1.writeByte(this.breed);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightCharacterInformations(param1);
            return;
        }// end function

        public function deserializeAs_GameFightCharacterInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.level = param1.readShort();
            if (this.level < 0)
            {
                throw new Error("Forbidden value (" + this.level + ") on element of GameFightCharacterInformations.level.");
            }
            this.alignmentInfos = new ActorAlignmentInformations();
            this.alignmentInfos.deserialize(param1);
            this.breed = param1.readByte();
            return;
        }// end function

    }
}
