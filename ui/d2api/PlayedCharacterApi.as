package d2api
{
    import d2network.CharacterCharacteristicsInformations;
    import d2data.Title;
    import d2data.Ornament;
    import d2network.GameRolePlayCharacterInformations;
    import d2network.ActorRestrictionsInformations;
    import d2data.SpellWrapper;
    import d2data.WorldPointWrapper;
    import d2data.SubArea;
    import d2data.WeaponWrapper;

    public class PlayedCharacterApi 
    {


        [Untrusted]
        public function characteristics():CharacterCharacteristicsInformations
        {
            return (null);
        }

        [Untrusted]
        public function getPlayedCharacterInfo():Object
        {
            return (null);
        }

        [Untrusted]
        public function getCurrentEntityLook():Object
        {
            return (null);
        }

        [Untrusted]
        public function getInventory():Object
        {
            return (null);
        }

        [Untrusted]
        public function getEquipment():Object
        {
            return (null);
        }

        [Untrusted]
        public function getSpellInventory():Object
        {
            return (null);
        }

        [Untrusted]
        public function getJobs():Object
        {
            return (null);
        }

        [Untrusted]
        public function getMount():Object
        {
            return (null);
        }

        [Untrusted]
        public function getTitle():Title
        {
            return (null);
        }

        [Untrusted]
        public function getOrnament():Ornament
        {
            return (null);
        }

        [Untrusted]
        public function getKnownTitles():Object
        {
            return (null);
        }

        [Untrusted]
        public function getKnownOrnaments():Object
        {
            return (null);
        }

        [Untrusted]
        public function titlesOrnamentsAskedBefore():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getEntityInfos():GameRolePlayCharacterInformations
        {
            return (null);
        }

        [Untrusted]
        public function getEntityTooltipInfos():Object
        {
            return (null);
        }

        [Untrusted]
        public function inventoryWeight():uint
        {
            return (0);
        }

        [Untrusted]
        public function inventoryWeightMax():uint
        {
            return (0);
        }

        [Untrusted]
        public function isIncarnation():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isMutated():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isInHouse():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isInExchange():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isInFight():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isInPreFight():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isInParty():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isPartyLeader():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isRidding():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isPetsMounting():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function hasCompanion():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function id():uint
        {
            return (0);
        }

        [Untrusted]
        public function restrictions():ActorRestrictionsInformations
        {
            return (null);
        }

        [Untrusted]
        public function isMutant():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function publicMode():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function artworkId():int
        {
            return (0);
        }

        [Untrusted]
        public function isCreature():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getBone():uint
        {
            return (0);
        }

        [Untrusted]
        public function getSkin():uint
        {
            return (0);
        }

        [Untrusted]
        public function getColors():Object
        {
            return (null);
        }

        [Untrusted]
        public function getSubentityColors():Object
        {
            return (null);
        }

        [Untrusted]
        public function getAlignmentSide():int
        {
            return (0);
        }

        [Untrusted]
        public function getAlignmentValue():uint
        {
            return (0);
        }

        [Untrusted]
        public function getAlignmentAggressableStatus():uint
        {
            return (0);
        }

        [Untrusted]
        public function getAlignmentGrade():uint
        {
            return (0);
        }

        [Untrusted]
        public function getMaxSummonedCreature():uint
        {
            return (0);
        }

        [Untrusted]
        public function getCurrentSummonedCreature():uint
        {
            return (0);
        }

        [Untrusted]
        public function canSummon():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getSpell(spellId:uint):SpellWrapper
        {
            return (null);
        }

        [Untrusted]
        public function canCastThisSpell(spellId:uint, lvl:uint):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function canCastThisSpellOnTarget(spellId:uint, lvl:uint, pTargetId:int):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getSpellModification(spellId:uint, carac:int):int
        {
            return (0);
        }

        [Untrusted]
        public function isInHisHouse():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getPlayerHouses():Object
        {
            return (null);
        }

        [Untrusted]
        public function currentMap():WorldPointWrapper
        {
            return (null);
        }

        [Untrusted]
        public function currentSubArea():SubArea
        {
            return (null);
        }

        [Untrusted]
        public function state():uint
        {
            return (0);
        }

        [Untrusted]
        public function isAlive():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getFollowingPlayerId():int
        {
            return (0);
        }

        [Untrusted]
        public function getPlayerSet(objectGID:uint):Object
        {
            return (null);
        }

        [Untrusted]
        public function getWeapon():WeaponWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getExperienceBonusPercent():int
        {
            return (0);
        }

        [Untrusted]
        public function getWaitingGifts():Object
        {
            return (null);
        }

        [Untrusted]
        public function knowSpell(pSpellId:uint):int
        {
            return (0);
        }


    }
}//package d2api

