package com.ankamagames.dofus.uiApi
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.internalDatacenter.communication.*;
    import com.ankamagames.dofus.internalDatacenter.guild.*;
    import com.ankamagames.dofus.internalDatacenter.people.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.types.game.guild.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class SocialApi extends Object implements IApi
    {
        protected var _log:Logger;
        private var _module:UiModule;

        public function SocialApi()
        {
            this._log = Log.getLogger(getQualifiedClassName(SocialApi));
            return;
        }// end function

        public function set module(param1:UiModule) : void
        {
            this._module = param1;
            return;
        }// end function

        public function get socialFrame() : SocialFrame
        {
            return Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
        }// end function

        public function destroy() : void
        {
            this._module = null;
            return;
        }// end function

        public function getFriendsList() : Array
        {
            var _loc_3:* = null;
            var _loc_1:* = new Array();
            var _loc_2:* = this.socialFrame.friendsList;
            for each (_loc_3 in _loc_2)
            {
                
                _loc_1.push(_loc_3);
            }
            _loc_1.sortOn("name", Array.CASEINSENSITIVE);
            return _loc_1;
        }// end function

        public function isFriend(param1:String) : Boolean
        {
            var _loc_3:* = undefined;
            var _loc_2:* = this.socialFrame.friendsList;
            for each (_loc_3 in _loc_2)
            {
                
                if (_loc_3.playerName == param1)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function getEnemiesList() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = new Array();
            for each (_loc_2 in this.socialFrame.enemiesList)
            {
                
                _loc_1.push(_loc_2);
            }
            _loc_1.sortOn("name", Array.CASEINSENSITIVE);
            return _loc_1;
        }// end function

        public function isEnemy(param1:String) : Boolean
        {
            var _loc_2:* = undefined;
            for each (_loc_2 in this.socialFrame.enemiesList)
            {
                
                if (_loc_2.playerName == param1)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function getIgnoredList() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = new Array();
            for each (_loc_2 in this.socialFrame.ignoredList)
            {
                
                _loc_1.push(_loc_2);
            }
            _loc_1.sortOn("name", Array.CASEINSENSITIVE);
            return _loc_1;
        }// end function

        public function isIgnored(param1:String) : Boolean
        {
            return this.socialFrame.isIgnored(param1);
        }// end function

        public function getAccountName(param1:String) : String
        {
            return param1;
        }// end function

        public function getWarnOnFriendConnec() : Boolean
        {
            return this.socialFrame.warnFriendConnec;
        }// end function

        public function getWarnOnMemberConnec() : Boolean
        {
            return this.socialFrame.warnMemberConnec;
        }// end function

        public function getWarnWhenFriendOrGuildMemberLvlUp() : Boolean
        {
            return this.socialFrame.warnWhenFriendOrGuildMemberLvlUp;
        }// end function

        public function getWarnWhenFriendOrGuildMemberAchieve() : Boolean
        {
            return this.socialFrame.warnWhenFriendOrGuildMemberAchieve;
        }// end function

        public function getSpouse() : SpouseWrapper
        {
            return this.socialFrame.spouse;
        }// end function

        public function hasSpouse() : Boolean
        {
            return this.socialFrame.hasSpouse;
        }// end function

        public function getAllowedGuildEmblemSymbolCategories() : int
        {
            var _loc_1:* = Kernel.getWorker().getFrame(PlayedCharacterUpdatesFrame) as PlayedCharacterUpdatesFrame;
            return _loc_1.guildEmblemSymbolCategories;
        }// end function

        public function hasGuild() : Boolean
        {
            return this.socialFrame.hasGuild;
        }// end function

        public function getGuild() : GuildWrapper
        {
            return this.socialFrame.guild;
        }// end function

        public function getGuildMembers() : Vector.<GuildMember>
        {
            return this.socialFrame.guildmembers;
        }// end function

        public function getGuildRights() : Array
        {
            return GuildWrapper.guildRights;
        }// end function

        public function hasGuildRight(param1:uint, param2:String) : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (!this.socialFrame.hasGuild)
            {
                return false;
            }
            if (param1 == PlayedCharacterManager.getInstance().id)
            {
                return this.socialFrame.guild.hasRight(param2);
            }
            for each (_loc_3 in this.socialFrame.guildmembers)
            {
                
                if (_loc_3.id == param1)
                {
                    _loc_4 = GuildWrapper.create(0, "", null, _loc_3.rights, true);
                    return _loc_4.hasRight(param2);
                }
            }
            return false;
        }// end function

        public function getGuildHouses() : Object
        {
            return this.socialFrame.guildHouses;
        }// end function

        public function getGuildPaddocks() : Object
        {
            return this.socialFrame.guildPaddocks;
        }// end function

        public function getMaxGuildPaddocks() : int
        {
            return this.socialFrame.maxGuildPaddocks;
        }// end function

        public function isGuildNameInvalid() : Boolean
        {
            if (this.socialFrame.guild)
            {
                return this.socialFrame.guild.realGuildName == "#NONAME#";
            }
            return false;
        }// end function

        public function getMaxCollectorCount() : uint
        {
            return TaxCollectorsManager.getInstance().maxTaxCollectorsCount;
        }// end function

        public function getTaxCollectorHireCost() : uint
        {
            return TaxCollectorsManager.getInstance().taxCollectorHireCost;
        }// end function

        public function getTaxCollectors() : Dictionary
        {
            return TaxCollectorsManager.getInstance().taxCollectors;
        }// end function

        public function getFightingTaxCollector(param1:uint) : TaxCollectorInFightWrapper
        {
            return TaxCollectorsManager.getInstance().taxCollectorsFighters[param1];
        }// end function

        public function isPlayerDefender(param1:uint, param2:int) : Boolean
        {
            var _loc_4:* = null;
            var _loc_3:* = TaxCollectorsManager.getInstance().taxCollectorsFighters[param2];
            if (_loc_3)
            {
                for each (_loc_4 in _loc_3.allyCharactersInformations)
                {
                    
                    if (_loc_4.playerCharactersInformations.id == param1)
                    {
                        return true;
                    }
                }
            }
            return false;
        }// end function

        public function getTaxCollectorFighters(param1:int) : Object
        {
            var _loc_2:* = TaxCollectorsManager.getInstance().taxCollectorsFighters[param1];
            return _loc_2;
        }// end function

        public function removeIgnoredPlayer(param1:String) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this.socialFrame.ignoredList.length)
            {
                
                _loc_3 = this.socialFrame.ignoredList[_loc_2];
                if (_loc_3.name == param1)
                {
                    this.socialFrame.ignoredList.splice(_loc_2, 1);
                    KernelEventsManager.getInstance().processCallback(SocialHookList.IgnoredRemoved);
                }
                _loc_2++;
            }
            return;
        }// end function

        public function getChatSentence(param1:Number, param2:String) : BasicChatSentence
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_3:* = false;
            var _loc_4:* = null;
            var _loc_5:* = Kernel.getWorker().getFrame(ChatFrame) as ChatFrame;
            for each (_loc_6 in _loc_5.getMessages())
            {
                
                for each (_loc_7 in _loc_6)
                {
                    
                    if (_loc_7.fingerprint == param2 && _loc_7.timestamp == param1)
                    {
                        _loc_4 = _loc_7;
                        _loc_3 = true;
                        break;
                    }
                }
                if (_loc_3)
                {
                    break;
                }
            }
            return _loc_4;
        }// end function

    }
}
