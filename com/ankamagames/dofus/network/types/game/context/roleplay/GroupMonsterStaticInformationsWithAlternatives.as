package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    public class GroupMonsterStaticInformationsWithAlternatives extends GroupMonsterStaticInformations implements INetworkType 
    {

        public static const protocolId:uint = 396;

        public var alternatives:Vector.<AlternativeMonstersInGroupLightInformations>;

        public function GroupMonsterStaticInformationsWithAlternatives()
        {
            this.alternatives = new Vector.<AlternativeMonstersInGroupLightInformations>();
            super();
        }

        override public function getTypeId():uint
        {
            return (396);
        }

        public function initGroupMonsterStaticInformationsWithAlternatives(mainCreatureLightInfos:MonsterInGroupLightInformations=null, underlings:Vector.<MonsterInGroupInformations>=null, alternatives:Vector.<AlternativeMonstersInGroupLightInformations>=null):GroupMonsterStaticInformationsWithAlternatives
        {
            super.initGroupMonsterStaticInformations(mainCreatureLightInfos, underlings);
            this.alternatives = alternatives;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.alternatives = new Vector.<AlternativeMonstersInGroupLightInformations>();
        }

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_GroupMonsterStaticInformationsWithAlternatives(output);
        }

        public function serializeAs_GroupMonsterStaticInformationsWithAlternatives(output:IDataOutput):void
        {
            super.serializeAs_GroupMonsterStaticInformations(output);
            output.writeShort(this.alternatives.length);
            var _i1:uint;
            while (_i1 < this.alternatives.length)
            {
                (this.alternatives[_i1] as AlternativeMonstersInGroupLightInformations).serializeAs_AlternativeMonstersInGroupLightInformations(output);
                _i1++;
            };
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_GroupMonsterStaticInformationsWithAlternatives(input);
        }

        public function deserializeAs_GroupMonsterStaticInformationsWithAlternatives(input:IDataInput):void
        {
            var _item1:AlternativeMonstersInGroupLightInformations;
            super.deserialize(input);
            var _alternativesLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _alternativesLen)
            {
                _item1 = new AlternativeMonstersInGroupLightInformations();
                _item1.deserialize(input);
                this.alternatives.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay

