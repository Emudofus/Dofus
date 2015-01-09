package com.ankamagames.dofus.internalDatacenter.conquest
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.dofus.misc.EntityLookAdapter;

    public class PrismFightersWrapper implements IDataCenter 
    {

        public var playerCharactersInformations:CharacterMinimalPlusLookInformations;
        public var entityLook:TiphonEntityLook;


        public static function create(pFightersInformations:CharacterMinimalPlusLookInformations):PrismFightersWrapper
        {
            var item:PrismFightersWrapper = new (PrismFightersWrapper)();
            item.playerCharactersInformations = pFightersInformations;
            if (pFightersInformations.entityLook != null)
            {
                item.entityLook = EntityLookAdapter.getRiderLook(pFightersInformations.entityLook);
            };
            return (item);
        }


    }
}//package com.ankamagames.dofus.internalDatacenter.conquest

