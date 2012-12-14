package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class HumanOptionFollowers extends HumanOption implements INetworkType
    {
        public var followingCharactersLook:Vector.<IndexedEntityLook>;
        public static const protocolId:uint = 410;

        public function HumanOptionFollowers()
        {
            this.followingCharactersLook = new Vector.<IndexedEntityLook>;
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 410;
        }// end function

        public function initHumanOptionFollowers(param1:Vector.<IndexedEntityLook> = null) : HumanOptionFollowers
        {
            this.followingCharactersLook = param1;
            return this;
        }// end function

        override public function reset() : void
        {
            this.followingCharactersLook = new Vector.<IndexedEntityLook>;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_HumanOptionFollowers(param1);
            return;
        }// end function

        public function serializeAs_HumanOptionFollowers(param1:IDataOutput) : void
        {
            super.serializeAs_HumanOption(param1);
            param1.writeShort(this.followingCharactersLook.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.followingCharactersLook.length)
            {
                
                (this.followingCharactersLook[_loc_2] as IndexedEntityLook).serializeAs_IndexedEntityLook(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_HumanOptionFollowers(param1);
            return;
        }// end function

        public function deserializeAs_HumanOptionFollowers(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            super.deserialize(param1);
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new IndexedEntityLook();
                _loc_4.deserialize(param1);
                this.followingCharactersLook.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
