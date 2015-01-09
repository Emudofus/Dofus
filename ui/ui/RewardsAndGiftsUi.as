package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.DataApi;
    import d2api.QuestApi;
    import d2api.UtilApi;
    import d2api.PlayedCharacterApi;
    import d2api.SocialApi;
    import d2api.ContextMenuApi;
    import d2api.AveragePricesApi;
    import flash.utils.Dictionary;
    import d2components.Grid;
    import d2components.GraphicContainer;
    import d2components.ButtonContainer;
    import d2components.Label;
    import d2components.Texture;
    import d2data.AchievementCategory;
    import d2network.GuildMember;
    import d2hooks.AchievementRewardSuccess;
    import d2hooks.GuildInformationsMemberUpdate;
    import d2hooks.GiftAssigned;
    import d2hooks.GiftsWaitingAllocation;
    import d2enums.ComponentHookList;
    import d2data.ItemWrapper;
    import d2data.EmoteWrapper;
    import d2data.SpellWrapper;
    import d2data.TitleWrapper;
    import d2data.OrnamentWrapper;
    import d2network.AchievementRewardable;
    import d2data.Achievement;
    import d2data.AchievementReward;
    import d2actions.AchievementRewardRequest;
    import d2actions.GiftAssignAllRequest;
    import d2actions.GiftAssignRequest;
    import d2actions.OpenBook;
    import d2enums.LocationEnum;
    import d2hooks.*;
    import d2actions.*;

    public class RewardsAndGiftsUi 
    {

        private const TYPE_ACHIEVEMENT_REWARD:int = 0;
        private const TYPE_GIFT:int = 1;

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var dataApi:DataApi;
        public var questApi:QuestApi;
        public var utilApi:UtilApi;
        public var playerApi:PlayedCharacterApi;
        public var socialApi:SocialApi;
        public var menuApi:ContextMenuApi;
        public var averagePricesApi:AveragePricesApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        private var _componentDict:Dictionary;
        private var _achievementCategories:Array;
        private var _myGuildXp:int;
        public var gd_rewardsAndGifts:Grid;
        public var ctr_bottom:GraphicContainer;
        public var btn_acceptAll:ButtonContainer;
        public var btn_close:ButtonContainer;
        public var lbl_remains:Label;
        public var tx_generalBg:Texture;
        public var tx_gridBg:Texture;
        public var tx_gridFg:Texture;

        public function RewardsAndGiftsUi()
        {
            this._componentDict = new Dictionary(true);
            this._achievementCategories = new Array();
            super();
        }

        public function main(param:Object=null):void
        {
            var cat:AchievementCategory;
            var meMember:GuildMember;
            var myId:int;
            var mem:GuildMember;
            this.sysApi.addHook(AchievementRewardSuccess, this.onAchievementRewardSuccess);
            this.sysApi.addHook(GuildInformationsMemberUpdate, this.onGuildInformationsMemberUpdate);
            this.sysApi.addHook(GiftAssigned, this.onGiftAssigned);
            this.sysApi.addHook(GiftsWaitingAllocation, this.onGiftsWaitingAllocation);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.uiApi.addComponentHook(this.btn_acceptAll, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_acceptAll, ComponentHookList.ON_ROLL_OUT);
            if (this.socialApi.hasGuild())
            {
                myId = this.playerApi.id();
                for each (mem in this.socialApi.getGuildMembers())
                {
                    if (mem.id == myId)
                    {
                        meMember = mem;
                        break;
                    };
                };
                this._myGuildXp = meMember.experienceGivenPercent;
            };
            for each (cat in this.dataApi.getAchievementCategories())
            {
                this._achievementCategories[cat.id] = cat;
            };
            this.updateList(true);
        }

        public function unload():void
        {
            this.uiApi.hideTooltip();
        }

        public function updateAchievementLine(data:*, compRef:*, selected:Boolean):void
        {
            var rewardsSlotContent:Array;
            var i:int;
            var rewardId:uint;
            var item:ItemWrapper;
            var emote:EmoteWrapper;
            var spell:SpellWrapper;
            var title:TitleWrapper;
            var ornament:OrnamentWrapper;
            if (data)
            {
                compRef.lbl_title.text = data.title;
                compRef.lbl_category.text = data.subtitle;
                if (data.type == this.TYPE_ACHIEVEMENT_REWARD)
                {
                    compRef.lbl_title.handCursor = true;
                }
                else
                {
                    compRef.lbl_title.handCursor = false;
                };
                if (data.kamas > 0)
                {
                    compRef.lbl_rewardsKama.text = this.utilApi.formateIntToString(data.kamas);
                }
                else
                {
                    compRef.lbl_rewardsKama.text = "0";
                };
                if (data.xp > 0)
                {
                    compRef.lbl_rewardsXp.text = this.utilApi.formateIntToString(data.xp);
                }
                else
                {
                    compRef.lbl_rewardsXp.text = "0";
                };
                rewardsSlotContent = new Array();
                if (data.rewardData)
                {
                    i = 0;
                    while (i < data.rewardData.itemsReward.length)
                    {
                        if ((data.rewardData.itemsReward[i] is int))
                        {
                            item = this.dataApi.getItemWrapper(data.rewardData.itemsReward[i], 0, 0, data.rewardData.itemsQuantityReward[i]);
                            rewardsSlotContent.push(item);
                        }
                        else
                        {
                            rewardsSlotContent.push((data.rewardData.itemsReward[i] as ItemWrapper));
                        };
                        i++;
                    };
                    for each (rewardId in data.rewardData.emotesReward)
                    {
                        emote = this.dataApi.getEmoteWrapper(rewardId);
                        rewardsSlotContent.push(emote);
                    };
                    for each (rewardId in data.rewardData.spellsReward)
                    {
                        spell = this.dataApi.getSpellWrapper(rewardId);
                        rewardsSlotContent.push(spell);
                    };
                    for each (rewardId in data.rewardData.titlesReward)
                    {
                        title = this.dataApi.getTitleWrapper(rewardId);
                        rewardsSlotContent.push(title);
                    };
                    for each (rewardId in data.rewardData.ornamentsReward)
                    {
                        ornament = this.dataApi.getOrnamentWrapper(rewardId);
                        rewardsSlotContent.push(ornament);
                    };
                };
                compRef.gd_rewards.dataProvider = rewardsSlotContent;
                if (!(this._componentDict[compRef.gd_rewards.name]))
                {
                    this.uiApi.addComponentHook(compRef.gd_rewards, ComponentHookList.ON_ITEM_ROLL_OVER);
                    this.uiApi.addComponentHook(compRef.gd_rewards, ComponentHookList.ON_ITEM_ROLL_OUT);
                };
                this._componentDict[compRef.gd_rewards.name] = data;
                if (!(this._componentDict[compRef.btn_acceptOne.name]))
                {
                    this.uiApi.addComponentHook(compRef.btn_acceptOne, ComponentHookList.ON_RELEASE);
                    this.uiApi.addComponentHook(compRef.btn_acceptOne, ComponentHookList.ON_ROLL_OVER);
                    this.uiApi.addComponentHook(compRef.btn_acceptOne, ComponentHookList.ON_ROLL_OUT);
                };
                this._componentDict[compRef.btn_acceptOne.name] = data;
                if (data.type == this.TYPE_ACHIEVEMENT_REWARD)
                {
                    if (!(this._componentDict[compRef.lbl_title.name]))
                    {
                        this.uiApi.addComponentHook(compRef.lbl_title, ComponentHookList.ON_RELEASE);
                    };
                    this._componentDict[compRef.lbl_title.name] = data.id;
                };
                compRef.ctr_achievement.visible = true;
            }
            else
            {
                compRef.ctr_achievement.visible = false;
            };
        }

        public function updateList(firstOpening:Boolean=false):void
        {
            var reward:Object;
            var gift:Object;
            var content:Object;
            var rewardable:AchievementRewardable;
            var ach:Achievement;
            var cat:AchievementCategory;
            var rewardId:int;
            var r:AchievementReward;
            var nbLineToRemove:int;
            var lineHeight:int;
            var oldLength:int = this.gd_rewardsAndGifts.dataProvider.length;
            var dp:Array = new Array();
            var giftsList:Object = this.playerApi.getWaitingGifts();
            if (giftsList.length > 0)
            {
                for each (gift in giftsList)
                {
                    content = {"itemsReward":gift.items};
                    reward = {
                        "title":gift.title,
                        "subtitle":this.uiApi.getText("ui.shop.article"),
                        "rewardData":content,
                        "kamas":0,
                        "xp":0,
                        "id":gift.uid,
                        "type":this.TYPE_GIFT
                    };
                    dp.push(reward);
                };
            };
            var apiRewardablesList:Object = this.questApi.getRewardableAchievements();
            if (apiRewardablesList.length > 0)
            {
                for each (rewardable in apiRewardablesList)
                {
                    ach = this.dataApi.getAchievement(rewardable.id);
                    cat = ach.category;
                    if (cat.parentId != 0)
                    {
                        cat = this._achievementCategories[cat.parentId];
                    };
                    reward = {
                        "title":ach.name,
                        "subtitle":cat.name,
                        "rewardData":null,
                        "kamas":0,
                        "xp":0,
                        "id":rewardable.id,
                        "type":this.TYPE_ACHIEVEMENT_REWARD
                    };
                    for each (rewardId in ach.rewardIds)
                    {
                        r = this.dataApi.getAchievementReward(rewardId);
                        if (r)
                        {
                            if ((((((r.levelMin == -1)) || ((r.levelMin <= rewardable.finishedlevel)))) && ((((r.levelMax >= rewardable.finishedlevel)) || ((r.levelMax == -1))))))
                            {
                                reward.rewardData = r;
                                break;
                            };
                        };
                    };
                    reward.kamas = this.questApi.getAchievementKamasReward(ach, rewardable.finishedlevel);
                    reward.xp = this.questApi.getAchievementExperienceReward(ach, rewardable.finishedlevel);
                    dp.push(reward);
                };
            };
            if (dp.length == 0)
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
                return;
            };
            if ((((dp.length <= 4)) && (((firstOpening) || (!((dp.length == oldLength)))))))
            {
                nbLineToRemove = (4 - dp.length);
                lineHeight = int(this.uiApi.me().getConstant("height_line"));
                this.tx_generalBg.height = (int(this.uiApi.me().getConstant("height_tx_generalBg")) - (nbLineToRemove * lineHeight));
                this.tx_gridBg.height = (int(this.uiApi.me().getConstant("height_tx_gridBg")) - (nbLineToRemove * lineHeight));
                this.tx_gridFg.height = this.tx_gridBg.height;
                this.gd_rewardsAndGifts.height = (int(this.uiApi.me().getConstant("height_grid")) - (nbLineToRemove * lineHeight));
                this.ctr_bottom.y = (int(this.uiApi.me().getConstant("y_bottom")) - (nbLineToRemove * lineHeight));
            }
            else
            {
                this.ctr_bottom.y = int(this.uiApi.me().getConstant("y_bottom"));
            };
            this.gd_rewardsAndGifts.dataProvider = dp;
            this.lbl_remains.text = this.uiApi.processText(this.uiApi.getText("ui.achievement.rewardsRemaining", dp.length), "n", (dp.length <= 1));
        }

        private function getMountPercentXp():int
        {
            var xpRatio:int;
            if (((((!((this.playerApi.getMount() == null))) && (this.playerApi.isRidding()))) && ((this.playerApi.getMount().xpRatio > 0))))
            {
                xpRatio = this.playerApi.getMount().xpRatio;
            };
            return (xpRatio);
        }

        public function onAchievementRewardSuccess(achievementId:int):void
        {
            this.updateList();
        }

        private function onGiftAssigned(giftId:uint):void
        {
            this.updateList();
        }

        private function onGiftsWaitingAllocation(b:Boolean):void
        {
            if (b)
            {
                this.updateList();
            };
        }

        public function onGuildInformationsMemberUpdate(member:Object):void
        {
            if (member.id == this.playerApi.id())
            {
                this._myGuildXp = member.experienceGivenPercent;
            };
        }

        public function onRelease(target:Object):void
        {
            var _local_2:Object;
            switch (target)
            {
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_acceptAll:
                    this.sysApi.sendAction(new AchievementRewardRequest(-1));
                    this.sysApi.sendAction(new GiftAssignAllRequest(this.playerApi.id()));
                    break;
                default:
                    if (target.name.indexOf("btn_acceptOne") != -1)
                    {
                        _local_2 = this._componentDict[target.name];
                        if (_local_2.type == this.TYPE_ACHIEVEMENT_REWARD)
                        {
                            this.sysApi.sendAction(new AchievementRewardRequest(_local_2.id));
                        }
                        else
                        {
                            if (_local_2.type == this.TYPE_GIFT)
                            {
                                this.sysApi.sendAction(new GiftAssignRequest(_local_2.id, this.playerApi.id()));
                            };
                        };
                    }
                    else
                    {
                        if (target.name.indexOf("lbl_title") != -1)
                        {
                            _local_2 = new Object();
                            _local_2.achievementId = this._componentDict[target.name];
                            _local_2.forceOpen = true;
                            this.sysApi.sendAction(new OpenBook("achievementTab", _local_2));
                        };
                    };
            };
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            var pos:Object = {
                "point":LocationEnum.POINT_BOTTOM,
                "relativePoint":LocationEnum.POINT_TOP
            };
            if (target.name.indexOf("btn_acceptOne") != -1)
            {
                text = this.uiApi.getText("ui.achievement.rewardsGet");
            };
            var myMountXp:int = this.getMountPercentXp();
            if ((((((target == this.btn_acceptAll)) && (myMountXp))) || (this._myGuildXp)))
            {
                text = this.uiApi.getText("ui.popup.warning");
            };
            if (myMountXp)
            {
                text = (text + ("\n" + this.uiApi.getText("ui.achievement.mountXpPercent", myMountXp)));
            };
            if (this._myGuildXp)
            {
                text = (text + ("\n" + this.uiApi.getText("ui.achievement.guildXpPercent", this._myGuildXp)));
            };
            if (text)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", pos.point, pos.relativePoint, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onItemRightClick(target:Object, item:Object):void
        {
            var data:Object;
            var contextMenu:Object;
            if (((item.data) && (!((target.name.indexOf("gd_rewards") == -1)))))
            {
                data = item.data;
                if ((((data == null)) || (!((data is ItemWrapper)))))
                {
                    return;
                };
                contextMenu = this.menuApi.create(data);
                if (contextMenu.content.length > 0)
                {
                    this.modContextMenu.createContextMenu(contextMenu);
                };
            };
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            var text:String;
            var pos:Object;
            if (((item.data) && (!((target.name.indexOf("gd_rewards") == -1)))))
            {
                pos = {
                    "point":LocationEnum.POINT_BOTTOM,
                    "relativePoint":LocationEnum.POINT_TOP
                };
                if ((item.data is ItemWrapper))
                {
                    text = item.data.name;
                    text = (text + this.averagePricesApi.getItemAveragePriceString(item.data, true));
                }
                else
                {
                    if ((item.data is EmoteWrapper))
                    {
                        text = this.uiApi.getText("ui.common.emote", item.data.emote.name);
                    }
                    else
                    {
                        if ((item.data is SpellWrapper))
                        {
                            text = this.uiApi.getText("ui.common.spell", item.data.spell.name);
                        }
                        else
                        {
                            if ((item.data is TitleWrapper))
                            {
                                text = this.uiApi.getText("ui.common.title", item.data.title.name);
                            }
                            else
                            {
                                if ((item.data is OrnamentWrapper))
                                {
                                    text = this.uiApi.getText("ui.common.ornament", item.data.name);
                                };
                            };
                        };
                    };
                };
                if (text)
                {
                    this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", pos.point, pos.relativePoint, 3, null, null, null, "TextInfo");
                };
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "closeUi":
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    return (true);
            };
            return (false);
        }


    }
}//package ui

