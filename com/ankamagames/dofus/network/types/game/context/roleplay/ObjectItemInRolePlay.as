package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectItemInRolePlay extends Object implements INetworkType
    {
        public var cellId:uint = 0;
        public var objectGID:uint = 0;
        public static const protocolId:uint = 198;

        public function ObjectItemInRolePlay()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 198;
        }// end function

        public function initObjectItemInRolePlay(param1:uint = 0, param2:uint = 0) : ObjectItemInRolePlay
        {
            this.cellId = param1;
            this.objectGID = param2;
            return this;
        }// end function

        public function reset() : void
        {
            this.cellId = 0;
            this.objectGID = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ObjectItemInRolePlay(param1);
            return;
        }// end function

        public function serializeAs_ObjectItemInRolePlay(param1:IDataOutput) : void
        {
            if (this.cellId < 0 || this.cellId > 559)
            {
                throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
            }
            param1.writeShort(this.cellId);
            if (this.objectGID < 0)
            {
                throw new Error("Forbidden value (" + this.objectGID + ") on element objectGID.");
            }
            param1.writeShort(this.objectGID);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectItemInRolePlay(param1);
            return;
        }// end function

        public function deserializeAs_ObjectItemInRolePlay(param1:IDataInput) : void
        {
            this.cellId = param1.readShort();
            if (this.cellId < 0 || this.cellId > 559)
            {
                throw new Error("Forbidden value (" + this.cellId + ") on element of ObjectItemInRolePlay.cellId.");
            }
            this.objectGID = param1.readShort();
            if (this.objectGID < 0)
            {
                throw new Error("Forbidden value (" + this.objectGID + ") on element of ObjectItemInRolePlay.objectGID.");
            }
            return;
        }// end function

    }
}
