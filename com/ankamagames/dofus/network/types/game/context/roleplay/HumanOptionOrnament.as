package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class HumanOptionOrnament extends HumanOption implements INetworkType 
    {

        public static const protocolId:uint = 411;

        public var ornamentId:uint = 0;


        override public function getTypeId():uint
        {
            return (411);
        }

        public function initHumanOptionOrnament(ornamentId:uint=0):HumanOptionOrnament
        {
            this.ornamentId = ornamentId;
            return (this);
        }

        override public function reset():void
        {
            this.ornamentId = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_HumanOptionOrnament(output);
        }

        public function serializeAs_HumanOptionOrnament(output:ICustomDataOutput):void
        {
            super.serializeAs_HumanOption(output);
            if (this.ornamentId < 0)
            {
                throw (new Error((("Forbidden value (" + this.ornamentId) + ") on element ornamentId.")));
            };
            output.writeVarShort(this.ornamentId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HumanOptionOrnament(input);
        }

        public function deserializeAs_HumanOptionOrnament(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.ornamentId = input.readVarUhShort();
            if (this.ornamentId < 0)
            {
                throw (new Error((("Forbidden value (" + this.ornamentId) + ") on element of HumanOptionOrnament.ornamentId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay

