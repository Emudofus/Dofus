package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MonsterInGroupInformations extends Object implements INetworkType
    {
        public var creatureGenericId:int = 0;
        public var grade:uint = 0;
        public var look:EntityLook;
        public static const protocolId:uint = 144;

        public function MonsterInGroupInformations()
        {
            this.look = new EntityLook();
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 144;
        }// end function

        public function initMonsterInGroupInformations(param1:int = 0, param2:uint = 0, param3:EntityLook = null) : MonsterInGroupInformations
        {
            this.creatureGenericId = param1;
            this.grade = param2;
            this.look = param3;
            return this;
        }// end function

        public function reset() : void
        {
            this.creatureGenericId = 0;
            this.grade = 0;
            this.look = new EntityLook();
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_MonsterInGroupInformations(param1);
            return;
        }// end function

        public function serializeAs_MonsterInGroupInformations(param1:IDataOutput) : void
        {
            param1.writeInt(this.creatureGenericId);
            if (this.grade < 0)
            {
                throw new Error("Forbidden value (" + this.grade + ") on element grade.");
            }
            param1.writeByte(this.grade);
            this.look.serializeAs_EntityLook(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MonsterInGroupInformations(param1);
            return;
        }// end function

        public function deserializeAs_MonsterInGroupInformations(param1:IDataInput) : void
        {
            this.creatureGenericId = param1.readInt();
            this.grade = param1.readByte();
            if (this.grade < 0)
            {
                throw new Error("Forbidden value (" + this.grade + ") on element of MonsterInGroupInformations.grade.");
            }
            this.look = new EntityLook();
            this.look.deserialize(param1);
            return;
        }// end function

    }
}
