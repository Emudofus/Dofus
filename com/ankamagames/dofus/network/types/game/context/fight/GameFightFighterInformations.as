package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class GameFightFighterInformations extends GameContextActorInformations implements INetworkType 
    {

        public static const protocolId:uint = 143;

        public var teamId:uint = 2;
        public var wave:uint = 0;
        public var alive:Boolean = false;
        public var stats:GameFightMinimalStats;
        public var previousPositions:Vector.<uint>;

        public function GameFightFighterInformations()
        {
            this.stats = new GameFightMinimalStats();
            this.previousPositions = new Vector.<uint>();
            super();
        }

        override public function getTypeId():uint
        {
            return (143);
        }

        public function initGameFightFighterInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, teamId:uint=2, wave:uint=0, alive:Boolean=false, stats:GameFightMinimalStats=null, previousPositions:Vector.<uint>=null):GameFightFighterInformations
        {
            super.initGameContextActorInformations(contextualId, look, disposition);
            this.teamId = teamId;
            this.wave = wave;
            this.alive = alive;
            this.stats = stats;
            this.previousPositions = previousPositions;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.teamId = 2;
            this.wave = 0;
            this.alive = false;
            this.stats = new GameFightMinimalStats();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameFightFighterInformations(output);
        }

        public function serializeAs_GameFightFighterInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_GameContextActorInformations(output);
            output.writeByte(this.teamId);
            if (this.wave < 0)
            {
                throw (new Error((("Forbidden value (" + this.wave) + ") on element wave.")));
            };
            output.writeByte(this.wave);
            output.writeBoolean(this.alive);
            output.writeShort(this.stats.getTypeId());
            this.stats.serialize(output);
            output.writeShort(this.previousPositions.length);
            var _i5:uint;
            while (_i5 < this.previousPositions.length)
            {
                if ((((this.previousPositions[_i5] < 0)) || ((this.previousPositions[_i5] > 559))))
                {
                    throw (new Error((("Forbidden value (" + this.previousPositions[_i5]) + ") on element 5 (starting at 1) of previousPositions.")));
                };
                output.writeVarShort(this.previousPositions[_i5]);
                _i5++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightFighterInformations(input);
        }

        public function deserializeAs_GameFightFighterInformations(input:ICustomDataInput):void
        {
            var _val5:uint;
            super.deserialize(input);
            this.teamId = input.readByte();
            if (this.teamId < 0)
            {
                throw (new Error((("Forbidden value (" + this.teamId) + ") on element of GameFightFighterInformations.teamId.")));
            };
            this.wave = input.readByte();
            if (this.wave < 0)
            {
                throw (new Error((("Forbidden value (" + this.wave) + ") on element of GameFightFighterInformations.wave.")));
            };
            this.alive = input.readBoolean();
            var _id4:uint = input.readUnsignedShort();
            this.stats = ProtocolTypeManager.getInstance(GameFightMinimalStats, _id4);
            this.stats.deserialize(input);
            var _previousPositionsLen:uint = input.readUnsignedShort();
            var _i5:uint;
            while (_i5 < _previousPositionsLen)
            {
                _val5 = input.readVarUhShort();
                if ((((_val5 < 0)) || ((_val5 > 559))))
                {
                    throw (new Error((("Forbidden value (" + _val5) + ") on elements of previousPositions.")));
                };
                this.previousPositions.push(_val5);
                _i5++;
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.fight

