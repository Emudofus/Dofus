package d2api
{
    import d2data.FighterInformations;
    import d2data.Spell;
    import d2data.EffectsWrapper;
    import d2data.EffectsListWrapper;
    import d2network.CharacterCharacteristicsInformations;

    public class FightApi 
    {


        [Trusted]
        public function destroy():void
        {
        }

        [Untrusted]
        public function getFighterInformations(fighterId:int):FighterInformations
        {
            return (null);
        }

        [Untrusted]
        public function getFighterName(fighterId:int):String
        {
            return (null);
        }

        [Untrusted]
        public function getFighterLevel(fighterId:int):uint
        {
            return (0);
        }

        [Untrusted]
        public function getFighters():Object
        {
            return (null);
        }

        [Untrusted]
        public function getMonsterId(id:int):int
        {
            return (0);
        }

        [Untrusted]
        public function getDeadFighters():Object
        {
            return (null);
        }

        [Untrusted]
        public function getFightType():uint
        {
            return (0);
        }

        [Untrusted]
        public function getBuffList(targetId:int):Object
        {
            return (null);
        }

        [Untrusted]
        public function getBuffById(buffId:uint, playerId:int):Object
        {
            return (null);
        }

        [Untrusted]
        public function createEffectsWrapper(spell:Spell, effects:Object, name:String):EffectsWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getCastingSpellBuffEffects(targetId:int, castingSpellId:uint):EffectsWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getAllBuffEffects(targetId:int):EffectsListWrapper
        {
            return (null);
        }

        [Untrusted]
        public function isCastingSpell():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function cancelSpell():void
        {
        }

        [Untrusted]
        public function getChallengeList():Object
        {
            return (null);
        }

        [Untrusted]
        public function getCurrentPlayedFighterId():int
        {
            return (0);
        }

        [Untrusted]
        public function getPlayingFighterId():int
        {
            return (0);
        }

        [Untrusted]
        public function isCompanion(pFighterId:int):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getCurrentPlayedCharacteristicsInformations():CharacterCharacteristicsInformations
        {
            return (null);
        }

        [Untrusted]
        public function preFightIsActive():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isWaitingBeforeFight():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isFightLeader():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isSpectator():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isDematerializated():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getTurnsCount():int
        {
            return (0);
        }

        [Untrusted]
        public function getFighterStatus(fighterId:uint):int
        {
            return (0);
        }

        [Untrusted]
        public function isMouseOverFighter(fighterId:int):Boolean
        {
            return (false);
        }


    }
}//package d2api

