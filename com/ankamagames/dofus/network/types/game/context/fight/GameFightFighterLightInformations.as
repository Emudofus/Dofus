package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class GameFightFighterLightInformations implements INetworkType 
    {

        public static const protocolId:uint = 413;

        public var id:int = 0;
        public var wave:uint = 0;
        public var level:uint = 0;
        public var breed:int = 0;
        public var sex:Boolean = false;
        public var alive:Boolean = false;


        public function getTypeId():uint
        {
            return (413);
        }

        public function initGameFightFighterLightInformations(id:int=0, wave:uint=0, level:uint=0, breed:int=0, sex:Boolean=false, alive:Boolean=false):GameFightFighterLightInformations
        {
            this.id = id;
            this.wave = wave;
            this.level = level;
            this.breed = breed;
            this.sex = sex;
            this.alive = alive;
            return (this);
        }

        public function reset():void
        {
            this.id = 0;
            this.wave = 0;
            this.level = 0;
            this.breed = 0;
            this.sex = false;
            this.alive = false;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameFightFighterLightInformations(output);
        }

        public function serializeAs_GameFightFighterLightInformations(output:ICustomDataOutput):void
        {
            var _box0:uint;
            _box0 = BooleanByteWrapper.setFlag(_box0, 0, this.sex);
            _box0 = BooleanByteWrapper.setFlag(_box0, 1, this.alive);
            output.writeByte(_box0);
            output.writeInt(this.id);
            if (this.wave < 0)
            {
                throw (new Error((("Forbidden value (" + this.wave) + ") on element wave.")));
            };
            output.writeByte(this.wave);
            if (this.level < 0)
            {
                throw (new Error((("Forbidden value (" + this.level) + ") on element level.")));
            };
            output.writeVarShort(this.level);
            output.writeByte(this.breed);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightFighterLightInformations(input);
        }

        public function deserializeAs_GameFightFighterLightInformations(input:ICustomDataInput):void
        {
            var _box0:uint = input.readByte();
            this.sex = BooleanByteWrapper.getFlag(_box0, 0);
            this.alive = BooleanByteWrapper.getFlag(_box0, 1);
            this.id = input.readInt();
            this.wave = input.readByte();
            if (this.wave < 0)
            {
                throw (new Error((("Forbidden value (" + this.wave) + ") on element of GameFightFighterLightInformations.wave.")));
            };
            this.level = input.readVarUhShort();
            if (this.level < 0)
            {
                throw (new Error((("Forbidden value (" + this.level) + ") on element of GameFightFighterLightInformations.level.")));
            };
            this.breed = input.readByte();
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.fight

