package com.ankamagames.dofus.logic.game.roleplay.actions.estate
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PaddockToSellFilterAction implements Action 
    {

        public var areaId:int;
        public var atLeastNbMount:uint;
        public var atLeastNbMachine:uint;
        public var maxPrice:uint;


        public static function create(areaId:int, atLeastNbMount:uint, atLeastNbMachine:uint, maxPrice:uint):PaddockToSellFilterAction
        {
            var a:PaddockToSellFilterAction = new (PaddockToSellFilterAction)();
            a.areaId = areaId;
            a.atLeastNbMount = atLeastNbMount;
            a.atLeastNbMachine = atLeastNbMachine;
            a.maxPrice = maxPrice;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.actions.estate

