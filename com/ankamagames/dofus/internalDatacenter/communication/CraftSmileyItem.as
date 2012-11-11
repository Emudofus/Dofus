package com.ankamagames.dofus.internalDatacenter.communication
{
    import com.ankamagames.jerakine.interfaces.*;

    public class CraftSmileyItem extends Object implements IDataCenter
    {
        public var playerId:int;
        public var iconId:int;
        public var craftResult:uint;

        public function CraftSmileyItem(param1:uint, param2:int, param3:uint)
        {
            this.playerId = param1;
            this.iconId = param2;
            this.craftResult = param3;
            return;
        }// end function

    }
}
