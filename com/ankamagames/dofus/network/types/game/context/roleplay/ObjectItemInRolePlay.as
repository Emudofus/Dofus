package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ObjectItemInRolePlay implements INetworkType 
    {

        public static const protocolId:uint = 198;

        public var cellId:uint = 0;
        public var objectGID:uint = 0;


        public function getTypeId():uint
        {
            return (198);
        }

        public function initObjectItemInRolePlay(cellId:uint=0, objectGID:uint=0):ObjectItemInRolePlay
        {
            this.cellId = cellId;
            this.objectGID = objectGID;
            return (this);
        }

        public function reset():void
        {
            this.cellId = 0;
            this.objectGID = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ObjectItemInRolePlay(output);
        }

        public function serializeAs_ObjectItemInRolePlay(output:ICustomDataOutput):void
        {
            if ((((this.cellId < 0)) || ((this.cellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.cellId) + ") on element cellId.")));
            };
            output.writeVarShort(this.cellId);
            if (this.objectGID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectGID) + ") on element objectGID.")));
            };
            output.writeVarShort(this.objectGID);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ObjectItemInRolePlay(input);
        }

        public function deserializeAs_ObjectItemInRolePlay(input:ICustomDataInput):void
        {
            this.cellId = input.readVarUhShort();
            if ((((this.cellId < 0)) || ((this.cellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.cellId) + ") on element of ObjectItemInRolePlay.cellId.")));
            };
            this.objectGID = input.readVarUhShort();
            if (this.objectGID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectGID) + ") on element of ObjectItemInRolePlay.objectGID.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay

