package com.ankamagames.dofus.network.types.game.interactive
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class InteractiveElementNamedSkill extends InteractiveElementSkill implements INetworkType 
    {

        public static const protocolId:uint = 220;

        public var nameId:uint = 0;


        override public function getTypeId():uint
        {
            return (220);
        }

        public function initInteractiveElementNamedSkill(skillId:uint=0, skillInstanceUid:uint=0, nameId:uint=0):InteractiveElementNamedSkill
        {
            super.initInteractiveElementSkill(skillId, skillInstanceUid);
            this.nameId = nameId;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.nameId = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_InteractiveElementNamedSkill(output);
        }

        public function serializeAs_InteractiveElementNamedSkill(output:ICustomDataOutput):void
        {
            super.serializeAs_InteractiveElementSkill(output);
            if (this.nameId < 0)
            {
                throw (new Error((("Forbidden value (" + this.nameId) + ") on element nameId.")));
            };
            output.writeVarInt(this.nameId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_InteractiveElementNamedSkill(input);
        }

        public function deserializeAs_InteractiveElementNamedSkill(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.nameId = input.readVarUhInt();
            if (this.nameId < 0)
            {
                throw (new Error((("Forbidden value (" + this.nameId) + ") on element of InteractiveElementNamedSkill.nameId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.interactive

