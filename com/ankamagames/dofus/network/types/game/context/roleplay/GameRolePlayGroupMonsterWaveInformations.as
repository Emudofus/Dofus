package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    public class GameRolePlayGroupMonsterWaveInformations extends GameRolePlayGroupMonsterInformations implements INetworkType 
    {

        public static const protocolId:uint = 464;

        public var nbWaves:uint = 0;
        public var alternatives:Vector.<GroupMonsterStaticInformations>;

        public function GameRolePlayGroupMonsterWaveInformations()
        {
            this.alternatives = new Vector.<GroupMonsterStaticInformations>();
            super();
        }

        override public function getTypeId():uint
        {
            return (464);
        }

        public function initGameRolePlayGroupMonsterWaveInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, staticInfos:GroupMonsterStaticInformations=null, ageBonus:int=0, lootShare:int=0, alignmentSide:int=0, keyRingBonus:Boolean=false, hasHardcoreDrop:Boolean=false, hasAVARewardToken:Boolean=false, nbWaves:uint=0, alternatives:Vector.<GroupMonsterStaticInformations>=null):GameRolePlayGroupMonsterWaveInformations
        {
            super.initGameRolePlayGroupMonsterInformations(contextualId, look, disposition, staticInfos, ageBonus, lootShare, alignmentSide, keyRingBonus, hasHardcoreDrop, hasAVARewardToken);
            this.nbWaves = nbWaves;
            this.alternatives = alternatives;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.nbWaves = 0;
            this.alternatives = new Vector.<GroupMonsterStaticInformations>();
        }

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_GameRolePlayGroupMonsterWaveInformations(output);
        }

        public function serializeAs_GameRolePlayGroupMonsterWaveInformations(output:IDataOutput):void
        {
            super.serializeAs_GameRolePlayGroupMonsterInformations(output);
            if ((((this.nbWaves < 0)) || ((this.nbWaves > 0xFFFFFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.nbWaves) + ") on element nbWaves.")));
            };
            output.writeUnsignedInt(this.nbWaves);
            output.writeShort(this.alternatives.length);
            var _i2:uint;
            while (_i2 < this.alternatives.length)
            {
                (this.alternatives[_i2] as GroupMonsterStaticInformations).serializeAs_GroupMonsterStaticInformations(output);
                _i2++;
            };
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_GameRolePlayGroupMonsterWaveInformations(input);
        }

        public function deserializeAs_GameRolePlayGroupMonsterWaveInformations(input:IDataInput):void
        {
            var _item2:GroupMonsterStaticInformations;
            super.deserialize(input);
            this.nbWaves = input.readUnsignedInt();
            if ((((this.nbWaves < 0)) || ((this.nbWaves > 0xFFFFFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.nbWaves) + ") on element of GameRolePlayGroupMonsterWaveInformations.nbWaves.")));
            };
            var _alternativesLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _alternativesLen)
            {
                _item2 = new GroupMonsterStaticInformations();
                _item2.deserialize(input);
                this.alternatives.push(_item2);
                _i2++;
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay

