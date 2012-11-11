package com.ankamagames.dofus.internalDatacenter.people
{
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class IgnoredWrapper extends Object implements IDataCenter
    {
        public var name:String = "";
        public var id:uint;
        public var state:int;
        public var lastConnection:uint = 0;
        public var online:Boolean = true;
        public var type:String = "Ignored";
        public var playerName:String = "";
        public var breed:uint = 0;
        public var sex:uint = 2;
        public var level:int = 0;
        public var alignmentSide:int = -1;
        public var guildName:String = "";

        public function IgnoredWrapper(param1:String, param2:uint)
        {
            this.state = PlayerStateEnum.GAME_TYPE_ROLEPLAY;
            this.name = param1;
            this.id = param2;
            return;
        }// end function

    }
}
