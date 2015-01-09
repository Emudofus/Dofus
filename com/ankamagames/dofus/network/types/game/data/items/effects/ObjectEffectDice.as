package com.ankamagames.dofus.network.types.game.data.items.effects
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ObjectEffectDice extends ObjectEffect implements INetworkType 
    {

        public static const protocolId:uint = 73;

        public var diceNum:uint = 0;
        public var diceSide:uint = 0;
        public var diceConst:uint = 0;


        override public function getTypeId():uint
        {
            return (73);
        }

        public function initObjectEffectDice(actionId:uint=0, diceNum:uint=0, diceSide:uint=0, diceConst:uint=0):ObjectEffectDice
        {
            super.initObjectEffect(actionId);
            this.diceNum = diceNum;
            this.diceSide = diceSide;
            this.diceConst = diceConst;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.diceNum = 0;
            this.diceSide = 0;
            this.diceConst = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ObjectEffectDice(output);
        }

        public function serializeAs_ObjectEffectDice(output:ICustomDataOutput):void
        {
            super.serializeAs_ObjectEffect(output);
            if (this.diceNum < 0)
            {
                throw (new Error((("Forbidden value (" + this.diceNum) + ") on element diceNum.")));
            };
            output.writeVarShort(this.diceNum);
            if (this.diceSide < 0)
            {
                throw (new Error((("Forbidden value (" + this.diceSide) + ") on element diceSide.")));
            };
            output.writeVarShort(this.diceSide);
            if (this.diceConst < 0)
            {
                throw (new Error((("Forbidden value (" + this.diceConst) + ") on element diceConst.")));
            };
            output.writeVarShort(this.diceConst);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ObjectEffectDice(input);
        }

        public function deserializeAs_ObjectEffectDice(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.diceNum = input.readVarUhShort();
            if (this.diceNum < 0)
            {
                throw (new Error((("Forbidden value (" + this.diceNum) + ") on element of ObjectEffectDice.diceNum.")));
            };
            this.diceSide = input.readVarUhShort();
            if (this.diceSide < 0)
            {
                throw (new Error((("Forbidden value (" + this.diceSide) + ") on element of ObjectEffectDice.diceSide.")));
            };
            this.diceConst = input.readVarUhShort();
            if (this.diceConst < 0)
            {
                throw (new Error((("Forbidden value (" + this.diceConst) + ") on element of ObjectEffectDice.diceConst.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.data.items.effects

