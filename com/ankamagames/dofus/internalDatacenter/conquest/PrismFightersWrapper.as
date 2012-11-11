package com.ankamagames.dofus.internalDatacenter.conquest
{
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.network.types.game.character.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.tiphon.types.look.*;

    public class PrismFightersWrapper extends Object implements IDataCenter
    {
        public var playerCharactersInformations:CharacterMinimalPlusLookAndGradeInformations;
        public var entityLook:TiphonEntityLook;

        public function PrismFightersWrapper()
        {
            return;
        }// end function

        public static function create(param1:CharacterMinimalPlusLookAndGradeInformations) : PrismFightersWrapper
        {
            var _loc_2:* = new PrismFightersWrapper;
            _loc_2.playerCharactersInformations = param1;
            if (param1.entityLook != null)
            {
                _loc_2.entityLook = EntityLookAdapter.getRiderLook(param1.entityLook);
            }
            return _loc_2;
        }// end function

    }
}
