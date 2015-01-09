package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.character.alignment.ActorAlignmentInformations;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class GameFightCharacterInformations extends GameFightFighterNamedInformations implements INetworkType 
    {

        public static const protocolId:uint = 46;

        public var level:uint = 0;
        public var alignmentInfos:ActorAlignmentInformations;
        public var breed:int = 0;
        public var sex:Boolean = false;

        public function GameFightCharacterInformations()
        {
            this.alignmentInfos = new ActorAlignmentInformations();
            super();
        }

        override public function getTypeId():uint
        {
            return (46);
        }

        public function initGameFightCharacterInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, teamId:uint=2, wave:uint=0, alive:Boolean=false, stats:GameFightMinimalStats=null, previousPositions:Vector.<uint>=null, name:String="", status:PlayerStatus=null, level:uint=0, alignmentInfos:ActorAlignmentInformations=null, breed:int=0, sex:Boolean=false):GameFightCharacterInformations
        {
            super.initGameFightFighterNamedInformations(contextualId, look, disposition, teamId, wave, alive, stats, previousPositions, name, status);
            this.level = level;
            this.alignmentInfos = alignmentInfos;
            this.breed = breed;
            this.sex = sex;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.level = 0;
            this.alignmentInfos = new ActorAlignmentInformations();
            this.sex = false;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameFightCharacterInformations(output);
        }

        public function serializeAs_GameFightCharacterInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_GameFightFighterNamedInformations(output);
            if ((((this.level < 0)) || ((this.level > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.level) + ") on element level.")));
            };
            output.writeByte(this.level);
            this.alignmentInfos.serializeAs_ActorAlignmentInformations(output);
            output.writeByte(this.breed);
            output.writeBoolean(this.sex);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightCharacterInformations(input);
        }

        public function deserializeAs_GameFightCharacterInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.level = input.readUnsignedByte();
            if ((((this.level < 0)) || ((this.level > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.level) + ") on element of GameFightCharacterInformations.level.")));
            };
            this.alignmentInfos = new ActorAlignmentInformations();
            this.alignmentInfos.deserialize(input);
            this.breed = input.readByte();
            this.sex = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.fight

