package d2api
{
    import d2data.SpouseWrapper;
    import d2data.GuildWrapper;
    import d2data.GuildFactSheetWrapper;
    import d2data.TaxCollectorWrapper;
    import d2data.SocialEntityInFightWrapper;
    import d2data.AllianceWrapper;
    import d2data.PrismSubAreaWrapper;
    import d2data.BasicChatSentence;

    public class SocialApi 
    {


        [Trusted]
        public function destroy():void
        {
        }

        [Untrusted]
        public function getFriendsList():Object
        {
            return (null);
        }

        [Untrusted]
        public function isFriend(playerName:String):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getEnemiesList():Object
        {
            return (null);
        }

        [Untrusted]
        public function isEnemy(playerName:String):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getIgnoredList():Object
        {
            return (null);
        }

        [Untrusted]
        public function isIgnored(name:String, accountId:int=0):Boolean
        {
            return (false);
        }

        [Trusted]
        public function getAccountName(name:String):String
        {
            return (null);
        }

        [Untrusted]
        public function getWarnOnFriendConnec():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getWarnOnMemberConnec():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getWarnWhenFriendOrGuildMemberLvlUp():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getWarnWhenFriendOrGuildMemberAchieve():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getWarnOnHardcoreDeath():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getSpouse():SpouseWrapper
        {
            return (null);
        }

        [Untrusted]
        public function hasSpouse():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getAllowedGuildEmblemSymbolCategories():int
        {
            return (0);
        }

        [Untrusted]
        public function hasGuild():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getGuild():GuildWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getGuildMembers():Object
        {
            return (null);
        }

        [Untrusted]
        public function getGuildRights():Object
        {
            return (null);
        }

        [Untrusted]
        public function getGuildByid(id:int):GuildFactSheetWrapper
        {
            return (null);
        }

        [Untrusted]
        public function hasGuildRight(pPlayerId:uint, pRightId:String):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getGuildHouses():Object
        {
            return (null);
        }

        [Untrusted]
        public function guildHousesUpdateNeeded():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getGuildPaddocks():Object
        {
            return (null);
        }

        [Untrusted]
        public function getMaxGuildPaddocks():int
        {
            return (0);
        }

        [Untrusted]
        public function isGuildNameInvalid():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getMaxCollectorCount():uint
        {
            return (0);
        }

        [Untrusted]
        public function getTaxCollectors():Object
        {
            return (null);
        }

        [Untrusted]
        public function getTaxCollector(id:int):TaxCollectorWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getGuildFightingTaxCollectors():Object
        {
            return (null);
        }

        [Untrusted]
        public function getGuildFightingTaxCollector(pFightId:uint):SocialEntityInFightWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getAllFightingTaxCollectors():Object
        {
            return (null);
        }

        [Untrusted]
        public function getAllFightingTaxCollector(pFightId:uint):SocialEntityInFightWrapper
        {
            return (null);
        }

        [Untrusted]
        public function isPlayerDefender(pType:int, pPlayerId:uint, pSocialFightId:int):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function hasAlliance():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getAlliance():AllianceWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getAllianceById(id:int):AllianceWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getAllianceGuilds():Object
        {
            return (null);
        }

        [Untrusted]
        public function isAllianceNameInvalid():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isAllianceTagInvalid():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getPrismSubAreaById(id:int):PrismSubAreaWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getFightingPrisms():Object
        {
            return (null);
        }

        [Untrusted]
        public function getFightingPrism(pFightId:uint):SocialEntityInFightWrapper
        {
            return (null);
        }

        [Untrusted]
        public function isPlayerPrismDefender(pPlayerId:uint, pSubAreaId:int):Boolean
        {
            return (false);
        }

        [Trusted]
        public function getChatSentence(timestamp:Number, fingerprint:String):BasicChatSentence
        {
            return (null);
        }


    }
}//package d2api

