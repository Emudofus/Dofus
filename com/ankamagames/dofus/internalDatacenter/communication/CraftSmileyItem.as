package com.ankamagames.dofus.internalDatacenter.communication
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;

    public class CraftSmileyItem implements IDataCenter 
    {

        public var playerId:int;
        public var iconId:int;
        public var craftResult:uint;

        public function CraftSmileyItem(pPlayerId:uint, pIconId:int, pCraftResult:uint)
        {
            this.playerId = pPlayerId;
            this.iconId = pIconId;
            this.craftResult = pCraftResult;
        }

    }
}//package com.ankamagames.dofus.internalDatacenter.communication

