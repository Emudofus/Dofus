package com.ankamagames.dofus.network.types.game.actions.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AbstractFightDispellableEffect implements INetworkType 
    {

        public static const protocolId:uint = 206;

        public var uid:uint = 0;
        public var targetId:int = 0;
        public var turnDuration:int = 0;
        public var dispelable:uint = 1;
        public var spellId:uint = 0;
        public var effectId:uint = 0;
        public var parentBoostUid:uint = 0;


        public function getTypeId():uint
        {
            return (206);
        }

        public function initAbstractFightDispellableEffect(uid:uint=0, targetId:int=0, turnDuration:int=0, dispelable:uint=1, spellId:uint=0, effectId:uint=0, parentBoostUid:uint=0):AbstractFightDispellableEffect
        {
            this.uid = uid;
            this.targetId = targetId;
            this.turnDuration = turnDuration;
            this.dispelable = dispelable;
            this.spellId = spellId;
            this.effectId = effectId;
            this.parentBoostUid = parentBoostUid;
            return (this);
        }

        public function reset():void
        {
            this.uid = 0;
            this.targetId = 0;
            this.turnDuration = 0;
            this.dispelable = 1;
            this.spellId = 0;
            this.effectId = 0;
            this.parentBoostUid = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_AbstractFightDispellableEffect(output);
        }

        public function serializeAs_AbstractFightDispellableEffect(output:ICustomDataOutput):void
        {
            if (this.uid < 0)
            {
                throw (new Error((("Forbidden value (" + this.uid) + ") on element uid.")));
            };
            output.writeVarInt(this.uid);
            output.writeInt(this.targetId);
            output.writeShort(this.turnDuration);
            output.writeByte(this.dispelable);
            if (this.spellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.spellId) + ") on element spellId.")));
            };
            output.writeVarShort(this.spellId);
            if (this.effectId < 0)
            {
                throw (new Error((("Forbidden value (" + this.effectId) + ") on element effectId.")));
            };
            output.writeVarInt(this.effectId);
            if (this.parentBoostUid < 0)
            {
                throw (new Error((("Forbidden value (" + this.parentBoostUid) + ") on element parentBoostUid.")));
            };
            output.writeVarInt(this.parentBoostUid);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AbstractFightDispellableEffect(input);
        }

        public function deserializeAs_AbstractFightDispellableEffect(input:ICustomDataInput):void
        {
            this.uid = input.readVarUhInt();
            if (this.uid < 0)
            {
                throw (new Error((("Forbidden value (" + this.uid) + ") on element of AbstractFightDispellableEffect.uid.")));
            };
            this.targetId = input.readInt();
            this.turnDuration = input.readShort();
            this.dispelable = input.readByte();
            if (this.dispelable < 0)
            {
                throw (new Error((("Forbidden value (" + this.dispelable) + ") on element of AbstractFightDispellableEffect.dispelable.")));
            };
            this.spellId = input.readVarUhShort();
            if (this.spellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.spellId) + ") on element of AbstractFightDispellableEffect.spellId.")));
            };
            this.effectId = input.readVarUhInt();
            if (this.effectId < 0)
            {
                throw (new Error((("Forbidden value (" + this.effectId) + ") on element of AbstractFightDispellableEffect.effectId.")));
            };
            this.parentBoostUid = input.readVarUhInt();
            if (this.parentBoostUid < 0)
            {
                throw (new Error((("Forbidden value (" + this.parentBoostUid) + ") on element of AbstractFightDispellableEffect.parentBoostUid.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.actions.fight

