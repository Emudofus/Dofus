package com.ankamagames.dofus.internalDatacenter.guild
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.dofus.misc.EntityLookAdapter;

    public class SocialFightersWrapper implements IDataCenter 
    {

        public var ally:uint;
        public var playerCharactersInformations:CharacterMinimalPlusLookInformations;
        public var entityLook:TiphonEntityLook;


        public static function create(pAlly:uint, pFightersInformations:CharacterMinimalPlusLookInformations):SocialFightersWrapper
        {
            var item:SocialFightersWrapper = new (SocialFightersWrapper)();
            item.ally = pAlly;
            item.playerCharactersInformations = pFightersInformations;
            if (pFightersInformations.entityLook != null)
            {
                item.entityLook = EntityLookAdapter.getRiderLook(pFightersInformations.entityLook);
            }
            else
            {
                trace("Le entityLook est null :(");
            };
            return (item);
        }


        public function update(pAlly:uint, pFightersInformations:CharacterMinimalPlusLookInformations):void
        {
            this.ally = pAlly;
            this.playerCharactersInformations = pFightersInformations;
            if (pFightersInformations.entityLook != null)
            {
                this.entityLook = EntityLookAdapter.getRiderLook(pFightersInformations.entityLook);
            }
            else
            {
                trace("Le entityLook est null :(");
            };
        }


    }
}//package com.ankamagames.dofus.internalDatacenter.guild

