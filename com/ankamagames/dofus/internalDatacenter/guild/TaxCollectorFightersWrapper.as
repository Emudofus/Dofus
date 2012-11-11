package com.ankamagames.dofus.internalDatacenter.guild
{
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.network.types.game.character.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.tiphon.types.look.*;

    public class TaxCollectorFightersWrapper extends Object implements IDataCenter
    {
        public var ally:uint;
        public var playerCharactersInformations:CharacterMinimalPlusLookInformations;
        public var entityLook:TiphonEntityLook;

        public function TaxCollectorFightersWrapper()
        {
            return;
        }// end function

        public function update(param1:uint, param2:CharacterMinimalPlusLookInformations) : void
        {
            this.ally = param1;
            this.playerCharactersInformations = param2;
            if (param2.entityLook != null)
            {
                this.entityLook = EntityLookAdapter.getRiderLook(param2.entityLook);
                ;
            }
            return;
        }// end function

        public static function create(param1:uint, param2:CharacterMinimalPlusLookInformations) : TaxCollectorFightersWrapper
        {
            var _loc_3:* = new TaxCollectorFightersWrapper;
            _loc_3.ally = param1;
            _loc_3.playerCharactersInformations = param2;
            if (param2.entityLook != null)
            {
                _loc_3.entityLook = EntityLookAdapter.getRiderLook(param2.entityLook);
                ;
            }
            return _loc_3;
        }// end function

    }
}
