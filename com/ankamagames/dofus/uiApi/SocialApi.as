package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.berilia.types.data.UiModule;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
    import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
    import com.ankamagames.dofus.internalDatacenter.people.FriendWrapper;
    import com.ankamagames.dofus.internalDatacenter.people.EnemyWrapper;
    import com.ankamagames.dofus.internalDatacenter.people.IgnoredWrapper;
    import com.ankamagames.dofus.internalDatacenter.people.SpouseWrapper;
    import com.ankamagames.dofus.logic.game.common.frames.PlayedCharacterUpdatesFrame;
    import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.guild.GuildMember;
    import com.ankamagames.dofus.internalDatacenter.guild.GuildFactSheetWrapper;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.logic.game.common.managers.TaxCollectorsManager;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.internalDatacenter.guild.TaxCollectorWrapper;
    import com.ankamagames.dofus.internalDatacenter.guild.SocialEntityInFightWrapper;
    import com.ankamagames.dofus.internalDatacenter.guild.SocialFightersWrapper;
    import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
    import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
    import com.ankamagames.dofus.internalDatacenter.communication.BasicChatSentence;
    import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;

    [InstanciedApi]
    public class SocialApi implements IApi 
    {

        protected var _log:Logger;
        private var _module:UiModule;

        public function SocialApi()
        {
            this._log = Log.getLogger(getQualifiedClassName(SocialApi));
            super();
        }

        [ApiData(name="module")]
        public function set module(value:UiModule):void
        {
            this._module = value;
        }

        public function get socialFrame():SocialFrame
        {
            return ((Kernel.getWorker().getFrame(SocialFrame) as SocialFrame));
        }

        public function get allianceFrame():AllianceFrame
        {
            return ((Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame));
        }

        [Trusted]
        public function destroy():void
        {
            this._module = null;
        }

        [Untrusted]
        public function getFriendsList():Array
        {
            var friend:FriendWrapper;
            var fl:Array = new Array();
            var friendsList:Array = this.socialFrame.friendsList;
            for each (friend in friendsList)
            {
                fl.push(friend);
            };
            fl.sortOn("name", Array.CASEINSENSITIVE);
            return (fl);
        }

        [Untrusted]
        public function isFriend(playerName:String):Boolean
        {
            var friend:*;
            var friendsList:Array = this.socialFrame.friendsList;
            for each (friend in friendsList)
            {
                if (friend.playerName == playerName)
                {
                    return (true);
                };
            };
            return (false);
        }

        [Untrusted]
        public function getEnemiesList():Array
        {
            var enemy:EnemyWrapper;
            var el:Array = new Array();
            for each (enemy in this.socialFrame.enemiesList)
            {
                el.push(enemy);
            };
            el.sortOn("name", Array.CASEINSENSITIVE);
            return (el);
        }

        [Untrusted]
        public function isEnemy(playerName:String):Boolean
        {
            var enemy:*;
            for each (enemy in this.socialFrame.enemiesList)
            {
                if (enemy.playerName == playerName)
                {
                    return (true);
                };
            };
            return (false);
        }

        [Untrusted]
        public function getIgnoredList():Array
        {
            var ignored:IgnoredWrapper;
            var il:Array = new Array();
            for each (ignored in this.socialFrame.ignoredList)
            {
                il.push(ignored);
            };
            il.sortOn("name", Array.CASEINSENSITIVE);
            return (il);
        }

        [Untrusted]
        public function isIgnored(name:String, accountId:int=0):Boolean
        {
            return (this.socialFrame.isIgnored(name, accountId));
        }

        [Trusted]
        public function getAccountName(name:String):String
        {
            return (name);
        }

        [Untrusted]
        public function getWarnOnFriendConnec():Boolean
        {
            return (this.socialFrame.warnFriendConnec);
        }

        [Untrusted]
        public function getWarnOnMemberConnec():Boolean
        {
            return (this.socialFrame.warnMemberConnec);
        }

        [Untrusted]
        public function getWarnWhenFriendOrGuildMemberLvlUp():Boolean
        {
            return (this.socialFrame.warnWhenFriendOrGuildMemberLvlUp);
        }

        [Untrusted]
        public function getWarnWhenFriendOrGuildMemberAchieve():Boolean
        {
            return (this.socialFrame.warnWhenFriendOrGuildMemberAchieve);
        }

        [Untrusted]
        public function getWarnOnHardcoreDeath():Boolean
        {
            return (this.socialFrame.warnOnHardcoreDeath);
        }

        [Untrusted]
        public function getSpouse():SpouseWrapper
        {
            return (this.socialFrame.spouse);
        }

        [Untrusted]
        public function hasSpouse():Boolean
        {
            return (this.socialFrame.hasSpouse);
        }

        [Untrusted]
        public function getAllowedGuildEmblemSymbolCategories():int
        {
            var playerFrame:PlayedCharacterUpdatesFrame = (Kernel.getWorker().getFrame(PlayedCharacterUpdatesFrame) as PlayedCharacterUpdatesFrame);
            return (playerFrame.guildEmblemSymbolCategories);
        }

        [Untrusted]
        public function hasGuild():Boolean
        {
            return (this.socialFrame.hasGuild);
        }

        [Untrusted]
        public function getGuild():GuildWrapper
        {
            return (this.socialFrame.guild);
        }

        [Untrusted]
        public function getGuildMembers():Vector.<GuildMember>
        {
            return (this.socialFrame.guildmembers);
        }

        [Untrusted]
        public function getGuildRights():Array
        {
            return (GuildWrapper.guildRights);
        }

        [Untrusted]
        public function getGuildByid(id:int):GuildFactSheetWrapper
        {
            return (this.socialFrame.getGuildById(id));
        }

        [Untrusted]
        public function hasGuildRight(pPlayerId:uint, pRightId:String):Boolean
        {
            var member:GuildMember;
            var temporaryWrapper:GuildWrapper;
            if (!(this.socialFrame.hasGuild))
            {
                return (false);
            };
            if (pPlayerId == PlayedCharacterManager.getInstance().id)
            {
                return (this.socialFrame.guild.hasRight(pRightId));
            };
            for each (member in this.socialFrame.guildmembers)
            {
                if (member.id == pPlayerId)
                {
                    temporaryWrapper = GuildWrapper.create(0, "", null, member.rights, true);
                    return (temporaryWrapper.hasRight(pRightId));
                };
            };
            return (false);
        }

        [Untrusted]
        public function getGuildHouses():Object
        {
            return (this.socialFrame.guildHouses);
        }

        [Untrusted]
        public function guildHousesUpdateNeeded():Boolean
        {
            return (this.socialFrame.guildHousesUpdateNeeded);
        }

        [Untrusted]
        public function getGuildPaddocks():Object
        {
            return (this.socialFrame.guildPaddocks);
        }

        [Untrusted]
        public function getMaxGuildPaddocks():int
        {
            return (this.socialFrame.maxGuildPaddocks);
        }

        [Untrusted]
        public function isGuildNameInvalid():Boolean
        {
            if (this.socialFrame.guild)
            {
                return ((this.socialFrame.guild.realGuildName == "#NONAME#"));
            };
            return (false);
        }

        [Untrusted]
        public function getMaxCollectorCount():uint
        {
            return (TaxCollectorsManager.getInstance().maxTaxCollectorsCount);
        }

        [Untrusted]
        public function getTaxCollectors():Dictionary
        {
            return (TaxCollectorsManager.getInstance().taxCollectors);
        }

        [Untrusted]
        public function getTaxCollector(id:int):TaxCollectorWrapper
        {
            return (TaxCollectorsManager.getInstance().taxCollectors[id]);
        }

        [Untrusted]
        public function getGuildFightingTaxCollectors():Dictionary
        {
            return (TaxCollectorsManager.getInstance().guildTaxCollectorsFighters);
        }

        [Untrusted]
        public function getGuildFightingTaxCollector(pFightId:uint):SocialEntityInFightWrapper
        {
            return (TaxCollectorsManager.getInstance().guildTaxCollectorsFighters[pFightId]);
        }

        [Untrusted]
        public function getAllFightingTaxCollectors():Dictionary
        {
            return (TaxCollectorsManager.getInstance().allTaxCollectorsInPreFight);
        }

        [Untrusted]
        public function getAllFightingTaxCollector(pFightId:uint):SocialEntityInFightWrapper
        {
            return (TaxCollectorsManager.getInstance().allTaxCollectorsInPreFight[pFightId]);
        }

        [Untrusted]
        public function isPlayerDefender(pType:int, pPlayerId:uint, pSocialFightId:int):Boolean
        {
            var seifw:SocialEntityInFightWrapper;
            var defender:SocialFightersWrapper;
            if (pType == 0)
            {
                seifw = TaxCollectorsManager.getInstance().guildTaxCollectorsFighters[pSocialFightId];
                if (!(seifw))
                {
                    seifw = TaxCollectorsManager.getInstance().allTaxCollectorsInPreFight[pSocialFightId];
                };
            }
            else
            {
                if (pType == 1)
                {
                    seifw = TaxCollectorsManager.getInstance().prismsFighters[pSocialFightId];
                };
            };
            if (seifw)
            {
                for each (defender in seifw.allyCharactersInformations)
                {
                    if (defender.playerCharactersInformations.id == pPlayerId)
                    {
                        return (true);
                    };
                };
            };
            return (false);
        }

        [Untrusted]
        public function hasAlliance():Boolean
        {
            return (this.allianceFrame.hasAlliance);
        }

        [Untrusted]
        public function getAlliance():AllianceWrapper
        {
            return (this.allianceFrame.alliance);
        }

        [Untrusted]
        public function getAllianceById(id:int):AllianceWrapper
        {
            return (this.allianceFrame.getAllianceById(id));
        }

        [Untrusted]
        public function getAllianceGuilds():Vector.<GuildFactSheetWrapper>
        {
            return (this.allianceFrame.alliance.guilds);
        }

        [Untrusted]
        public function isAllianceNameInvalid():Boolean
        {
            if (this.allianceFrame.alliance)
            {
                return ((this.allianceFrame.alliance.realAllianceName == "#NONAME#"));
            };
            return (false);
        }

        [Untrusted]
        public function isAllianceTagInvalid():Boolean
        {
            if (this.allianceFrame.alliance)
            {
                return ((this.allianceFrame.alliance.realAllianceTag == "#TAG#"));
            };
            return (false);
        }

        [Untrusted]
        public function getPrismSubAreaById(id:int):PrismSubAreaWrapper
        {
            return (this.allianceFrame.getPrismSubAreaById(id));
        }

        [Untrusted]
        public function getFightingPrisms():Dictionary
        {
            return (TaxCollectorsManager.getInstance().prismsFighters);
        }

        [Untrusted]
        public function getFightingPrism(pFightId:uint):SocialEntityInFightWrapper
        {
            return (TaxCollectorsManager.getInstance().prismsFighters[pFightId]);
        }

        [Untrusted]
        public function isPlayerPrismDefender(pPlayerId:uint, pSubAreaId:int):Boolean
        {
            var defender:SocialFightersWrapper;
            var p:SocialEntityInFightWrapper = TaxCollectorsManager.getInstance().prismsFighters[pSubAreaId];
            if (p)
            {
                for each (defender in p.allyCharactersInformations)
                {
                    if (defender.playerCharactersInformations.id == pPlayerId)
                    {
                        return (true);
                    };
                };
            };
            return (false);
        }

        [Trusted]
        public function getChatSentence(timestamp:Number, fingerprint:String):BasicChatSentence
        {
            var channel:Array;
            var sentence:BasicChatSentence;
            var found:Boolean;
            var se:BasicChatSentence;
            var chatFrame:ChatFrame = (Kernel.getWorker().getFrame(ChatFrame) as ChatFrame);
            for each (channel in chatFrame.getMessages())
            {
                for each (sentence in channel)
                {
                    if ((((sentence.fingerprint == fingerprint)) && ((sentence.timestamp == timestamp))))
                    {
                        se = sentence;
                        found = true;
                        break;
                    };
                };
                if (found)
                {
                    break;
                };
            };
            return (se);
        }


    }
}//package com.ankamagames.dofus.uiApi

