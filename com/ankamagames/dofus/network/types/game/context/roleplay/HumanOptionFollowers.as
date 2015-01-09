package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.look.IndexedEntityLook;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class HumanOptionFollowers extends HumanOption implements INetworkType 
    {

        public static const protocolId:uint = 410;

        public var followingCharactersLook:Vector.<IndexedEntityLook>;

        public function HumanOptionFollowers()
        {
            this.followingCharactersLook = new Vector.<IndexedEntityLook>();
            super();
        }

        override public function getTypeId():uint
        {
            return (410);
        }

        public function initHumanOptionFollowers(followingCharactersLook:Vector.<IndexedEntityLook>=null):HumanOptionFollowers
        {
            this.followingCharactersLook = followingCharactersLook;
            return (this);
        }

        override public function reset():void
        {
            this.followingCharactersLook = new Vector.<IndexedEntityLook>();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_HumanOptionFollowers(output);
        }

        public function serializeAs_HumanOptionFollowers(output:ICustomDataOutput):void
        {
            super.serializeAs_HumanOption(output);
            output.writeShort(this.followingCharactersLook.length);
            var _i1:uint;
            while (_i1 < this.followingCharactersLook.length)
            {
                (this.followingCharactersLook[_i1] as IndexedEntityLook).serializeAs_IndexedEntityLook(output);
                _i1++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HumanOptionFollowers(input);
        }

        public function deserializeAs_HumanOptionFollowers(input:ICustomDataInput):void
        {
            var _item1:IndexedEntityLook;
            super.deserialize(input);
            var _followingCharactersLookLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _followingCharactersLookLen)
            {
                _item1 = new IndexedEntityLook();
                _item1.deserialize(input);
                this.followingCharactersLook.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay

